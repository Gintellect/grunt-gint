### globals module require
 * grunt-gint
 * https://github.com/Gintellect/grunt-gint
 *
 * This task is mostly taken from Peter Halliday's blog 
 * http://stuffpetedoes.blogspot.nl/2012/07/grunt-watch-and-nodejs-require-cache.html

 ###

'use strict';

module.exports = (grunt) ->

  Mocha = require 'mocha'

  grunt.registerMultiTask 'mocha', 'Run unit tests with Mocha', () ->
    # tell grunt this is an asynchronous task
    done = this.async()
    # Clear all the files we can in the require cache in case we are run from watch.
    # NB. This is required to ensure that all tests are run and that all the modules under
    # test have been reloaded and are not in some kind of cached state
    for key in require.cache
      if require.cache[key]
        delete require.cache[key]
        if require.cache[key]
          console.warn('Mocha grunt task: Could not delete from require cache:\n' + key)
      
      else 
        console.warn('Mocha grunt task: Could not find key in require cache:\n' + key)

    #create a mocha instance with our options
    mocha = new Mocha(this.data.options)

    # add files to mocha
    for source in this.files
      mocha.addFile source.src[0]
 
    # run mocha asynchronously and catch errors!! (again, in case we are running this task in watch)
    try      
      mocha.run (failureCount) ->
        console.log('Mocha completed with ' + failureCount + ' failing tests')
        done(failureCount is 0)
      return
    catch e
      console.log 'Mocha exploded!'
      console.log e
      done false
