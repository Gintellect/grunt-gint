### globals module require
 * grunt-gint
 * https://github.com/Gintellect/grunt-gint
 *
 * This task is mostly taken from Cary Landholt's grunt-hustler project
 * "https://github.com/CaryLandholt/grunt-hustler"

###

module.exports = (grunt) ->
  prettyDiff = require('prettydiff');
  grunt.registerMultiTask 'minify', 'Minifies Html', () ->
    conditional = (_ref = this.data.conditional) != null ? _ref : true;
    _results = [];

    sourceContents = [];
    src = ''
    dest = ''
    for source in this.files
      sourceContents.push grunt.file.read(source.src)
      dest = source.dest
      src = source.src

    separator = grunt.util.linefeed
    contents = sourceContents.join grunt.util.normalizelf(separator)
    options =
      source: contents
      mode: 'minify'
      conditional: conditional
      html: 'html-yes'
    compiled = prettyDiff.api(options)[0]
    grunt.file.write dest, compiled
    _results.push grunt.verbose.ok("" + src + " -> " + dest)

    _results;