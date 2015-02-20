beforeEach ->
  jasmine.addMatchers
    toHaveClass: ->
      compare: (actual, expected) ->
        $el = actual

        expected = '' if expected is undefined

        result =
          pass: $el.hasClass(expected) is true

        if result.pass
          result.message = "Expected element to not include #{$el.attr 'class'}"
        else
          result.message = "Expected element to have class(es) #{expected}, got #{$el.attr 'class'}."

        return result
