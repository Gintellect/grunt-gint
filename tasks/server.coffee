module.exports = (grunt) ->

  grunt.registerTask 'server', 'Start the dev express app.', () ->

    started = false
    done = this.async()

    server = require('child_process').exec './node_modules/.bin/coffee ./dist/server/server.coffee 3005'
    
    grunt.log.writeln 'Dev server launched pid: ' + server.pid
    grunt.config.set 'devServerPID', server.pid

    server.stdout.on 'data', (data) ->
      #wait for the first message to come back from the server
      if not started
        started = true
        done()

      grunt.log.writeln data
  
    server.stderr.on 'data', (data) ->
      if not started
        started = true
        done()

      grunt.log.writeln data

    server.on 'exit', (code, signal) ->
      grunt.event.emit("exit-devserver")
      if not started
        started = true
        done()

  grunt.registerTask 'testServer', 'Start the test express app.', () ->

    started = false
    done = this.async()

    server = require('child_process').exec './node_modules/.bin/coffee ./dist/server/server.coffee 3006'
    
    grunt.log.writeln 'Test server launched pid: ' + server.pid
    grunt.config.set 'testServerPID', server.pid

    server.stdout.on 'data', (data) ->
      if not started
        started = true
        done()

      grunt.log.writeln data
  
    server.stderr.on 'data', (data) ->
      if not started
        started = true
        done()

      grunt.log.writeln data

    server.on 'exit', (code, signal) ->
      grunt.event.emit("exit-testserver")
      if not started
        started = true
        done()

  grunt.registerTask 'stopTestServer', 'Stop the test server', () ->
    done = this.async();
    pid = grunt.config.get 'testServerPID'
    if pid
      grunt.event.on 'exit-testserver', () ->
        grunt.event.removeAllListeners 'exit-testserver'
        grunt.log.writeln "test server exited"
        done()

      try
        process.kill pid
      catch e
        {}
    else
      grunt.log.writeln 'no test server found'
      done()


  grunt.registerTask 'stopDevServer', 'Stop the dev server', () ->
    done = this.async();
    pid = grunt.config.get 'devServerPID'
    if pid
      grunt.event.on 'exit-devserver', () ->
        grunt.event.removeAllListeners 'exit-devserver'
        grunt.log.writeln "dev server exited"
        done()

      try
        process.kill pid
      catch e
        {}
    else
      grunt.log.writeln 'no dev server found'
      done()
