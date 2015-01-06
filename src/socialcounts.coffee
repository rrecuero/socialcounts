_ = require 'underscore'
async = require 'async'
ApiUrls = require './apiurls'
request = require 'request'
SocialCache = require './storage'
config = require '../config/settings'

module.exports = class SocialCounts
  start: (options, callback) ->
    # options is optional
    if _.isFunction options
      callback = options
      @options = {}
    @options = _.extend config, options
    @cache = new SocialCache @options
    @cache.connect callback

  makeSocialRequest = (socialApi, callback) ->
    res = {}
    [network, apiData, pageUrl] = socialApi
    @cache.getSocialResult pageUrl, network, (err, results) =>
      # cache hit
      if results?.length > 0
        res[network] = _.pluck results, 'data'
        callback err, res
      else
        # cache miss
        requestData = 
          method: if apiData.body? then 'post' else 'get'
          url: apiData.page
          json: true
          body: apiData.body
        request requestData, (error,response, body) =>
          if !error && response.statusCode == 200
            res[network] = [body]
            @cache.insertResult pageUrl, network, body, (err, result) ->
              console.log 'Data inserted', result
          callback error, res

  getSocialCounts: (url, callback) ->

    # handle the case when 'google.com' is passed in, instead
    # of 'http://google.com'
    unless /^http/.test(url) then url = 'http://' + url
    
    # filter out deactivated urls
    apis = _.pairs ApiUrls.createUrls url, ""
    apis = _.filter apis, (element) => @options[element[0]]
    apis = _.map apis, (element) =>
      element.push(url)
      element
    async.concat apis, _.bind(makeSocialRequest, @), (err, results) ->
      if err?
        console.warn 'Some social APIs failed', err
      cleanedResults = {}
      _.each results, (element) ->
         name = _.keys(element)[0]
         cleanedResults[name] = _.flatten _.values element
      callback err, cleanedResults

