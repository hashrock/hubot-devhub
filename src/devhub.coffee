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

    @bot.on 'message', (userId, message, room_id) =>
      name_re = new RegExp("^[ ]*@" + options.name + "さん");
      message = message.replace(name_re, options.name)
      user = @robot.brain.userForId userId
      @bot.room_id = room_id
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
    @room_id = 1

  send: (message) ->
    @socket.emit "message", {name:@name, msg:message, room_id:@room_id, avatar:"img/hubot.png" }

  listen: ->
    @socket.on "message", (item)=>
      @emit 'message', item.name, item.msg, item.room_id
    @socket.emit 'name', {name:@name, avatar:"img/hubot.png"}
