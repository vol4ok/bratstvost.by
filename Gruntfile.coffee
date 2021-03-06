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
  grunt.loadNpmTasks('grunt-contrib-imagemin')
  grunt.loadNpmTasks('grunt-html-build')
  grunt.loadNpmTasks('grunt-contrib-htmlmin')
  
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
          "temp/js/appInit.js":      "scripts/appInit.coffee"
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
          "dist/models/event.js": "models/event.coffee"
          "dist/models/notice.js": "models/notice.coffee"
          "dist/models/news.js": "models/news.coffee"
          "dist/models/video.js": "models/video.coffee"
          "dist/models/member.js": "models/member.coffee"


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

      dev:
        src: [
          "bower_components/jquery/dist/jquery.js"
          "bower_components/bootstrap/js/transition.js"

          "bower_components/eventEmitter/EventEmitter.js"
          "bower_components/eventie/eventie.js"
          "bower_components/imagesloaded/imagesloaded.js"
          "bower_components/fluidbox/jquery.fluidbox.js"

          "bower_components/angular/angular.js"
          "bower_components/angular-route/angular-route.js"
          "bower_components/angular-sanitize/angular-sanitize.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/lang_ru.js"

          "bower_components/angular-bootstrap/ui-bootstrap-tpls.js"
          "scripts/js/lazy-bootstrap-carousel-v3.js"

          "temp/js/core.js"
          "temp/js/appInit.js"
          "temp/js/factories.js"
          "temp/js/controllers.js"
          "temp/js/services.js"
          "temp/js/directives.js"
        ]
        dest: "public/js/app.js"


      dist:
        src: [
          "bower_components/jquery/dist/jquery.min.js"
          "bower_components/bootstrap/js/transition.js"

          "bower_components/eventEmitter/EventEmitter.js"
          "bower_components/eventie/eventie.js"
          "bower_components/imagesloaded/imagesloaded.js"
          "bower_components/fluidbox/jquery.fluidbox.js"

          "bower_components/angular/angular.min.js"
          "bower_components/angular-route/angular-route.min.js"
          "bower_components/angular-sanitize/angular-sanitize.min.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/lang_ru.js"

          "bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js"
          "scripts/js/lazy-bootstrap-carousel-v3.js"

          "temp/js/core.js"
          "temp/js/appInit.js"
          "temp/js/factories.js"
          "temp/js/controllers.js"
          "temp/js/services.js"
          "temp/js/directives.js"
        ]
        dest: "temp/js/app.js"

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
          cwd: "dist/public/"
          src: "index.html"
          dest: "public/"
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
          'dist/public/js/app.js':  ["temp/js/app.js"]


    ### ----------------------- ###
    ### ******** CLEAN ******** ###
    ### ----------------------- ###

    clean:
      dist: [
        "dist/models"
        "dist/public"
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

    ### ---------------------- ###
    ### ****** imagemin ****** ###
    ### ---------------------- ###

    imagemin:
      dist:
        files: [{
          expand: true,
          cwd: 'dist/public',
          src: '**/*.{png,jpg,jpeg,gif}',
          dest: 'dist/public/'
        }]

    ### ****** htmlbuild ****** ###
    ### ******    see https://github.com/spatools/grunt-html-build ****** ###

    htmlbuild:
      dist:
        src: 'public/build_index.html',
        dest: 'dist/public/index.html',
        options:
          beautify: true,
          relative: true,
          sections:
            views: 'views/views/**/*.html',
            templates: 'views/templates/**/*.html',
            layout:
              metrika: 'views/_metrika.html'
              navigation: 'views/_navigation.html'
          data:
            version: "0.1.0",

    ### ****** htmlmin ****** ###
    ### ******    see https://github.com/gruntjs/grunt-contrib-htmlmin ****** ###
    htmlmin:
      dist:
        options:
          removeComments: true,
          collapseWhitespace: true,
          minifyJS: true,
          processScripts: ['text/ng-template']
        files:
          'dist/public/index.html': 'dist/public/index.html'


  grunt.registerTask "bootstrap", ["less:bootstrap"]
  grunt.registerTask "styles", ["less:bootstrap", "less:styles", "concat:styles"]
  grunt.registerTask "default", ["styles", "coffee:client", "concat:dev"]

  grunt.registerTask "dist", ["styles", "coffee", "concat:dist", "cssmin", "uglify", "htmlbuild", "copy", "htmlmin", "imagemin"]
  grunt.registerTask "dev", ["styles", "coffee", "concat:dev", "htmlbuild", "copy" ]

  grunt.registerTask "build", ["dist"]
  grunt.registerTask "rebuild", ["clean", "dist"]
