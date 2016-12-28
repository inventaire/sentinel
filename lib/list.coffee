CONFIG = require 'config'
__ = CONFIG.root
_ = require './utils'
# keep in sync with inventaire/inventaire@server/db/couch/list.coffee default list
dbsNum = 7
agent = 'agent=sentinel'

module.exports = list = {}

# adding a agent=sentinel parameter to make it easier to spot in logs

list.nginx =
  url: "https://inventaire.io/?#{agent}"
  tests:
    content: (res)->
      /og:image/.test res.body

list.express =
  url: "https://inventaire.io/api/items/public?action=last-public-items&#{agent}"
  tests:
    content: (res)->
      { users, items } = res.body
      return users? and items?

list.prerender =
  url: "https://inventaire.io/entity/wd:Q535?_escaped_fragment_=&__refresh=true&#{agent}"
  tests:
    content: (res)->
      /Victor\sHugo/.test res.body

list.couchReplication =
  url: "#{CONFIG.db.fullHost()}/_active_tasks?#{agent}"
  tests:
    allDbs: (res)->
      res.body.length is dbsNum
    updated: (res)->
      dbs = res.body
      _.all dbs, dbUpToDate

list.wikidataSubsetSearchEngine =
  url: "https://data.inventaire.io/wikidata/humans/_search?q=Victor&#{agent}"
  tests:
    content: (res)->
      res.body.hits.total > 2500

list.maxlathPaper =
  url: "http://maxlath.eu/articles/paper-ethical-marketing/part-1/"
  tests:
    content: (res)->
      /neoliberal\srevolution/.test res.body

dbUpToDate = (db)->
  not _.expired secondsToMs(db.updated_on), 5*60*1000

secondsToMs = (sec)-> sec * 1000
