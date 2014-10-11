{Adapter, TextMessage} = require 'hubot'
{EventEmitter} = require 'events'


class Devhub extends Adapter
  send: (envelope, strings...) ->
    @bot.send str for str in strings

  run: ->
    options =
      name:   process.env.HUBOT_DEVHUB_NAME
      url:   process.env.HUBOT_DEVHUB_URL

    @bot = new DevhubStreaming options, @robot

    @bot.on 'message', (userId, message) =>
      user = @robot.brain.userForId userId
      @receive new TextMessage user, message

    @bot.listen()
    @emit 'connected'

exports.use = (robot) ->
  new Devhub robot

class DevhubStreaming extends EventEmitter
  constructor: (options, @robot) ->
    @name = options.name
    client = require('socket.io-client');
    @socket = client.connect(options.url);


  send: (message) ->
    @socket.emit "message", {name:@name, msg:message}

  listen: ->
    @socket.on "message", (item)=>
      @emit 'message', item.name, item.msg
    @socket.emit 'name', {name:@name}
