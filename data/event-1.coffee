bson = require "bson"
mongoose = require "mongoose"
moment = require "moment"

mongoose.connect('mongodb://localhost/bratstvost')

{Event} = require "../event"

e1 = 
  date: "21.05.13 15:00"
  title: "Благотворительный концерт Ambre Hammond"
  desc: '''
    <p>Благотворительный концерт автралийской пианистки [Ambre Hammond](https://www.facebook.com/pages/Ambre-Hammond/112652052110017) для насельников интернатов.</p>
    <ul>
      <li><i class="map"></i>Столбцовкий психоневрологический интернат (д. Куль)</li>
      <li><i class="date"></i>вторник, 21 мая 2013 г.</li>
      <li><i class="time"></i>Начало в 15:00</li>
      <li>Выезд из Минска в 13:00</li>
      <li>Организаторы:
        <ul>
          <li>Братство святитеоя Спиридона Тримифунтского</li>
          <li>Blue Sky Talent Company</li>
        </ul>
      </li>
    </ul>
  '''
  published: yes

parse = (e) ->
  e._id = new bson.ObjectID
  date = e.date || "invalid date"
  e.updated = new Date
  if moment(date, "DD.MM.YY HH:mm").isValid()
    e.date = moment(date, "DD.MM.YY HH:mm").toDate()
    e.hasTime = yes
  else if moment(date, "DD.MM.YY").isValid()
    e.date = moment(date, "DD.MM.YY").toDate()
    e.hasTime = no
  ev = new Event(e)
  ev.save (err) ->
    console.log err
  return JSON.stringify(e, null, "  ")

console.log parse(e1)

mongoose.disconnect()



