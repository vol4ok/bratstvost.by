module.exports = (grunt) -> 
  grunt.initConfig
    stylus:
      compile:
        options:
          paths: ["core.css"]
          compress: yes
        files:
          "base.css": "base.styl"
          "main.css": "main.styl"
          "admin.css": "admin.styl"
    coffee:
      compile:
        options:
          bare: yes
        files:
          "admin.js": "admin.coffee"

  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-stylus")

  grunt.registerTask("default", ["coffee", "stylus"])
