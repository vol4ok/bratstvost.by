require "colors"
exs = require "express"
ect = require "ect"
mg  = require "mongoose"
moment = require "moment"
crypto = require "crypto"

mg.connect('mongodb://localhost/bratstvost-3')
{Event} = require "./models/event"
{Notice} = require "./models/notice"

_ = require "lodash"
require("uasync")(_)

app = exs()

app
  .disable("x-powered-by")
  .set("view engine", "ect")
  .engine('ect', ect(
      root : __dirname + '/views'
      ext : '.ect'
      cache: no
    ).render)

COOKIE_SECRET = 'tarasiki'
  
app 
  .use(exs.urlencoded())
  .use(exs.json())
  .use(exs.cookieParser(COOKIE_SECRET))
  .use(exs.session())
  .use(exs.logger("short"))
  .use(exs.static("public"))
  .use(app.router)


app.locals =
  formatDate: (date) -> moment(date).fromNow()

POST_PER_PAGE = 10

users = 
  vol4ok:
    login: 'vol4ok'
    name: 'Andrew Volkov'
    salt: 'TaRaSiKi'
    hash: 'vzk6xxSHKMcwoTpF6Ojht7KPLgMUMYU1ONbPHyWOKjctFS0iyEBOvIS0WpIvfLWp1/vb9oBzThIAt8iRumELLczs2CYf3BQo7NE9TcsWxtMvWLT3KYIK7QPbRSHldHypeM/UKVd29DNh9RmQ3t/17A9lhSFvOOg360Rx3CpV5Mw='

  nastena:
    login: 'nastena'
    salt: 'TaRaSiKi2013'
    hash: 'dHj7wHvFYX/RupWr5zRbtPKIWOUGge1jGJldlraZ1sJ+b2ANK7KWYNYpL5PZ2Tol6aGBUMEE+4LtR3CLviZiEvxczLQ5lZEyEFGb1gsNHhEfPv50rbSa0Micie+u0mF5kzKyyzn1fnvf3YEmyM19TSL8cPvtUVriv6RiuAA59iw='

PASS_SALT = "TaRaSiKi"
PASS_ITER = 5000
HASH_LEN  = 128

get_hash = (pwd, salt, fn) ->
  if arguments.length is 3
    crypto.pbkdf2 pwd, salt, PASS_ITER, HASH_LEN, (err, hash) -> 
      fn(err, (new Buffer(hash, 'binary')).toString('base64'))
  else
    fn = salt
    crypto.randomBytes len, (err, salt) ->
      return fn(err) if err
      salt = salt.toString('base64')
    crypto.pbkdf2 pwd, salt, PASS_ITER, HASH_LEN, (err, hash) -> 
      return fn(err) if err
      fn(err, salt, (new Buffer(hash, 'binary')).toString('base64'))


authenticate = (login, pass, done) ->
  return done(new Error('invalid arguments')) unless login and pass
  user = users[login]
  return done(new Error('user not found')) unless user
  get_hash pass, user.salt, (err, hash) ->
    return done(err) if (err)
    return done(null, user) if hash == user.hash
    done(new Error('invalid password'))


restrict = (req, res, next) ->
  if (req.session.user)
    next()
  else
    console.log "restricted!".red
    res.redirect('/login')

    

app.get '/login', (req, res) ->
  res.render 'login'

app.post "/login", (req, res) ->
  authenticate req.body.login, req.body.password, (err, user) ->
    if user
      req.session.regenerate ->
        req.session.user = user
        res.redirect("/")
    else
      res.redirect("/login")

app.get '/logout', (req, res) ->
  req.session.destroy ->
    res.redirect('/login')
    return

### EVENTS ###

app.get "/api/events", (req, res) ->
  console.log "GET /api/events"
  Event.find {}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

app.post "/api/events", restrict, (req, res) ->
  console.log "POST".green, "/api/events", req.body
  Event.create req.body, (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")

app.put "/api/events/:id", restrict, (req, res) ->
  # id = req.body._id
  delete req.body._id
  console.log "PUT".cyan, "/api/events", req.body
  Event.findByIdAndUpdate req.params.id, req.body, upsert: yes, (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")

app.del "/api/events/:id", restrict, (req, res) ->
  console.log "DELETE".red, "/api/events", req.params
  Event.findByIdAndRemove req.params.id, (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")


### ADS ###

app.get "/api/notice", (req, res) ->
  console.log "GET".green, "/api/notice"
  Notice.find {}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

app.post "/api/notice", restrict, (req, res) ->
  console.log "POST".cyan, "/api/notice", req.body
  Notice.create req.body, (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")

app.put "/api/notice/:id", restrict, (req, res) ->
  console.log "PUT".magenta, "/api/notice/:id", req.params, req.body
  delete req.body._id
  Notice.findByIdAndUpdate req.params.id, req.body, upsert: yes, (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")

app.del "/api/notice/:id", restrict, (req, res) ->
  console.log "DELETE".red, "/api/notice/:id", req.params
  Notice.findByIdAndRemove req.params.id, (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")

### NEWS ###

app.all "*", restrict, (req, res) ->
  console.log "GET all *", req.path
  res.render("index")

port = process.env.PORT || 5001
app.listen(port)
console.log "start server on port #{port}".green