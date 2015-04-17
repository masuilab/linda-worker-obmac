debug      = require('debug')('linda:worker:httpserver')
express    = require 'express'
bodyParser = require 'body-parser'

router = express()
router.disable 'x-powered-by'
router.use bodyParser.urlencoded(extended: true)

http = require('http').Server(router)

router.get '/', (err, res) ->
  res.end 'linda-worker'

module.exports =
  router: router
  start: (port) ->
    http.listen port
    debug "start - port:#{port}"
