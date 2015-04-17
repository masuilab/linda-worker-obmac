'use strict'

unless process.env.DEBUG
  process.env.DEBUG = 'linda:worker*'

LindaClient = require('linda').Client
socketio    = require 'socket.io-client'
debug       = require('debug')('linda:worker')
path        = require 'path'

config     = require path.resolve 'config.json'
scripts    = require path.resolve 'libs', 'scripts'
httpserver = require path.resolve 'libs', 'httpserver'

config.linda.url ||= process.env.URL
debug config

## Scripts

scripts.load process.env.SCRIPT or '.+', (err, scripts) ->
  socket = socketio.connect config.linda.url

  for script in scripts
    debug "load script \"#{script.name}\""
    linda = new LindaClient().connect socket
    linda.config = config
    linda.router = httpserver.router
    linda.debug = require('debug')("linda:worker:#{script.name}")
    script.function(linda)

  linda = new LindaClient().connect socket

  linda.io.on 'connect', ->
    debug "socket.io connnect <#{config.linda.url}>"

  linda.io.on 'disconnect', ->
    debug "socket.io disconnect <#{config.linda.url}>"


## HTTP Server
httpserver.start process.env.PORT or 3000
