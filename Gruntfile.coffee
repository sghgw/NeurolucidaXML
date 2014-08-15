module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/neurolucida-xml.js': ['src/*.coffee']
    mochaTest:
      src: ['test/xmlTest.coffee', 'test/segmentTest.coffee']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'


  grunt.registerTask 'default', ['coffee', 'mochaTest']