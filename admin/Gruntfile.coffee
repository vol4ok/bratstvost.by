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
          "temp/js/admin-app.js":                      "scripts/admin-app.coffee"
          "temp/js/services/svc-events.js":            "scripts/services/svc-events.coffee"
          "temp/js/services/svc-notice.js":            "scripts/services/svc-notice.coffee"
          "temp/js/services/svc-news.js":            "scripts/services/svc-news.coffee"
          "temp/js/controllers/ctrl-events-editor.js": "scripts/controllers/ctrl-events-editor.coffee"
          "temp/js/controllers/ctrl-notice-editor.js": "scripts/controllers/ctrl-notice-editor.coffee"
          "temp/js/controllers/ctrl-news-editor.js": "scripts/controllers/ctrl-news-editor.coffee"


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
          "bower_components/angular/angular.js"
          "bower_components/angular-route/angular-route.js"
          "bower_components/angular-sanitize/angular-sanitize.js"
          "bower_components/moment/min/moment.min.js"
          "bower_components/moment/min/langs.min.js"
          "bower_components/node-uuid/uuid.js"
        ]
        dest: "public/js/core.js"

      app:
        src: [
          "temp/js/services/svc-events.js"
          "temp/js/services/svc-notice.js"
          "temp/js/services/svc-news.js"
          "temp/js/controllers/ctrl-events-editor.js" 
          "temp/js/controllers/ctrl-notice-editor.js"
          "temp/js/controllers/ctrl-news-editor.js"
          "temp/js/admin-app.js"
        ]
        dest: "public/js/app.js"

      styles:
        src: [
          "temp/css/bootstap.css"
          "temp/css/layout.css"
          "temp/css/index.css"
          "styles/core/bratstvost-icon-font.css"
        ]
        dest: "public/css/styles.css"


  grunt.registerTask "bootstrap", ["less:bootstrap"]
  grunt.registerTask "styles", ["less:bootstrap", "less:styles", "concat:styles"]
  grunt.registerTask "core", ["concat:core"]
  grunt.registerTask "default", ["styles", "coffee:client", "concat:app"]
