require "colors"
mg  = require "mongoose"
moment = require "moment"

moment.lang("ru")

mg.connect('mongodb://localhost/bratstvost-3')
{Post} = require "../models/post"

_ = require "lodash"
require("uasync")(_)
_ extends require "fs"

json = _.readFileSync("video.json", "utf-8")
data = JSON.parse(json)

is_youtube_rex = /youtube\.com.*v=(.+)$/
is_vimeo_rex   = /vimeo\.com.*\/(\d+)$/

posts = []
for item in data
  post = new Post
    type:         'video'
    publish_date: moment(item.publish_date, ["DD MMM, YYYY"]).toDate()
    title:        item.title
    source_url:   item.source_url

  pp = item.content.replace(/\n{2,}/, "\n").replace(/\ {2,}/, " ").split("\n")
  pp = [pp] if typeof pp is "string"
  pp = _.map pp, (p) -> "<p>#{p}</p>"
  post.content = post.excerpt = pp.join("")

  if is_youtube_rex.test(item.url)
    post.video = 
      provider: 'youtube'
      id: RegExp.$1
      url: item.url
  else if is_vimeo_rex.test(item.url)
    post.video = 
      provider: 'vimeo'
      id: RegExp.$1
      url: item.url
  else 
    throw "can't define video provider"

  posts.push(post)

request = require "request"

get_oembed_youtube = (->
  YOUTUBE_OEMBED_URL = "http://www.youtube.com/oembed"
  return (url, done) -> 
    request YOUTUBE_OEMBED_URL
    , qs:
        url: url
        format: 'json'
    , done
)()

get_oembed_vimeo = (->
  VIMEO_OEMBED_URL = "http://vimeo.com/api/oembed.json"
  return (url, done) -> 
    request VIMEO_OEMBED_URL
    , qs:
        url: url
    , done
)()

_.series [
  (clb) ->
    _.asyncEach posts
      , (post, cb) ->
        if post.video.provider is 'youtube'
          get_oembed_youtube post.video.url, (err, resp, body) ->
            try
              data = JSON.parse(body)
            catch e
              console.log "ERROR".red, "while parse", post.video.url, post.video.provider, e

            post.video.width            = data.width
            post.video.height           = data.height
            post.video.html             = data.html
            post.video.thumbnail.width  = data.thumbnail_width
            post.video.thumbnail.height = data.thumbnail_height
            post.video.thumbnail.url    = data.thumbnail_url
            post.video.title            = data.title
            post.video.description      = data.description
            post.video.author           = data.author_name
            cb()
        else
          get_oembed_vimeo post.video.url, (err, resp, body) ->
            try
              data = JSON.parse(body)
            catch e
              console.log "ERROR".red, "while parse", post.video.url, post.video.provider, e

            post.video.width            = data.width
            post.video.height           = data.height
            post.video.html             = data.html
            post.video.thumbnail.width  = data.thumbnail_width
            post.video.thumbnail.height = data.thumbnail_height
            post.video.thumbnail.url    = data.thumbnail_url
            post.video.title            = data.title
            post.video.description      = data.description
            post.video.author           = data.author_name
            cb()
      , clb
  (clb) ->
    Post.remove {}, clb
  (clb) ->
    _.asyncEach posts
      , (post, cb) -> 
        post.save(cb)
      , (err, results) ->
        unless err
          console.log "OK".green, posts.length
        else
          console.log "ERR:".red, red
        mg.disconnect()
      , clb
], (err, results) ->
  console.log "finish".cyan, err