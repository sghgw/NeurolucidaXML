module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/neurolucida-xml.js': ['src/*.coffee']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.registerTask 'default', ['coffee']