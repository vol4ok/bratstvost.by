module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-stylus")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks("grunt-contrib-concat")
  
  grunt.initConfig

    coffee:
      default:
        options:
          bare: yes
        files:
          "public/js/main.js": "scripts/main.coffee"

    stylus: 
      default: 
        options:
          compress: yes
          paths: ["styles/config", "styles/core"]
        files:
          "temp/css/base.css": "styles/core/base.styl"
          "temp/css/layout.css": "styles/pages/layout.styl"
          "temp/css/index.css": "styles/pages/index.styl"

    less: 
      bootstrap:
        options:
          paths: [
            "styles/config"
            "bower_components/bootstrap/less"
          ]
        files:
          "temp/css/bootstap.css": "styles/core/bootstrap.less"
      flatui:
        options:
          paths: [
            "styles/config"
            "bower_components/flat-ui-official/less"
          ]
        files:
          "temp/css/flat-ui.css": "styles/core/flat-ui.less"

    concat:
      scripts:
        src: [
          "bower_components/jquery2/jquery.js"
          "bower_components/angular/angular.js"
        ]
        dest: "public/js/scripts.js"
      styles:
        src: [
          "styles/core/bratstvost-icon-font.css"
          "temp/css/bootstap.css"
          "temp/css/flat-ui.css"
          "temp/css/base.css"
          "temp/css/layout.css"
          "temp/css/index.css"
        ]
        dest: "public/css/styles.css"

  #grunt.registerTask "default", ["less", "concat", "stylus", "coffee"]
  grunt.registerTask "default", ["less", "stylus", "concat:styles"]
