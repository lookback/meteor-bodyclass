# Lookback Body Classes for Meteor

[![Circle CI](https://circleci.com/gh/lookback/meteor-bodyclass/tree/master.svg?style=svg)](https://circleci.com/gh/lookback/meteor-bodyclass/tree/master)

This package automatically adds classes on the `body` element (default) for the names of the current Iron Router template and layout used. It also reactively updates a class name returned from a function.

Having classes for templates and layouts are great (if not vital) for scoping with CSS and similar.

## Install

`lookback:body-class` is available on [Atmosphere](https://atmospherejs.com/lookback/body-class):

    meteor add lookback:body-class

## Usage

The package exports the `BodyClass` namespace on the client.

The `add` method adds a class to the body:
```js
// Adds a string, string array or result from a function to the body element.

BodyClass.add('some-class')
// => body.some-class
```

```js
BodyClass.add(['some-class', 'other-class'])
// => body.some-class.other-class
```
```js
Session.setDefault('state', 'foo');

BodyClass.add(function() {
  return Session.get('state');
});
// => body.foo

Session.set('state', 'bar');
// => body.bar
```

The `run` method adds the names of the current template and/or layout to the body, and `cleanup` removes them. Goes well with Iron Router's `onBeforeAction` and `onStop` hooks:

```js
Router.route('home', {
  path: '/home'
});

Router.route('foo', {
  path: '/foo',
  layoutTemplate: 'DefaultTemplate'
});

Router.onBeforeAction(function() {
  BodyClass.run();
});

Router.onStop(function() {
  BodyClass.cleanup();
});

Router.go('home');
// => body.home

Router.go('foo');
// => body.defaulttemplate.foo
```

This behavior is available as a nifty one-line-init Iron Router plugin:

```js
Router.plugin('bodyClasses');
```

*Note that template and layout names are added in lower case.*

### Configure

It's possible to configure the package with the following options:

```js
BodyClass.config({
  element: 'body' // What element to manipulate, defaults to 'body'
  classes: []     // What classes that *always* should be added
});
```

## Tests

This package is tested with the [`sanjo:jasmine`](https://github.com/Sanjo/meteor-jasmine/) package, bundled in a separate Meteor app in the `test-app` dir. To run tests:

```bash
cd test-app
meteor --test
```

## Version history

- `0.4.0`
  - Add support for Flow Router.
  - Needs Meteor 1.2.0.2.
- `0.1.0` - Initial publish.

## Contributions

Contributions are welcome. Please open issues and/or file Pull Requests.

## License

MIT.

***

Made by [Lookback](http://lookback.io).
