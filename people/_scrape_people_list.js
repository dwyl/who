var gs  = require('github-scraper');
var fs  = require('fs');
var org = 'dwyl';
var url = 'https://github.com/orgs/' + org + '/people';

gs(url, function(err, data) {
  console.log(data.entries); // or what ever you want to do with the data
  fs.writeFileSync(__dirname+'/_members.txt', data.entries);
})
