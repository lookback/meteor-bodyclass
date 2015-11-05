Package.describe({
  name: 'lookback:body-class',
  version: '0.3.0',
  git: 'https://github.com/lookback/meteor-bodyclass',
  summary: 'Automatically add classes for Iron Router templates and layouts for scoping with CSS.'
});

var where = 'client';

Package.onUse(function(api) {
  api.versionsFrom('1.2.0.2');

  api.use([
    'ecmascript',
    'check',
    'underscore',
    'jquery',
    'tracker'
  ], where);

  api.use('iron:router@1.0.0', where, {weak: true});

  api.addFiles('body-class.js', where);
  api.export('BodyClass', where);
});

Package.onTest(function(api) {
  api.use([
    'coffeescript',
    'practicalmeteor:munit',
    'lookback:body-class'
  ], where);

  api.addFiles('body-class-test.coffee', where);
});
