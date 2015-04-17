# webhook sample.
# Receive HTTP Request then write a Tuple {type: 'webhook', value: query.msg}

module.exports = (linda) ->

  config = linda.config

  linda.debug "webhook URL => #{config.app.url}/webhook/sample?msg=helloworld"
  linda.debug "TupleSpace  => #{config.linda.url}/#{config.linda.space}"

  linda.router.get '/webhook/sample', (req, res) ->

    msg = req.query.msg
    unless msg
      res.status(400).end 'bad request, "msg" property is missing'
      return
    res.end "ok: #{msg}"

    linda.tuplespace(config.linda.space).write
      type: 'webhook'
      value: msg
