parsePhone = (phone) ->
  res = ""
  for c,i in phone
    res += c if c in "+0123456789".split("")
  return {
    nums: res.slice(-7)
    code: res.slice(-9,-7)
  }

formatPhoneNice = (p) ->
  p = parsePhone(p) if typeof p is "string"
  n = p.nums.split("")
  return "8 (0#{p.code}) #{n[0]}#{n[1]}#{n[2]}-#{n[3]}#{n[4]}-#{n[5]}#{n[6]}"

formatPhoneRaw = (p) ->
  p = parsePhone(p) if typeof p is "string"
  return "+375#{p.code}#{p.nums}"

formatPhone = (p) ->
  p = parsePhone(p)
  return "<a href=\"phone:#{formatPhoneRaw(p)}\">#{formatPhoneNice(p)}</a>"

angular.module('appLibs').factory "phoneHelpers", ->
  return {
    parsePhone
    formatPhoneNice
    formatPhoneRaw
    formatPhone
  }