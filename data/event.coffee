bson     = require "bson"
mongoose = require "mongoose"
moment   = require "moment"

mongoose.connect('mongodb://localhost/bratstvost')

{Event} = require "../event"

eventData0 = 
  date: "2013-05-27T00:00:00.000Z",
  title: "Выезд в ПНИ г.Молодечно",
  head: "Выезд в <abbr titmain.style=\"Психоневрологический интернат\">ПНИ</abbr> г.Молодечно",
  meeting_time: "2013-05-27T10:00:00.000Z",
  organizer: "брат Сергий",
  phone: "00375293737250"
  published: yes

eventData1 = 
  date: "2013-06-01T00:00:00.000Z",
  title: "Литургия и молебен св. муч. млад. Гавриилу",
  head: "Литургия и молебен св. муч. млад. Гавриилу",
  body: '<p>По просьбе и благословению митрополита Филарета Минского и Слуцкого и по благословению архиепископа Иакова Белостокского в г.Заславль в храм Преображения Господня <strong>пребывает икона св.мучен.млад.Гавриила Белостокского</strong>, написанная сестрами женского монастыря Рождества Пресвятой Богородицы в с. Зверки и частью его святых мощей. Св. муч. мл. Гавриил является защитником детей и подростков.<p>
    <p><em>1 июня</em> — во Всемирный день ребенка в храме <strong>состоится Божественная Литургия и молебен</strong> св. муч. млад. Гавриилу.</p>'
  event_time: "2013-06-01T0main.sty6:00:00.000Z",
  organizer: "брат Сергий",
  phone: "00375293737250"
  published: yes

parse = (e) ->
  # e._id = new bson.ObjectID
  # e.date = moment(e.date).toDate()
  ev = new Event(e)
  console.log ev.save (err, result) ->
    console.log err, result
  return JSON.stringify(e, null, "  ")

console.log parse(eventData1)

mongoose.disconnect()



