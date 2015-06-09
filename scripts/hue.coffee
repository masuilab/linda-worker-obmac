async = require 'async'

Hue = require 'philips-hue'
confFile = process.env.HOME+'/.philips-hue.json'
hue = new Hue()

states = ['on', 'hue', 'sat', 'bri', 'effect', 'alert']

module.exports = (linda) ->
  config = linda.config

  linda.debug "loading config file #{confFile}"

  ts = linda.tuplespace(config.linda.space)

  linda.io.on 'connect', ->

    lightCount = 0
    hue.loadConfigFile confFile, (err, conf) ->
      linda.debug 'hue ready!'
      hue.lights (err, lights) ->
        return linda.debug err if err
        lightCount = Object.keys(lights).length
        linda.debug "#{lightCount} lights found"

    ts.watch {type: 'hue', 'where': config.where}, (err, tuple) ->
      return if tuple.data.response?
      linda.debug tuple

      state = {}
      for key in states
        if tuple.data[key]?
          state[key] = tuple.data[key]
          if key is 'on'
            state.on = {'true':true, 'false':false}[state.on]

      if tuple.data.light?
        hue.light(tuple.data.light-0).setState state, (err, res) ->
          return linda.debug "Error: #{JSON.stringify err}" if err
          linda.debug res
        return

      linda.debug 'async series'
      lights = [0...lightCount].map (i) -> hue.light(i)
      async.each lights, (light, done) ->
        light.setState state, done
      , (err, res) ->
        return linda.debug "Error: #{JSON.stringify err}" if err
        linda.debug res
