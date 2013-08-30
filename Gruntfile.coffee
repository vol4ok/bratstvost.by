module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks("grunt-contrib-concat")
  grunt.loadNpmTasks("grunt-contrib-cssmin")
  grunt.loadNpmTasks("grunt-contrib-uglify")
  grunt.loadNpmTasks("grunt-contrib-clean")
  grunt.loadNpmTasks('grunt-bump')
  
  grunt.initConfig

    coffee:
      client:
        files:
          "public/js/main.js": "scripts/main.coffee"
          "public/js/events.js": "scripts/events.coffee"

      server:
        options:
          bare: yes
        files:
          "dist/web.js": "index.coffee"
          "dist/models/post.js": "models/post.coffee"
          "dist/models/events.js": "models/events.coffee"


    less: 
      bootstrap:
        options:
          paths: [
            "styles/config"
            "bower_components/bootstrap/less"
          ]
        files:
          "temp/css/bootstap.css": "styles/core/bootstrap.less"

      styles: 
        options:
          paths: [
            "styles/config"
            "bower_components/bootstrap/less"
          ]
        files:
          "temp/css/layout.css": "styles/pages/layout.less"
          "temp/css/index.css": "styles/pages/index.less"



    concat:
      scripts:
        src: [
          "bower_components/jquery2/jquery.js"
          "bower_components/angular/angular.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/langs.min.js"
        ]
        dest: "public/js/core.js"

      dist:
        src: [
          "bower_components/jquery2/jquery.min.js"
          "bower_components/angular/angular.min.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/langs.min.js"
        ]
        dest: "dist/public/js/core.js"

      styles:
        src: [
          "styles/core/bratstvost-icon-font.css"
          "temp/css/bootstap.css"
          "temp/css/layout.css"
          "temp/css/index.css"
        ]
        dest: "public/css/styles.css"

    copy:
      dist:
        files: [
            expand: yes
            cwd: "public/img/"
            src: "**"
            dest: "dist/public/img/"
          ,
            expand: yes
            cwd: "public/fonts/"
            src: "**"
            dest: "dist/public/fonts/"
          ,
            expand: yes
            cwd: "public/"
            src: "favicon.ico"
            dest: "dist/public"
            filter: 'isFile'
          ,
            expand: yes
            src: ["package.json", "Procfile", "nginx.conf"]
            dest: "dist"
            filter: 'isFile' 

          ,
            expand: yes
            cwd: "views/"
            src: "**"
            dest: "dist/views"
        ]

    cssmin:
      dist:
        files:
          "dist/public/css/styles.css": "public/css/styles.css"

    uglify:
      dist:
        options:
          mangle: false
        files:
          'dist/public/js/main.js': ['public/js/main.js']
          'dist/public/js/events.js': ['public/js/events.js']


    clean:
      dist: ["dist"]

    bump:
      options:
        files: ['package.json']
        updateConfigs: []
        commit: false
        commitMessage: 'Release v%VERSION%'
        commitFiles: ['package.json']
        createTag: false
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: false
        pushTo: 'upstream'
        gitDescribeOptions: '--tags --always --abbrev=1 --dirty=-d'

  #grunt.registerTask "default", ["less", "concat", "stylus", "coffee"]
  grunt.registerTask "bootstrap", ["less:bootstrap"]
  grunt.registerTask "flatui", ["less:flatui"]
  grunt.registerTask "styles", ["less:bootstrap", "less:styles", "concat:styles"]
  grunt.registerTask "default", ["styles", "coffee:client"]
  grunt.registerTask "dist", ["styles", "coffee", "concat:dist", "cssmin", "uglify", "bump", "copy"]
