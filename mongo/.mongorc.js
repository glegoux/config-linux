// .mongorc.js

var requestNb = 0;

var prompt = function() {

  requestNb++;

  var user = db.runCommand({connectionStatus:1}).authInfo.authenticatedUsers[0];
  var host = db.getMongo().toString().split(" ")[2];
  var port = host.split(":")[1] ? "" : ":27017";
  user = user ? user.user : "local";

  var p = "[" + requestNb + " " + "mongo://" + user + "@" + host + port + "/" + db + "]";

  var green = String("\033[1;32m");
  var end = String("\033[0m");

  return print(green + p + end);

}
