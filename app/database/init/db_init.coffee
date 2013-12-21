config = require '../../config.coffee'
cradle = require 'cradle'
fs = require 'fs'

# A class for initialise the database.
# Only run me once.
#
class InitialiseDataBase

  # Must only be runned once while app installing.
  # Create and fill the database if not exists.
  #
  constructor: ->
    @_createDataBase()

  # Used to create a database, upload views and fill the database with some sample data.
  # Views contained in `app/db-init/views`.
  # Sample data contained in `app/db-init/exampleData.json`. 
  #
  # @private
  #
  _createDataBase: ->
    dbHost = config.dbConfig.dbHost
    dbPort = config.dbConfig.dbPort
    dbName = config.dbConfig.dbName
    
    conn = new (cradle.Connection) dbHost, 5984, 
                                                cache: true 
                                                raw: false
    database = conn.database dbName
    
    console.log "Try to connect to database server (#{dbHost}:#{dbPort}) and create database '#{dbName}'..."

    database.exists (err, exists) ->
      if err
        console.error "Error while connect to database server!"
        console.error err

      else if exists
        console.log "the database '#{dbName}' already exists! Views and sample data will not be imported!"
      else
        database.create()
        
        # import views
        fs.readdir 'data/views', (err, files) ->
          if err
            console.error "Error while read views folder!"
            console.error err
            database.destroy()
          else
          	for file in files
          	  fs.readFile "data/views/#{file}", (err, contents) ->
                if err
                  console.error "Error while read sample data file #{file}!"
                  console.error err
                  database.destroy()
                else
                  database.save '_design/find_by', JSON.parse contents
                  
        # import data    
        fs.readFile 'data/example_data.json', (err, contents) ->
          if err
            console.error "Error while read sample data file!"
            console.error err
            database.destroy()
          else
            database.save JSON.parse contents
            
        console.log "done."  
        
              
new InitialiseDataBase()

module.exports = InitialiseDataBase