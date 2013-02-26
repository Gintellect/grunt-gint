module.exports = (grunt) ->
  devServer = null
  grunt.registerTask 'server', 'Start the dev express app.', () ->

    devServer = require('child_process').exec './node_modules/.bin/coffee ./dist/server/server.coffee 3005'
    grunt.log.writeln 'Dev server started'
  
    devServer.stdout.on 'data', (data) ->
      buffer = new Buffer(data)
      grunt.log.writeln buffer.toString('utf8')
  
    devServer.stderr.on 'data', (data) ->
      buffer = new Buffer(data)
      grunt.log.writeln buffer.toString('utf8')

  testServer = null
  grunt.registerTask 'testserver', 'Start the test express app.', () ->

    testServer = require('child_process').exec './node_modules/.bin/coffee ./dist/server/server.coffee 3006'
    testServer.stdout.on 'data', (data) ->
      buffer = new Buffer(data);
      grunt.log.writeln buffer.toString('utf8')

    testServer.stderr.on 'data', (data) ->
      buffer = new Buffer(data)
      grunt.log.writeln buffer.toString('utf8')

  grunt.registerTask 'stopTestServer', 'Stop the test server', () ->
    done = this.async()
    devServer.on 'exit', (code, signal) ->
      done()

    if testServer
      try
        process.kill testServer.pid
      catch e
        {}


  grunt.registerTask 'stopDevServer', 'Stop the dev server', () ->
    done = this.async();
    devServer.on 'exit', (code, signal) ->
      done()

    if devServer
      try
        process.kill devServer.pid
      catch e
        {}
