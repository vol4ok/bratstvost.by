_        = require "lodash"
qs       = require "querystring"
express  = require "express"
{spawn}  = require "child_process"
fs       = require "fs"
request  = require "request"

ALBUMS_JSON_PATH = "../../temp/albums.json"
ACCESS_JSON_PATH = "../../temp/access.json"


require("uasync")(_)
require "colors"

LOCAL_PORT     = 1111
REMOTE_PORT    = 1111
SSH_USER_HOST  = "root@vol4ok.com"
APP_ID         = "665715423444899"
APP_SECRET     = "cc8f2368d65b1ca812e334dbd6003410"
POST_LOGIN_URL = "http://oauth.bratstvost.by/"
FB_SCOPE       = "publish_stream,manage_pages"
USER_ID        = "1426581922"
PAGE_ID        = "444251692327015"

ssh = spawn('ssh', ['-N', '-R', "#{REMOTE_PORT}:localhost:#{LOCAL_PORT}", SSH_USER_HOST])
app = express()
  .use(express.favicon())
  .use(express.query())
  .use(express.bodyParser())
  .use(express.logger("tiny"))

app.configure ->
  @settings.access_token = false
  try
    json = fs.readFileSync(ACCESS_JSON_PATH, "utf-8")
    @settings.access_token = JSON.parse(json).access_token
    console.log "load access_token OK!".grey
  catch e
    console.log "load access_token failed!".yellow

auth = (req, res, done) ->
  console.log "auth".cyan
  if app.settings.access_token
    console.log "access_token OK!".grey
    done()
  else
    if req.query.code
      console.log "- pahse 2".grey
      request 
        url: "https://graph.facebook.com/oauth/access_token",
        qs:
          client_id: APP_ID
          redirect_uri: POST_LOGIN_URL
          client_secret: APP_SECRET
          code: req.query.code
      , (error, response, body) ->
        console.log "- pahse 3".grey
        args = qs.parse(body)
        app.settings.access_token = args["access_token"]
        res.redirect("/")
        fs.writeFile ACCESS_JSON_PATH, JSON.stringify(args), "utf-8", -> 
          console.log "save access_token - OK!".grey
    else
      console.log "get access_token pahse 1"
      auth_url = "https://www.facebook.com/dialog/oauth?" + 
        qs.stringify
          client_id: APP_ID
          redirect_uri: POST_LOGIN_URL
          scope: FB_SCOPE
      console.log "- pahse 1".grey
      res.redirect(auth_url)

getPageAccessToken = (cb) ->
  console.log arguments.length, arguments
  if app.settings.page_access_token
    console.log "getPageAccessToken".grey
    cb()
  else
    console.log "getPageAccessToken".green
    request 
      url: "https://graph.facebook.com/#{USER_ID}/accounts",
      qs: access_token: app.get("access_token")
    , (error, response, body) ->
      data = JSON.parse(body).data[0]
      console.log "PageAccessToken: #{data.access_token}".grey
      app.settings.page_access_token = data.access_token
      cb()

enumPageAlbums = (cb) ->
  request 
    url: "https://graph.facebook.com/#{PAGE_ID}/albums",
    qs: 
      fields: "id,created_time,name,description,count,type,cover_photo,link,photos.fields(picture,source).limit(999)"
      access_token: app.get("page_access_token")
  , (error, response, body) ->
    data = JSON.parse(body)
    console.log data
    cb(data)

enumPagePhotos = (id, cb) ->
  request 
    url: "https://graph.facebook.com/#{id}/photos",
    qs: access_token: app.get("page_access_token")
  , (error, response, body) ->
    obj = JSON.parse(body)
    console.log obj
    cb(obj.data)

getPhotos = (req, res) ->
  getPageAccessToken () ->
    enumPageAlbums (data) ->
      newsList = []
      data = _.reject data.data, (item) -> item.type isnt "normal"
      for item in data
        news = 
          post_type: "picture"
          date: item.created_time
          title: item.name || ""
          body: item.description || ""
          published: yes
          thumb: ""
          images: {
            s: []
            m: []
            l: []
          }
        for img in item.photos.data
          news.images.s.push(img.picture)
          news.images.m.push(img.source)
          news.images.l.push(img.source)
          if img.id is item.cover_photo
            news.thumb = img.source
        newsList.push(news)

      json = JSON.stringify(newsList, null, "  ")
      res.send("<pre style=\"background: black; color: lime; font: 11px menlo;\">#{json}</pre>")
      fs.writeFileSync(ALBUMS_JSON_PATH, json, "utf-8")

    # enumPagePhotos "472153736203477", (data) ->
    #   images = []
    #   for item in data
    #     console.log item.source
    #     images.push(item.source)
    #   console.log images
    #   res.send "<pre>#{JSON.stringify(images, null, "  ")}</pre>"
    #res.send("<pre>#{JSON.stringify(data, null, "  ")}</pre>")

app.get "/", auth, getPhotos

srv = app.listen(LOCAL_PORT)
console.log "start server".green