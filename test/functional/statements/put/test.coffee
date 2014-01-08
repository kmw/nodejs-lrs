fs = require "fs"

##
# start server
##
exampleStatements = require "example_statements.coffee"

require("setup_server.coffee").prepareTest (request) ->

  describe "PUT valid statement to /statements", ->
    it "responds with 204 No Content", (done) ->
      fs.readFile exampleStatements.minimalWithoutId, (err, data) ->
          request
            .put("/statements")
            .send(data)
            .expect(204, done)
