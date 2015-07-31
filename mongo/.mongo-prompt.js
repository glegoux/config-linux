// ~/.mongo-prompt.js
//
// Create this symbolic link :
//   ln -s "$PWD/.mongo-prompt.js" ~/.mongo-prompt.js
// Add this alias in ~/.bash_aliases :
//   alias mongo='mongo ~/.mongo-prompt.js --shell'
// executed \mongo don't use this alias.

var requestNb = 0;

var prompt = function() {

  requestNb++;

  var user = db.runCommand({connectionStatus:1}).authInfo.authenticatedUsers[0];
  var host = db.getMongo().toString().split(" ")[2];
  var port = host.split(":")[1] ? "" : ":27017";
  user = user ? user.user : "local";

  var p = "[" + requestNb + " " + "mongo://" + user + "@" + host + port + "/" + db + "]";

  var beginGreen = String("\033[1;32m");
  var endGreen = String("\033[0m");

  return print(beginGreen + p + endGreen);

}
