# Description
#   A Hubot script that count public gists
#
# Configuration:
#   None
#
# Commands:
#   hubot gist-count <username> - count public gists
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  robot.respond /gist-count\s+(\S+)$/i, (res) ->
    user = res.match[1]
    url = "https://api.github.com/users/#{user}"
    res.http(url).get() (err, r, body) ->
      return res.robot.logger.error(err) if err?
      count = JSON.parse(body).public_gists
      res.send "https://gist.github.com/#{user} (#{count})"
