Router.route 'home',
  path: '/'

Router.route 'sub',
  path: '/sub'

Router.route 'layout',
  path: '/layout'
  layoutTemplate: 'DefaultLayout'

Router.route 'sec-layout',
  name: 'sec-layout'
  layoutTemplate: 'SecondaryLayout'
