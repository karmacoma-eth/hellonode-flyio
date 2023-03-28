const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

app.get(["/", "/:name"], (req, res) => {
  // run `forge -V` and display the output
  const { execSync } = require("child_process");
  const forgeVersion = execSync("forge -V").toString();
  greeting = forgeVersion;

  name = req.params["name"];
  if (name) {
    res.send(greeting + "</br>and hello to " + name);
  } else {
    res.send(greeting);
  }
});

app.listen(port, () => console.log(`HelloNode app listening on port ${port}!`))

