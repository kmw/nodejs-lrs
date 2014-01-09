##
# start server
##

request = require('setup_test_env').testRequest

describe "GET", ->
  describe "/statements", ->
    it "responds with 200 OK", (done) ->
      request
        .get("/statements")
        .expect(200)
        .expect('Content-Type', /json/)
        #TODO validate value of 'X-Experience-API-Consistent-Through'
        .end done

  describe "/statements/id with a valid ID", ->
    it "responds with 200 OK and a valid StatementResult"
  describe "/statements/id with an invalid ID", ->
    it "responds with 404 Not Found"

# TODO: validate the returned statement
