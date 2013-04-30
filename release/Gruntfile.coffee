module.exports = (grunt) -> 
  grunt.initConfig
    stylus:
      compile:
        options:
          paths: ["styles/core.css"]
          compress: yes
        files:
          "styles/base.css": "styles/base.styl"
          "styles/main.css": "styles/main.styl"
    coffee:
      compile:
        options:
          bare: yes
          sourceMap: true
        files:
          "scripts/admin.js": "scripts/admin.coffee"
    concat:
      vendor:
        src: [
          "components/jquery/jquery.js"
          "components/underscore/underscore.js"
          "scripts/misc.js"
          "scripts/async.js"
          "components/backbone/backbone.js"
          "components/bootstrap-datepicker/js/bootstrap-datepicker.js"
        ],
        dest: "scripts/vendor.js"

  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-stylus")
  grunt.loadNpmTasks("grunt-contrib-concat")

  grunt.registerTask("default", ["coffee", "stylus", "concat"])
