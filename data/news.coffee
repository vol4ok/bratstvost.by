bson     = require "bson"
mongoose = require "mongoose"
moment   = require "moment"

mongoose.connect('mongodb://localhost/bratstvost')

{News} = require "../news"

newsData0 = 
  post_type: "video"
  date: "2013-05-20"
  title: "Десница Святителя Спиридона в Жировичах"
  body: "Видео «Десница Святителя Спиридона в Жировичах»"
  thumb: "/img/200513-nN8Fp-ufgOg.jpg"
  video: {
    host: "youtube"
    id: "nN8Fp-ufgOg"
  }
  published: yes

newsData1 = 
  post_type: "video"
  date: "2013-05-19"
  title: "Святитель Спиридон Тримифунтский"
  body: "Видео «Святитель Спиридон Тримифунтский»"
  thumb: "/img/200513-DM38ALfUfrQ.jpg"
  video: {
    host: "youtube"
    id: "DM38ALfUfrQ"
  }
  published: yes

newsData2 = 
  post_type: "text"
  date: "2013-05-27"
  title: "Состоялась поездка в д. Слободка"
  body: '''
    Состоялась поездка в д. Слободка.
    На воскресной литургии присутствовали наши братчики и насельники столбцовского ПНИ
    После литургии провели небольшой пикник. Также состоялась встреча с молодежной группой Свято-Елисаветинского монастыря на комсомольском озере
  '''
  published: yes

newsData3 = 
  post_type: "picture"
  date: "2013-05-26"
  title: "Литургия в д. Слободка"
  thumb: "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-ash3/s720x720/946202_472157826203068_1323519092_n.jpg"
  images: 
    m: [
      "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-ash3/s720x720/946202_472157826203068_1323519092_n.jpg",
      "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-ash4/s720x720/1004017_472157186203132_737022038_n.jpg",
      "https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-ash4/s720x720/1001156_472157109536473_1920798583_n.jpg",
      "https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-ash4/s720x720/1012631_472157739536410_599788722_n.jpg",
      "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-ash4/s720x720/1043893_472157679536416_1415256315_n.jpg",
      "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-prn1/s720x720/1010257_472158589536325_1924442442_n.jpg",
      "https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-prn1/s720x720/1012127_472158582869659_351700302_n.jpg",
      "https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-prn2/s720x720/1044177_472158476203003_1193433434_n.jpg",
      "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-ash3/s720x720/1010037_472159159536268_1397415689_n.jpg",
      "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn2/s720x720/1044068_472159562869561_2000322295_n.jpg",
      "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-prn1/s720x720/1017063_472159199536264_189106622_n.jpg",
      "https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-frc1/s720x720/998668_472159842869533_1595146902_n.jpg",
      "https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-frc1/s720x720/1004450_472160046202846_1303500595_n.jpg",
      "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-frc1/s720x720/1043876_472160199536164_1752962006_n.jpg",
      "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-ash3/s720x720/10339_472160656202785_684034198_n.jpg",
      "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-ash4/s720x720/1000133_472160619536122_1568957591_n.jpg",
      "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-ash4/s720x720/1044043_472160756202775_478200486_n.jpg",
      "https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-ash4/s720x720/1004027_472161132869404_1209380998_n.jpg",
      "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-prn1/s720x720/1010519_472161339536050_2014857566_n.jpg",
      "https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-frc1/s720x720/1002965_472161542869363_579748450_n.jpg",
      "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn1/s720x720/1010521_472162016202649_1448756743_n.jpg",
      "https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-prn1/s720x720/936446_472161962869321_530633113_n.jpg",
      "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-ash4/s720x720/1001497_472162079535976_1735558369_n.jpg",
      "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-ash4/s720x720/999676_472162596202591_1543991926_n.jpg",
      "https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-frc1/s720x720/998830_472163082869209_504898723_n.jpg"
    ]
  body: '''
    Литургия в храме Георгия Победоносца, д. Слободка. На воскресной литургии присутствовали наши братчики и насельники столбцовского ПНИ
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



