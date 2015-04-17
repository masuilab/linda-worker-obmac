request = require 'request'

module.exports = (linda) ->

  return unless /^https?:\/\/.+/.test linda.config.app.url

  setInterval ->
    linda.debug 'ping'
    url = "#{linda.config.app.url}?keepalive=#{Date.now()}"
    request.head url, (err, res) ->
      if !err and res.statusCode is 200
        linda.debug 'pong'
  , 60 * 1000 * 20  # 20 min
