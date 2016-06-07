schedule = require 'node-schedule'
{ checkInterval, aliveConfirmationTime } = require 'config'
checker = require './lib/checker'
list = require './lib/list'
{ alert, confirmAlive } = require './lib/send_message'

console.log 'check interval'.blue, checkInterval
check = ->
  for label, targetData of list
    checker label, targetData, alert
check()
setInterval check, checkInterval

console.log 'alive confirmation time'.blue, aliveConfirmationTime
schedule.scheduleJob aliveConfirmationTime, confirmAlive
