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



    ### ----------------------- ###
    ### ******** WATCH ******** ###
    ### ----------------------- ###

    watch: 
      less:
        files: 'styles/**/*.less'
        tasks: ['less']
      coffee:
        files: 'scripts/**/*.coffee'
        tasks: ['coffee:client']






    ### ------------------------ ###
    ### ******** COFFEE ******** ###
    ### ------------------------ ###


    coffee:
      client:
        files:
          "temp/js/app.js":          "scripts/app.coffee"
          "temp/js/core.js":         "scripts/core.coffee"
          "temp/js/factories.js":    "scripts/factories/*.coffee"
          "temp/js/controllers.js":  "scripts/controllers/*.coffee"
          "temp/js/services.js":     "scripts/services/*.coffee"
          "temp/js/directives.js":   "scripts/directives/*.coffee"

      server:
        options:
          bare: yes
        files:
          "dist/web.js": "index.coffee"
          "dist/models/post.js": "models/post.coffee"
          "dist/models/event.js": "models/event.coffee"
          "dist/models/notice.js": "models/notice.coffee"
          "dist/models/news.js": "models/news.coffee"
          "dist/models/article.js": "models/article.coffee"
          "dist/models/video.js": "models/video.coffee"





    ### ---------------------- ###
    ### ******** LESS ******** ###
    ### ---------------------- ###

    less: 
      bootstrap:
        options:
          paths: [
            "styles"
            "bower_components"
          ]
        files:
          "temp/css/bootstrap.css": "styles/shared.less"


      styles: 
        options:
          paths: [
            "styles"
            "bower_components"
          ]
        files:
          "temp/css/app.css": "styles/app.less"





    ### ------------------------ ###
    ### ******** CONCAT ******** ###
    ### ------------------------ ###

    concat:

      core:
        src: [
          "bower_components/jquery/dist/jquery.js"
          "bower_components/bootstrap/js/carousel.js"
          "bower_components/bootstrap/js/transition.js"

          "bower_components/eventEmitter/EventEmitter.js"
          "bower_components/eventie/eventie.js"
          "bower_components/imagesloaded/imagesloaded.js"
          "bower_components/fluidbox/jquery.fluidbox.js"

          "bower_components/angular/angular.js"
          "bower_components/angular-route/angular-route.js"
          "bower_components/angular-sanitize/angular-sanitize.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/langs.min.js"
        ]
        dest: "public/js/core.js"


      main:
        src: [
          "temp/js/core.js"
          "temp/js/app.js"
          "temp/js/factories.js"
          "temp/js/controllers.js"
          "temp/js/services.js"
          "temp/js/directives.js"
        ]
        dest: "public/js/app.js"


      dist:
        src: [
          "bower_components/jquery/dist/jquery.min.js"
          "bower_components/bootstrap/js/carousel.js"
          "bower_components/bootstrap/js/transition.js"
          
          "bower_components/eventEmitter/EventEmitter.js"
          "bower_components/eventie/eventie.js"
          "bower_components/imagesloaded/imagesloaded.js"
          "bower_components/fluidbox/jquery.fluidbox.js"

          "bower_components/angular/angular.min.js"
          "bower_components/angular-route/angular-route.min.js"
          "bower_components/angular-sanitize/angular-sanitize.min.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/langs.min.js"
        ]
        dest: "temp/js/core.js"

      styles:
        src: [
          "styles/fonts/*"
          "temp/css/bootstrap.css"
          "bower_components/fluidbox/css/fluidbox.css"
          "temp/css/app.css"
        ]
        dest: "public/css/styles.css"





    ### ---------------------- ###
    ### ******** COPY ******** ###
    ### ---------------------- ###

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
            cwd: "public/css/"
            src: "*.png"
            dest: "dist/public/css/"
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





    ### ------------------------ ###
    ### ******** CSSMIN ******** ###
    ### ------------------------ ###

    cssmin:
      dist:
        files:
          "dist/public/css/styles.css": "public/css/styles.css"






    ### ------------------------ ###
    ### ******** UGLIFY ******** ###
    ### ------------------------ ###

    uglify:
      dist:
        options:
          mangle: false
        files:
          'dist/public/js/core.js': ["temp/js/core.js"]
          'dist/public/js/app.js':  ["public/js/app.js"]





    ### ----------------------- ###
    ### ******** CLEAN ******** ###
    ### ----------------------- ###

    clean:
      dist: [
        "dist/models"
        "dist/public"
        "dist/views"
        "dist/package.json"
        "dist/Procfile"
        "dist/web.js"
        "dist/nginx.conf"
      ]
      temp: ["temp"]
      pub: ["public/js/*.js", "public/css/*.css"]




    ### ---------------------- ###
    ### ******** BUMP ******** ###
    ### ---------------------- ###


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
  grunt.registerTask "build", ["core", "default", "dist"]
  grunt.registerTask "rebuild", ["clean", "core", "default", "dist"]
