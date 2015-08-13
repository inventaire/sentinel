# check status
# - a url to query
# - an expected status
# - a callback in case of failure

breq = require 'bluereq'
date = require './date'


module.exports = (label, targetData, alert)->
  { url, status, success, tests } = targetData
  status or= 200
  success or= defaultSuccess

  breq.get url
  .then (res)->
    { statusCode } = res
    unless res.statusCode is status
      throw statusError res

    passTests tests, res
    success label, res

  .catch alert.bind(null, label)

passTests = (tests, res)->
  for label, test of tests
    unless test res
      throw new Error "#{label} error"

statusError = (res)->
  err = new Error 'wrong HTTP statusCode'
  err.res = res
  err.statusCode = res.statusCode
  return err

defaultSuccess = (label, res)->
  console.log "#{date()} - #{label}: OK"
