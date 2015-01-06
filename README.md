socialcounts
============

Social counts for a given URL from FB, LinkedIn Twitter, Google+, StumbleUpon and 
Pinterest. It can be used as an API for your node application. Data is 
retrieved from the official buttons provided by the networks.

## Requirements

Need to install mongodb if you want to have a cache layer for your data.

[mongodb]: http://www.mongodb.org/downloads  "Install Mongo DB"

## Endpoints

```
https://api.facebook.com/method/links.getStats?urls=%%URL%%&format=json
http://urls.api.twitter.com/1/urls/count.json?url=%%URL%%&callback=twttr.receiveCount
http://www.linkedin.com/cws/share-count?url=%%URL%%
http://www.stumbleupon.com/services/1.01/badge.getinfo?url=%%URL%%
http://widgets.pinterest.com/v1/urls/count.json?source=6&url=%%URL%%
https://clients6.google.com/rpc?key=AIzaSyCKSbrvQasunBoV16zDH9R33D88CeLr9gQ (POST)
```

## Installation
```
$ npm install socialcounts
```

## Usage

### API
```
var socialcounts = require('socialcounts');

# Options that you can pass
# Following are the defaults

options = {
  mongoActive: true
  host: 'mongodb://localhost/socialcounts'
  limitResults: 100
  collectionName: 'social'
  facebook: true
  twitter: true
  pinterest: true
  linkedin: true
  googlePlus: true
  stumbleUpon: true
}

socialcounts.start({twitter: false}, function (cache) {
  a.getSocialCounts('www.moz.com', function (err, results) {
    console.log(results);
  });
});
```


### Testing

```
$ npm run test
```

Or if you are changing lots of things:
```
$ npm run autotest
```
