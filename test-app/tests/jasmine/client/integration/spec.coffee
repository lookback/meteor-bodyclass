describe 'BodyClass', ->

  beforeEach waitForRouter

  describe 'Iron Router plugin', ->

    beforeEach ->
      Router.plugin 'bodyClasses'

    beforeEach (done) ->
      Router.go 'home'
      Tracker.afterFlush ->
        done()

    it 'adds the current template name as a class', (done) ->
      expect($('body')).toHaveClass 'home'

      Router.go 'sub'
      Tracker.afterFlush ->
        expect($('body')).toHaveClass 'sub'
        expect($('body')).not.toHaveClass 'home'
        done()

    it 'adds the current template and layout name as a class', (done) ->
      expect($('body')).toHaveClass 'home'

      Router.go 'layout'
      Tracker.afterFlush ->
        expect($('body')).toHaveClass 'defaultlayout layout'
        expect($('body')).not.toHaveClass 'home'
        done()

  describe 'run', ->

    beforeEach ->
      $('body').removeClass()

      Router.onAfterAction ->
        BodyClass.run()

    beforeEach (done) ->
      Router.go 'home'
      Tracker.afterFlush ->
        done()

    it 'adds the current template name as a class', (done) ->
      expect($('body')).toHaveClass 'home'

      Router.go 'sub'
      Tracker.afterFlush ->
        expect($('body')).toHaveClass 'sub'
        done()

    it 'adds the current layout name as a class', (done) ->

      Router.go 'layout'
      Tracker.afterFlush ->
        expect($('body')).toHaveClass 'defaultlayout'
        done()

    it 'adds the both current layout and template name as a class', (done) ->
      Router.go 'layout'
      Tracker.afterFlush ->
        expect($('body')).toHaveClass 'defaultlayout layout'
        done()

  describe 'cleanup', ->

    beforeEach (done) ->
      Router.go 'layout'
      Tracker.afterFlush ->
        done()

    it 'should clear old route classes on navigation', (done) ->
      expect($('body')).toHaveClass 'defaultlayout layout'

      Router.go 'home'

      Tracker.afterFlush ->
        expect($('body')).not.toHaveClass 'defaultlayout layout'
        done()
