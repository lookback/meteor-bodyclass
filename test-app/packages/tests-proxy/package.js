Package.describe({
	name: "velocity:test-proxy",
	summary: "Dynamically created package to expose test files to mirrors",
	version: "0.0.4",
	debugOnly: true
});

Package.onUse(function (api) {
	api.use("coffeescript", ["client", "server"]);
	api.add_files("tests/jasmine/client/integration/_wait-for-router-helper.js",["client"]);
	api.add_files("tests/jasmine/client/integration/matchers.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/spec.coffee",["client"]);
});