{BHEvent} = require "./bh-event"
data = 
  title: "Молодечно"
  desc: "Выезд __на литургию__ с проживающими во взрослом психоневрологическом [интернате](#) г. Молодечно."
  #date: "20.04.13"
  #verified: yes
  info: [
    icon: "user"
    term: "Организатор в г. Минск"
    desc: "брат Владимир, тел. [8 (029) 873-31-83](phone:00375298733183)"
  ,
    icon: "user"
    term: "Организатор в г. Заславль"
    desc: "сестра Ангелина, тел. [8 (029) 159-77-04](phone:00375291597704)"
  ,
    icon: "time"
    term: "Время выезда"
    desc: "7:00"
  ,
    icon: "time"
    term: "Начало литургии"
    desc: "8:00"
  ]

event = new BHEvent(data)
event.export()