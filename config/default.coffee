module.exports =
  checkInterval: 5*60*1000
  aliveConfirmationInterval: 24*60*60*1000
  freeMobile:
    user: 12345678
    pass: 'freepwd'
  db:
    protocol: 'http'
    host: 'localhost'
    port: 5984
    fullHost: -> "#{@protocol}://#{@host}:#{@port}"