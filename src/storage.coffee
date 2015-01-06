_ = require 'underscore'
config = require '../config/settings'
{MongoClient} = require 'mongodb'

module.exports = class SocialCache
  dbcollections: {}

  constructor: (opts) ->
    @opts = opts

  connect: (cb) ->
    if not @opts.mongoActive
      cb?()
      return
    MongoClient.connect @opts.host,
      (err, db) =>
        if err
          console.error 'MongoClient err!', err
          @dbcollections = {}
          @db = null

          setTimeout =>
            @connect()
          , 1000
        else
          @db = db
          @applyIndexes()
          cb?()
  
  collections: (name) ->
    @dbcollections[name] ?= @db.collection name

  applyIndexes: ->
    @collections(@opts.collectionName).ensureIndex {network: 1, date: 1}, ->

  insertResult: (page, network, data, cb) ->
    if not @opts.mongoActive
      cb()
      return
    @collections(@opts.collectionName).insert {
        page: page,
        date: new Date(),
        data: data,
        network: network},
      (err, result) ->
        console.error('saving social result failed!', err) if err
        cb? err, result

  getSocialResult: (page, network, cb) ->
    if not @opts.mongoActive
      cb()
      return
    @collections(@opts.collectionName)
      .find({page: page, network: network}).limit(@opts.limitResults).toArray cb
