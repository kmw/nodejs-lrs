Validator = require "../../../../app/validator/validator.coffee"
fs = require "fs"
util = require "util"

data_path = "test/data/1.0.0/valid/statement/substatements/"

valid = (err, done) ->
  if err?
    done(new Error util.inspect err)
  else
    done()

val = new Validator "app/validator/schemas/"
      
fs.readdir data_path, (err, files) ->
  for file in files
    do (file) ->
      describe "Valid statement with substatement as object", ->
        describe "from #{file}", ->
          it "should be valid", (done) ->
            fs.readFile data_path + file, "utf8", (err, data) ->
              if err?
                done err
                return
              else
                try 
                  json = JSON.parse data
                catch error
                  done error
                  return
                val.validate json, (errors) ->
                  valid errors, done