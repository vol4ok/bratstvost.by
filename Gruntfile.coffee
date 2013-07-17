module.exports = (grunt) ->

  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks("grunt-contrib-stylus")
  grunt.loadNpmTasks("grunt-contrib-concat")
  grunt.loadNpmTasks("grunt-contrib-clean")
  grunt.loadNpmTasks("grunt-contrib-cssmin")
  grunt.loadNpmTasks("grunt-contrib-uglify")

  grunt.initConfig


    coffee:

      server:
        options:
          bare: yes
        files:
          "dist/event.js": "event.coffee"
          "dist/news.js": "news.coffee"
          "dist/server.js": "server.coffee"

      client:
        files:
          "temp/scripts/misc.js": ["scripts/core/backbone-ext.coffee", "scripts/core/misc.coffee"]
          "public/js/main.js": ["scripts/pages/main.coffee"]


    copy:

      main:
        files: [
          expand: yes 
          src: ["public/**", "views/**"]
          dest: "dist/"
        ]
           
      font:
        files: [
          expand: yes 
          cwd: "components/font-awesome/build/assets/font-awesome/font"
          src: "**"
          dest: "public/font"
        ]

      dist:
        files: [
          expand: yes 
          src: ["public/img/**", "public/css/images/**", "views/**", "public/font/**"]
          dest: "dist"
        ]




    stylus:

      main:
        options:
          compress: yes
          paths: ["styles/config", "styles/core"]
        files:
          "temp/style/base.css": "styles/core/base.styl"
          "public/css/main.css": "styles/pages/main.styl"



    concat:

      style:
        src: [
          'components/html5-boilerplate/css/normalize.css'
          'temp/style/font-awesome.css'
          'temp/style/base.css'
          'components/flexslider/flexslider.css'
        ],
        dest: 'public/css/base.css'

      kernel:
        src: [
          'components/jquery2/jquery.js'
          'components/lodash/dist/lodash.underscore.js'
          'components/backbone/backbone.js'
          'components/js-base64/base64.js'
          'components/moment/min/moment.min.js'
          'components/moment/min/lang/ru.js'
          'components/flexslider/jquery.flexslider.js'
          'node_modules/bson/browser_build/bson.js'
          'scripts/uasync.js'
          'temp/scripts/misc.js'
        ],
        dest: 'public/js/kernel.js'



    cssmin:

      dist:
        files:
          'dist/public/css/base.css': 'public/css/base.css'
          'dist/public/css/main.css': 'public/css/main.css'

    uglify:
      dist: 
        files:
          'dist/public/js/kernel.js': 'public/js/kernel.js'
          'dist/public/js/main.js':   'public/js/main.js'
          

    less:

      fontawesome:
        options:
          paths: ["styles/config", "styles/core", "components/font-awesome/build/assets/font-awesome/less"]
        files:
          "temp/style/font-awesome.css": "styles/core/font-awesome.less"


    clean:
      style: ["temp/style", "public/css/base.css", "public/css/main.css"]
      scripts: ["temp/scripts", "public/js/kernel.js", "public/js/main.js"]
      all: ["temp"]
      dist: ["dist"]



  grunt.registerTask("default", ["stylus", "less:fontawesome", "copy:font", "concat:style", 
      "coffee:client", "concat:kernel"])
  grunt.registerTask("dist", ["coffee:server", "default", "cssmin:dist", "copy:dist"])
  #grunt.registerTask("clean")

