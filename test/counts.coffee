{expect} = require 'chai'
fs = require 'fs'
SocialCounts = require '../src/socialcounts'

describe 'SocialCounts', ->
  results = {}
  cresults = {}
  counts = new SocialCounts()
  before (done) ->
    counts.start {}, (cache) ->
      counts.getSocialCounts 'www.moz.com', (err, res) ->
        results = res
        counts.getSocialCounts 'www.moz.com', (err, res) ->
          cresults = res
          done()

  describe 'cache', ->

    it 'returns the same format than fresh requests', ->
      expect(results).to.deep.equal(cresults)

  describe 'facebook', ->
  
    it 'facebook endpoint works and format is correct', ->
      expect(results.facebook).to.not.be.empty
      expect(results.facebook[0]).to.include.keys [
        'id'
        'shares'
      ]

  describe 'twitter', ->
  
    it 'twitter endpoint works and format is correct', ->
      expect(results.twitter).to.not.be.empty
      expect(results.twitter[0]).to.include.keys [
        'url'
        'count'
      ]

  describe 'stumbleUpon', ->
  
    it 'stumbleUpon endpoint works and format is correct', ->
      expect(results.stumbleUpon).to.not.be.empty
      expect(results.stumbleUpon[0].result).to.include.keys [
        'url'
        'views'
      ]

  describe 'googleplus', ->
  
    it 'googleplus endpoint works and format is correct', ->
      expect(results.googlePlus).to.not.be.empty
      expect(results.googlePlus[0]).to.include.keys [
        'id'
      ]

  describe 'linkedin', ->
  
    it 'linkedin endpoint works and format is correct', ->
      expect(results.linkedin).to.not.be.empty
      expect(results.linkedin[0]).to.include.keys [
        'count'
        'url'
      ]

  describe 'pinterest', ->
  
    it 'pinterest endpoint works and format is correct', ->
      expect(results.pinterest).to.not.be.empty
      expect(results.pinterest[0]).to.include('count')
