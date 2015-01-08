socialcounts
============

Social counts for a given URL from FB, LinkedIn Twitter, Google+, StumbleUpon and 
Pinterest. It can be used as an API for your node application. Data is 
retrieved from the official buttons provided by the networks.

## Requirements

Need to install mongodb if you want to have a cache layer for your data.

[Mongodb](http://www.mongodb.org/downloads)

## Endpoints

```
https://api.facebook.com/method/links.getStats?urls=%%URL%%&format=json
http://urls.api.twitter.com/1/urls/count.json?url=%%URL%%&callback=twttr.receiveCount
http://www.linkedin.com/cws/share-count?url=%%URL%%
http://www.stumbleupon.com/services/1.01/badge.getinfo?url=%%URL%%
http://widgets.pinterest.com/v1/urls/count.json?source=6&url=%%URL%%
https://clients6.google.com/rpc?key=google_key (POST)
```

## Installation
```
$ npm install socialcountstracker
```

## Usage

### API
```
var socialcounts = require('socialcountstracker');

// Options that you can pass
// Following are the defaults

var options = {
  mongoActive: true,
  host: 'mongodb://localhost/socialcounts',
  limitResults: 100,
  // How long it uses the prev result, without inserting a new one
  cache_refresh: 24 * 3600,
  collectionName: 'social',
  facebook: true,
  twitter: true,
  pinterest: true,
  linkedin: true,
  googlePlus: true,
  stumbleUpon: true,
  google_token: ''  // TODO: Pass your google API Token
};

socialcounts.start({twitter: false, googlePlus: false}, function (cache) {
  socialcounts.getSocialCounts('www.ign.com', function (err, results) {
    console.log(results);
  });

  socialcounts.getSocialCounts('www.as.com', function (err, results) {
    console.log(results);
  });

  socialcounts.getSocialCounts('www.nytimes.com', function (err, results) {
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
