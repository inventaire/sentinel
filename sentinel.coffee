{ checkInterval, aliveConfirmationInterval } = require 'config'
checker = require './lib/checker'
list = require './lib/list'
{ alert, confirmAlive } = require './lib/send_message'


console.log 'checkInterval: ', checkInterval
console.log 'aliveConfirmationInterval: ', aliveConfirmationInterval

check = ->
  for label, targetData of list
    checker label, targetData, alert

setInterval check, checkInterval
setInterval confirmAlive, aliveConfirmationInterval
