module.exports =
  checkInterval: 5*60*1000
  aliveConfirmationTime:
    hour: 12
    minute: 0
  freeMobile:
    user: 12345678
    pass: 'freepwd'
  db:
    protocol: 'http'
    host: 'localhost'
    port: 5984
    username: 'couchusername'
    password: 'couchpassword'
    fullHost: -> "#{@protocol}://#{@username}:#{@password}@#{@host}:#{@port}"