mg = require "mongoose"
{Schema} = mg

MemberSchema = new Schema
  _id: String
  fullName: { type: String, trim: true }
  lastName: { type: String, trim: true }
  firstName: { type: String, trim: true }
  middleName: { type: String, trim: true }
  brotherName: { type: String, trim: true }
  male: Boolean
  position: { type: String, trim: true }
  birthDate: Date
  photoId: { type: String, trim: true }
  phone: String
  email: String
  skype: String
  info: String
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }
  , _id: false

exports.Member = mg.model('Member', MemberSchema)