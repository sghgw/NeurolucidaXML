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
        tasks: ['coffee', 'uglify:js', 'mochaTest']
    uglify:
      js:
        files:
          'lib/neuroludcida-xml.min.js': ['lib/neurolucida-xml.js']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['coffee', 'uglify:js', 'mochaTest']