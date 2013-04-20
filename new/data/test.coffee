require "./translit"
moment = require "moment"

d = new Date
a = "Молодечно"
console.log "#{a.translit()}-#{moment(d).format("DD.MM.YY")}"