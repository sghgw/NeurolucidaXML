module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      options:
        join: true
      compile:
        files:
          'lib/neurolucida-xml.js': ['src/*.coffee']
    mochaTest:
      options:
        reporter: 'spec'
      src: ['test/xmlSpec.coffee', 'test/segmentSpec.coffee', 'test/xmlSpec.js', 'test/segmentSpec.js']
    watch: 
      coffee:
        files: ['src/*.coffee', 'test/*.coffee']
        tasks: ['coffee', 'uglify:js']
    uglify:
      js:
        files:
          'lib/neurolucida-xml.min.js': ['lib/neurolucida-xml.js']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['coffee', 'uglify:js']