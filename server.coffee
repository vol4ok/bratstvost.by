require "colors"
exs = require "express"
ect = require "ect"
mg  = require "mongoose"
moment = require "moment"

mg.connect('mongodb://localhost/sample-blog')
{Post} = require "./models/post"

_ = require "lodash"
require("uasync")(_)

app = exs()

app
  .set("view engine", "ect")
  .engine('ect', ect(
      open: "{{"
      close: "}}"
      root : __dirname + '/views'
      ext : '.ect'
      cache: no
    ).render)
  
app 
  .use(exs.bodyParser())
  .use(exs.logger("tiny"))
  .use(exs.favicon())
  .use(app.router)
  .use(exs.static("public"))

app.locals =
  formatDate: (date) -> moment(date).fromNow()

POST_PER_PAGE = 3

app.get /^\/(\d*)$/, (req, res) ->
  page = if req.params[0] then parseInt(req.params[0], 10) else 1
  query = Post.find()
  _.parallel [
    (cb) -> query.count(cb)
    (cb) -> query.find().skip((page-1)*POST_PER_PAGE).limit(3).sort("-created").exec(cb)
  ], (err, results) ->
    count = Math.ceil(results[0]/POST_PER_PAGE)
    count = 10 if count > 10
    posts = results[1]
    res.render("index", {posts, count, page})

app.get "/create", (req, res) ->
  res.render("create")

app.get "/post/:id", (req, res) ->
  Post.findById req.params["id"], (err, post) ->
    res.render("show", {post})

app.get "/post/:id/update", (req, res) ->
  Post.findById req.params["id"], (err, post) ->
    res.render("update", {post})

app.get "/post/:id/delete", (req, res) ->
  Post.findByIdAndRemove req.params["id"], (err) ->
    res.redirect("/")

app.post "/create", (req, res) ->
  post = new Post(req.body)
  post.save ->
    res.redirect("/")

app.post "/post/:id", (req, res) ->
  post = req.body
  post.updated = new Date
  Post.findByIdAndUpdate req.params['id'], post, (err, post) ->
    res.redirect("/post/#{post._id}")

app.listen(3001)
console.log "start server on port 3001".green