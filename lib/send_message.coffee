CONFIG = require 'config'
_ = require './utils'
breq = require 'bluereq'
date = require './date'
getQuote = require './get_quote'

{ user, pass } = CONFIG.freeMobile

baseUrl = "https://smsapi.free-mobile.fr/sendmsg"

sendMsg = (msg)->
  breq.post baseUrl,
    user: user
    pass: pass
    msg: msg

module.exports =
  alert: (label, err)->
    now = date()
    sendMsg "[SERVER ALERT]\n#{label}: #{err.message}\n#{now}"
    .then (res)-> _.warn now, '- alert sent'
    .catch _.Error('alert error')

  confirmAlive: ->
    now = date()
    getQuote()
    .then _.Log('quote')
    .then Format('[ALIVE]', now)
    .then sendMsg
    .then (res)-> _.warn now, res.statusCode, '- alive msg sent'
    .catch _.Error('alive msg error')

Format = (tag, date)-> (msg)-> "#{tag}\n#{msg}\n#{date}"