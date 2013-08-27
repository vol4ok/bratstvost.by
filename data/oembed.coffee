require "colors"
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

get_oembed_youtube "http://www.youtube.com/watch?feature=player_embedded&v=CSYV9Ve4GGE", (err, resp, body) ->
  console.log "------- === --------".magenta
  console.log JSON.parse(body)

get_oembed_vimeo "https://vimeo.com/70393320", (err, resp, body) ->
  console.log "------- === --------".cyan
  console.log JSON.parse(body)
