module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks("grunt-contrib-concat")
  grunt.loadNpmTasks("grunt-contrib-cssmin")
  grunt.loadNpmTasks("grunt-contrib-uglify")
  grunt.loadNpmTasks("grunt-contrib-clean")
  grunt.loadNpmTasks("grunt-contrib-watch")
  grunt.loadNpmTasks('grunt-bump')
  
  grunt.initConfig

    watch: 
      less:
        files: 'styles/**/*.less'
        tasks: ['less']
      coffee:
        files: 'scripts/**/*.coffee'
        tasks: ['coffee:client']

    coffee:
      client:
        files:
          "temp/js/app.js":                         "scripts/app.coffee"
          "temp/js/controllers/ctrl-event-list.js": "scripts/controllers/ctrl-event-list.coffee"
          "temp/js/controllers/ctrl-news-list.js":  "scripts/controllers/ctrl-news-list.coffee"
          "temp/js/controllers/ctrl-notice-list.js":  "scripts/controllers/ctrl-notice-list.coffee"
          "temp/js/controllers/ctrl-index-page.js": "scripts/controllers/ctrl-index-page.coffee"
          "temp/js/controllers/ctrl-about-page.js": "scripts/controllers/ctrl-about-page.coffee"
          "temp/js/controllers/ctrl-video-page.js": "scripts/controllers/ctrl-video-page.coffee"
          "temp/js/services/svc-events.js":         "scripts/services/svc-events.coffee"
          "temp/js/services/svc-notice.js":         "scripts/services/svc-notice.coffee"
          "temp/js/directives/div-event-view.js":   "scripts/directives/div-event-view.coffee"
          "temp/js/directives/div-archive-collapse.js":   "scripts/directives/div-archive-collapse.coffee"

      server:
        options:
          bare: yes
        files:
          "dist/web.js": "index.coffee"
          "dist/models/post.js": "models/post.coffee"
          "dist/models/event.js": "models/event.coffee"
          "dist/models/notice.js": "models/notice.coffee"


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
      core:
        src: [
          "bower_components/jquery2/jquery.js"
          "bower_components/bootstrap/js/carousel.js"
          "bower_components/bootstrap/js/transition.js"
          "bower_components/angular/angular.js"
          "bower_components/angular-route/angular-route.js"
          "bower_components/angular-sanitize/angular-sanitize.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/langs.min.js"
        ]
        dest: "public/js/core.js"

      main:
        src: [
          "temp/js/controllers/ctrl-event-list.js" 
          "temp/js/controllers/ctrl-news-list.js" 
          "temp/js/controllers/ctrl-notice-list.js"
          "temp/js/controllers/ctrl-index-page.js"
          "temp/js/controllers/ctrl-about-page.js"
          "temp/js/controllers/ctrl-video-page.js"
          "temp/js/services/svc-events.js"
          "temp/js/services/svc-notice.js"
          "temp/js/directives/div-event-view.js"
          "temp/js/directives/div-archive-collapse.js"
          "scripts/data.js"
          "temp/js/app.js"
        ]
        dest: "public/js/app.js"

      dist:
        src: [
          "bower_components/jquery2/jquery.min.js"
          "bower_components/bootstrap/js/carousel.js"
          "bower_components/bootstrap/js/transition.js"
          "bower_components/angular/angular.min.js"
          "bower_components/angular-route/angular-route.min.js"
          "bower_components/angular-sanitize/angular-sanitize.min.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/langs.min.js"
        ]
        dest: "dist/public/js/core.js"

      styles:
        src: [
          "temp/css/bootstap.css"
          "temp/css/layout.css"
          "temp/css/index.css"
          "styles/core/bratstvost-icon-font.css"
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
          'dist/public/js/app.js': ["public/js/app.js"]


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

  grunt.registerTask "bootstrap", ["less:bootstrap"]
  grunt.registerTask "styles", ["less:bootstrap", "less:styles", "concat:styles"]
  grunt.registerTask "core", ["concat:core"]
  grunt.registerTask "default", ["styles", "coffee:client", "concat:main"]
  grunt.registerTask "dist", ["styles", "coffee", "concat:dist", "cssmin", "uglify", "copy"]
