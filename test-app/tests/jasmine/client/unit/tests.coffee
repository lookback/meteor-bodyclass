describe 'BodyClass', ->

  afterEach ->
    $('body').removeClass()

  it 'should be available', ->
    expect(BodyClass).toBeDefined()

  describe 'add', ->
    it 'should be able to add a class', ->
      BodyClass.add 'foo'
      expect($('body')).toHaveClass 'foo'

    it 'should be able to add an array of classes', ->
      BodyClass.add ['foo', 'bar']
      expect($('body')).toHaveClass 'foo bar'

    it 'should be able to add a function', ->
      BodyClass.add -> 'foo'
      expect($('body')).toHaveClass 'foo'

  describe 'config', ->

    it 'should be able to use an arbitrary element', ->
      BodyClass.config(element: 'html').add 'foo'

      expect($('html')).toHaveClass 'foo'
