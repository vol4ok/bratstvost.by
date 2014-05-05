parsePhone = (phone) ->
  res = ""
  for c,i in phone
    res += c if c in "+0123456789".split("")
  val = {
    nums: res.slice(-7)
    code: res.slice(-9,-7)
  }

  return if val.nums.leangth < 7 then null else val

formatPhoneNice = (p) ->
  p = parsePhone(p) if typeof p is "string"
  return "" unless p
  n = p.nums.split("")
  return "8 (0#{p.code}) #{n[0]}#{n[1]}#{n[2]}-#{n[3]}#{n[4]}-#{n[5]}#{n[6]}"

formatPhoneRaw = (p) ->
  p = parsePhone(p) if typeof p is "string"
  return "" unless p
  return "+375#{p.code}#{p.nums}"

formatPhoneLink = (phone_str) ->
  if phone = parsePhone(phone_str)
    return "<a href=\"tel:#{formatPhoneRaw(phone)}\">#{formatPhoneNice(phone)}</a>"
  return ""

angular.module('appLibs').factory "phoneHelpers", ->
  return {
    parsePhone
    formatPhoneNice
    formatPhoneRaw
    formatPhoneLink
  }