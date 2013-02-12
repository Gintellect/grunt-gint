### globals module require
 * grunt-gint
 * https://github.com/Gintellect/grunt-gint
 *
 * This task is mostly taken from Cary Landholt's grunt-hustler project
 * "https://github.com/CaryLandholt/grunt-hustler"

###

module.exports = (grunt) ->
  grunt.registerMultiTask 'template', 'Compiles templates', () ->

    this.data.include = grunt.file.read
    this.data.uniqueVersion = () ->
      uniqueVersion = (new Date()).getTime()
      uniqueVersion;

    _results = []

    sourceContents = []
    destination = ''
    src = ''
    for source in this.files
      sourceContents.push grunt.file.read(source.src)
      destination = source.dest
      src = source.src

    separator = grunt.util.linefeed
    contents = sourceContents.join grunt.util.normalizelf(separator)
    compiled = grunt.template.process contents, {data: { config: this.data} }

    grunt.file.write destination, compiled
    _results.push grunt.verbose.ok("" + src + " -> " + destination)
  
    _results