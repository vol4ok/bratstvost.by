uuid = require "uuid"
fs = require "fs"
mg  = require "mongoose"
_ = require "lodash"
require("uasync")(_)

mg.connect('mongodb://127.0.0.1/bratstvost-3')
{Video} = require "./models/video"

videos = JSON.parse(fs.readFileSync("videos.json", "UTF-8"));


for data in videos 
  data._id = uuid.v4()
  video = new Video(data)
  #console.log video
  video.save ( (video_id) ->
    return ->
      console.log "Video #{video_id} saved"
  )(video.video_id)