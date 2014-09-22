// Description
//   A Hubot script that count public gists
//
// Configuration:
//   None
//
// Commands:
//   hubot gist-count <username> - count public gists
//
// Author:
//   bouzuya <m@bouzuya.net>
//
module.exports = function(robot) {
  return robot.respond(/gist-count\s+(\S+)$/i, function(res) {
    var url, user;
    user = res.match[1];
    url = "https://api.github.com/users/" + user;
    return res.http(url).get()(function(err, r, body) {
      var count;
      if (err != null) {
        return res.robot.logger.error(err);
      }
      count = JSON.parse(body).public_gists;
      return res.send("https://gist.github.com/" + user + " (" + count + ")");
    });
  });
};
