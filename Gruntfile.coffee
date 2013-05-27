module.exports = (grunt) ->

  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks("grunt-contrib-stylus")
  grunt.loadNpmTasks("grunt-contrib-concat")
  grunt.loadNpmTasks("grunt-contrib-clean")
  grunt.loadNpmTasks("grunt-contrib-cssmin")

  grunt.initConfig


    coffee:

      server:
        options:
          bare: yes
        files:
          "dist/event.js": "event.coffee"
          "dist/server.js": "server.coffee"

      client:
        files:
          "temp/scripts/misc.js": ["scripts/backbone-ext.coffee", "scripts/misc.coffee"]
          "public/js/main.js": ["scripts/main.coffee"]


    copy:

      main:
        files: [
          expand: yes 
          src: ["public/**", "views/**"]
          dest: "dist/"
        ]
      fancybox:
        files: [
          expand: yes 
          cwd: "components/fancybox/source"
          src: ["*.png", "*.gif"]
          dest: "public/css"
        ]      
      font:
        files: [
          expand: yes 
          cwd: "components/font-awesome/build/assets/font-awesome/font"
          src: "**"
          dest: "public/font"
        ]



    stylus:

      base:
        options:
          compress: yes
        files:
          "temp/style/base.css": "styles/base.styl"

      main:
        options:
          compress: yes
        files:
          "public/css/main.css": "styles/main.styl"



    concat:

      style:
        src: [
          'components/html5-boilerplate/css/normalize.css'
          'temp/style/font-awesome.css'
          'temp/style/base.css'
          'components/fancybox/source/jquery.fancybox.css'
        ],
        dest: 'public/css/base.css'

      kernel:
        src: [
          'components/jquery2/jquery.js'
          'components/lodash/dist/lodash.underscore.js'
          'components/backbone/backbone.js'
          'components/moment/min/moment.min.js'
          'components/moment/min/lang/ru.js'
          'components/fancybox/source/jquery.fancybox.js'
          'node_modules/bson/browser_build/bson.js'
          'scripts/uasync.js'
          'temp/scripts/misc.js'
        ],
        dest: 'public/js/kernel.js'



    cssmin:

      base:
        files:
          'public/css/base.min.css': 'public/css/base.css'

      main:
        files:
          'public/css/main.min.css': 'public/css/main.css'



    less:

      bootstap:
        options:
          paths: ["styles", "components/bootstrap/less"]
        files:
          "temp/style/bootstrap.css": "styles/bootstrap.less"

      fontawesome:
        options:
          paths: ["styles", "components/font-awesome/build/assets/font-awesome/less"]
        files:
          "temp/style/font-awesome.css": "styles/font-awesome.less"


    clean:
      style: ["temp/style"]
      scripts: ["temp/scripts"]
      all: ["temp"]


  grunt.registerTask("default", ["stylus", "less:fontawesome", "copy:font", "copy:fancybox", "concat:style", "cssmin", 
      "coffee:client", "concat:kernel"])
  grunt.registerTask("dist", ["coffee", "copy"])

