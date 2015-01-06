module.exports =
  createUrls: (page, GOOGLE_TOKEN) ->
    GOOGLE_PLUS_BODY = 
      method: "pos.plusones.get"
      id: "p"
      params:
        nolog: true
        id: page
        source: "widget"
        userId: "@viewer"
        groupId: "@self"
      jsonrpc: "2.0"
      key: "p"
      apiVersion: "v1"
    settings = 
      twitter:     
        page: "http://cdn.api.twitter.com/1/urls/count.json?url=#{page}"
      facebook:    
        page: "http://graph.facebook.com/?id=#{page}"
      pinterest:   
        page: "http://widgets.pinterest.com/v1/urls/count.json?source=6&url=#{page}"
      linkedin:    
        page: "http://www.linkedin.com/countserv/count/share?url=#{page}&format=json"
      stumbleUpon: 
        page: "http://www.stumbleupon.com/services/1.01/badge.getinfo?url=#{page}"
      googlePlus:  
        page: "https://clients6.google.com/rpc?key=#{GOOGLE_TOKEN}", body: GOOGLE_PLUS_BODY
    settings
