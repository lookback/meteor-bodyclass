Package.describe({
  name: 'lookback:body-class',
  version: '0.0.1',
  summary: 'Automatically add classes for Iron Router templates and layouts for scoping with CSS.'
});

var where = 'client';

Package.onUse(function(api) {
  api.versionsFrom('0.9.3');

  api.use(['coffeescript', 'check', 'underscore', 'jquery', 'tracker'], where);
  api.use('iron:router@1.0.0', where, {weak: true});

  api.addFiles('lookback:body-class.coffee', where);

  api.export('BodyClass', where);
});
