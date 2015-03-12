routeClasses = ->
  ctrl = Router.current()
  _.chain([ctrl._layout._template, ctrl.lookupTemplate()])
    .compact()
    .invoke('toLowerCase')
    .value()

BodyClass =

  settings:
    element: 'body'
    classes: []

  config: (opts) ->
    _.extend(@settings, opts)
    return this

  add: (fn) ->
    unless Match.test fn, Match.OneOf(Array, String, Function)
      return console.warn 'BodyClass: Argument to "add" must be an array, string or function!'

    if Match.test fn, Array
      return fn.forEach(_.bind(BodyClass.add, BodyClass))

    if not Match.test fn, Function
      return Meteor.startup => $(@settings.element).addClass(fn)

    if Match.test fn, Function
      Meteor.startup =>
        Tracker.autorun =>
          $(@settings.element)
            .removeClass(fn._prev)
            .addClass(fn._prev = fn())

  run: (opts = {}) ->
    routes = routeClasses()
    classes = @settings.classes.concat(routes)

    if opts.classes
      classes = classes.concat(opts.classes)

    $(@settings.element).addClass(classes.join(' '))

  cleanup: ->
    routes = routeClasses()
    classes = @settings.classes.concat(routes)
    $(@settings.element).removeClass(classes.join(' '))


if Package['iron:router']?

  Iron.Router.plugins.bodyClasses = (router, options) ->
    router.onAfterAction ->
      BodyClass.run(options)
    , options

    router.onStop ->
      BodyClass.cleanup()
    , options
