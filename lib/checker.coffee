# check status
# - a url to query
# - an expected status
# - a callback in case of failure

breq = require 'bluereq'
date = require './date'
_ = require './utils'


module.exports = (label, targetData, alert)->
  { url, status, success, tests } = targetData
  status or= 200
  success or= defaultSuccess

  breq.get url
  .then (res)->
    { statusCode } = res
    unless statusCode is status or statusCode is 304
      _.warn res.body, "#{label} res"
      throw statusError res

    passTests tests, res
    success label, res

  .catch alert.bind(null, label)

passTests = (tests, res)->
  for label, test of tests
    unless test res
      throw new Error "#{label} error"

statusError = (res)->
  err = new Error "wrong HTTP statusCode: #{res.statusCode}"
  err.res = res
  err.statusCode = res.statusCode
  return err

defaultSuccess = (label, res)->
  console.log "#{date()} - #{label}: OK"
