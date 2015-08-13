CONFIG = require 'config'
__ = CONFIG.root
_ = require './utils'
dbsList = require('inv-dbs-list').default
dbsNum = Object.keys(dbsList).length

module.exports = list = {}

list.nginx =
  url: "https://inventaire.io/"
  tests:
    content: (res)->
      /og:image/.test res.body


list.express =
  url: "https://inventaire.io/api/items/public?action=last-public-items"
  tests:
    content: (res)->
      { users, items } = res.body
      return users? and items?


list.prerender =
  url: "https://inventaire.io/entity/wd:Q535?_escaped_fragment_="
  tests:
    content: (res)->
      /Victor\sHugo/.test res.body


list.couchReplication =
  url: "#{CONFIG.db.fullHost()}/_active_tasks"
  tests:
    allDbs: (res)->
      res.body.length is dbsNum
    updated: (res)->
      dbs = res.body
      _.all dbs, dbUpToDate

dbUpToDate = (db)->
  not _.expired secondsToMs(db.updated_on), 5*60*1000

secondsToMs = (sec)-> sec * 1000


list.invWdq =
  url: 'http://localhost:5353/claim?p=P50&q=Q692'
  tests:
    content: (res)->
      res.body.items.length >= 198