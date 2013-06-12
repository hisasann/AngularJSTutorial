#global module:false
module.exports = (grunt) ->
  "use strict"

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    # ------------------------------------------------------------------------
    meta:
      version: "0.1.0"
      banner: "/*! PROJECT_NAME - v<%= meta.version %> - " +
            "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" +
            "* http://hisasann.com/\n" +
            "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> " +
            "hisasann; Licensed MIT */"

    # ------------------------------------------------------------------------
    coffee:
      glob_to_multiple:
        files: grunt.file.expandMapping(["coffee/**/*.coffee", 'nodejs/**/*.coffee'], "",
          rename: (destBase, destPath) ->
            destBase + destPath.replace(/\.coffee$/, ".js")
        )

    # ------------------------------------------------------------------------
    uglify:
      my_target:
        options:
          beautify: false
          mangle: false
        files:
            "js/index.min.js": ["coffee/index.js"]

    # ------------------------------------------------------------------------
    concat:
      options:
        separator: ";"
        stripBanners: true
        banner: "<%= meta.banner %>"
      dist:
        src: ["js/index.min.js"]
        dest: "js/index.min.js"

    # ------------------------------------------------------------------------
    compass:
      dev:
        options:
          sassDir: "scss"
          cssDir: "css"

      prod:
        options:
          sassDir: "scss"
          cssDir: "css"

    cssmin:
      compress:
        files:
          "css/index.min.css": ["css/index.css"]

    # ------------------------------------------------------------------------
    watch:
      compass:
        files: ["scss/**/*.scss"]
        tasks: ["clean", "compass-dev", "mincss"]
      coffee:
        files: ["coffee/**/*.coffee"]
        tasks: ["coffee", "uglify", "concat"]

    # ------------------------------------------------------------------------
    clean:
      build:
        src: ["css/index.css", "css/index.min.css", "js/index.min.js"]

    yukkuroid:
      message: '終わったよ'

    # ------------------------------------------------------------------------
    jshint:
      options:
        curly: true
        eqeqeq: true
        immed: true
        latedef: true
        newcap: true
        noarg: true
        sub: true
        undef: true
        boss: true
        eqnull: true
        browser: true

      globals: {}

  # load npm tasks.
  grunt.loadNpmTasks "grunt-contrib"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-yukkuroid"

  # compass task.
  grunt.registerTask "compass-dev", ["compass:dev"]
  grunt.registerTask "compass-prod", ["compass:prod"]

  # Default task.
  grunt.registerTask "default", ["clean", "coffee", "compass-dev", "uglify", "concat", "cssmin"]
