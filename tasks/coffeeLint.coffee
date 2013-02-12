### globals module require
 * grunt-gint
 * https://github.com/Gintellect/grunt-gint
 *
 * This task is mostly taken from Cary Landholt's grunt-hustler project
 * "https://github.com/CaryLandholt/grunt-hustler"

###

module.exports = (grunt) ->

  grunt.registerMultiTask 'coffeeLint', 'Lints CoffeeScript files', () ->
    coffeeLint = require 'coffeelint'
    results = []
    for source in this.files
      contents = grunt.file.read source.src
      errors = coffeeLint.lint contents, this.options
      if not errors.length
        results.push(grunt.verbose.ok(source.src[0]));
      else
        grunt.log.header source.src[0]
        for error in errors
          results.push grunt.log.error("#" + error.lineNumber 
          + ": " + error.message + " (" + error.context + ")")
    return results