module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/neurolucida-xml.js': ['src/*.coffee']
    mochaTest:
      src: ['test/xmlTest.coffee', 'test/segmentTest.coffee']
    watch: 
      coffee:
        files: ['src/*.coffee']
        tasks: ['coffee', 'mochaTest']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks('grunt-contrib-watch')


  grunt.registerTask 'default', ['coffee', 'mochaTest']