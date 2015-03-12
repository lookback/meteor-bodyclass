Should = should()

describe 'BodyClass', ->

  beforeAll ->
    # Simple stubs
    window.Router = {}
    Router.current = ->
      lookupTemplate: ->
        'template'
      lookupOption: ->
        'layout'
      _layout:
        _template: 'layout'

  afterEach ->
    $('body, html').removeClass()

  it 'should be available', ->
    BodyClass.should.be.defined

  describe 'config', ->

    it 'should be able to use an arbitrary element', ->
      BodyClass.config(element: 'html').add 'foo'

      $('html').hasClass('foo').should.be.true
      # Restore
      BodyClass.settings.element = 'body'

  describe 'run', ->

    it 'should add a classes of the current template and layout', ->
      BodyClass.run()

      $('body').hasClass('layout template').should.be.true

    it 'should take additional classes as an array', ->
      BodyClass.run(classes: ['foo', 'bar'])
      $('body').hasClass('layout template foo bar').should.be.true

  describe 'cleanup', ->

    it 'should clean up router classes', ->
      BodyClass.cleanup()

      $('body').hasClass('layout template').should.be.false

  describe 'add', ->

    it 'should be able to add a class', ->
      BodyClass.add 'foo'
      $('body').hasClass('foo').should.be.true

    it 'should be able to add an array of classes', ->
      BodyClass.add ['foo', 'bar']
      $('body').hasClass('foo bar').should.be.true

    it 'should be able to add a function', ->
      BodyClass.add -> 'foo'
      $('body').hasClass('foo').should.be.true

    it 'should be able run function reactively', ->
      Session.set 'foo', 'bar'

      BodyClass.add ->
        Session.get 'foo'

      $('body').hasClass('bar').should.be.true

      Session.set 'foo', 'baz'

      Tracker.flush()
      $('body').hasClass('baz').should.be.true
      $('body').hasClass('bar').should.be.false
