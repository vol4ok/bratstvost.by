mg = require "mongoose"
{Schema} = mg

MemberSchema = new Schema
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
  active: { type: Boolean, default: yes }
  orderNumber: { type: Number, default: 10 }

exports.Member = mg.model('Member', MemberSchema)