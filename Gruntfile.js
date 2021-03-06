/*
 * grunt-gint
 * https://github.com/Gintellect/gint-grunt
 *
 * Copyright (c) 2013 David Bochenski
 * Licensed under the MIT license.
 */

'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
   
    // Before generating any new files, remove any previously-created files.
    clean: {
      tests: ['tmp'],
    },

  });

  // Actually load this plugin's task(s).
  grunt.loadTasks('tasks');

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-clean');

  // By default, lint and run all tests.
  grunt.registerTask('default', ['clean']);

};
