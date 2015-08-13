breq = require 'bluereq'
quoteAPI = "http://quotesondesign.com/api/3.0/api-3.0.json"

module.exports = ->
  breq.get quoteAPI
  .then (res)->
    { quote, author } = res.body
    return "#{quote} -- #{author}"
