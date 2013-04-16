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

  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-stylus")

  grunt.registerTask("default", ["stylus"])
