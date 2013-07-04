bson     = require "bson"
mongoose = require "mongoose"
moment   = require "moment"

mongoose.connect('mongodb://localhost/bratstvost')

{News} = require "../news"

newsData0 = 
  post_type: "picture"
  date: "2013-06-02"
  title: "День защиты детей, 1 июня"
  body: "В храме Преображения Господня в г. Заславле была литургия и акафист перед иконой мч. Гавриила Белостокского. После литургии состоялась трапеза и часть выход на озера."
  thumb: "/img/thumb/20130602-0.jpg"
  images: 
    dir: "/img/20130602-0"
    sizes: ["l", "m", "s"]
    names: [
      "photo-1.jpg"
      "photo-2.jpg"
      "photo-3.jpg"
      "photo-4.jpg"
      "photo-5.jpg"
      "photo-6.jpg"
      "photo-7.jpg"
      "photo-8.jpg"
    ]
  published: yes

newsData1 = 
  post_type: "picture"
  date: "2013-06-02"
  title: "Пикник в Дражне"
  body: "Выезд с насельниками интерната в Дражне на пикник."
  thumb: "/img/thumb/20130602-1.jpg"
  images: 
    dir: "/img/20130602-1"
    sizes: ["l", "m", "s"]
    names: [
      "photo-1.jpg"
      "photo-2.jpg"
      "photo-3.jpg"
      "photo-4.jpg"
      "photo-5.jpg"
      "photo-6.jpg"
      "photo-7.jpg"
      "photo-8.jpg"
    ]
  published: yes

newsData2 = 
  post_type: "link"
  date: "2013-05-29"
  link: "http://sobor.by/foto.php?cont=internat_kul_bratstvo_spiridona-5-2013"
  body: '''
    Впервые за 50 лет существования интерната в Куле проживающие в нём люди причащались в храме
  '''
  published: yes


parse = (e) ->
  news = new News(e)
  console.log news.save (err, result) ->
    console.log err, result
  return JSON.stringify(e, null, "  ")

console.log parse(newsData0)
console.log parse(newsData1)
console.log parse(newsData2)
console.log parse(newsData3)

mongoose.disconnect()



