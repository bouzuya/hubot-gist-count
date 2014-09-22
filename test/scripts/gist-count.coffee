{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'hello', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      setTimeout done, 10 # wait for parseHelp()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    describe 'valid patterns', ->
      beforeEach ->
        @tests = [
          message: '@hubot gist-count bouzuya'
          matches: ['@hubot gist-count bouzuya', 'bouzuya']
        ]

      it 'should match', ->
        @tests.forEach ({ message, matches }) =>
          callback = @sinon.spy()
          @robot.listeners[0].callback = callback
          sender = new User 'bouzuya', room: 'hitoridokusho'
          @robot.adapter.receive new TextMessage(sender, message)
          actualMatches = callback.firstCall.args[0].match.map((i) -> i)
          assert callback.callCount is 1
          assert.deepEqual actualMatches, matches

  describe 'listeners[0].callback', ->
    beforeEach ->
      @hello = @robot.listeners[0].callback

    describe 'receive "@hubot gist-count"', ->
      beforeEach ->
        responseBody = public_gists: 88
        httpGetResponse = @sinon.stub()
        httpGetResponse
          .onFirstCall()
          .callsArgWith 0, null, null, JSON.stringify(responseBody)
        httpGet = @sinon.stub()
        httpGet.onFirstCall().returns httpGetResponse
        http = @sinon.stub()
        http.onFirstCall().returns get: httpGet
        @send = @sinon.spy()
        @hello
          match: ['@hubot gist-count bouzuya', 'bouzuya']
          send: @send
          http: http

      it 'send "hello!"', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is 'https://gist.github.com/bouzuya (88)'

  describe 'robot.helpCommands()', ->
    it 'should be ["hubot gist-count <username> - count public gists"]', ->
      assert.deepEqual @robot.helpCommands(), [
        "hubot gist-count <username> - count public gists"
      ]
