bson = require "bson"
mongoose = require "mongoose"
moment = require "moment"

mongoose.connect('mongodb://localhost/bratstvost')

{Event} = require "../event"

e1 = 
  date: "21.05.13 15:00"
  title: "Встреча мощей святителя Спиридона"
  desc: '''
    <p>Встреча мощей святителя Спиридона Тримифунтского.<br>Всем братиям и сестрам обязательно иметь при себе беджики (для тех кто их уже получил)</p>
    <ul>
      <li>Место прибытия: Аэропорт «Минск-2»</li>
      <li>Время прибытия: 19:00</li>
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



