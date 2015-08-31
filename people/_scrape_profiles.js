var gs  = require('github-scraper');
var url = 'https://github.com/orgs/dwyl/people';
var fs  = require('fs');

// load all the files in the people directory
var dir = fs.readdirSync('./people');
console.log(dir);
var profiles = dir.filter(function(file){ return file.match(/json/) });
console.log(' - - - - - - - - - - - - - - - - - PROFILES');
console.log(profiles);
var lists = dir.filter(function(file){ return file.match(/csv/) });
console.log(' - - - - - - - - - - - - - - - - - ');
console.log(lists)
var people = [];
lists.forEach( function (list) {
  var names = fs.readFileSync(__dirname+'/'+list, 'utf8').trim().split('\n');
  // console.log(names);
  names.forEach(function(name){ people.push(name) })
});
// remove duplicate people to avoid re-crawling
var unique = people.filter(function(item, pos) {
    return people.indexOf(item) == pos;
}) // http://stackoverflow.com/a/9229821/1148249

var profiles_str = profiles.join(', '); // string match is easier
// only scrape profile page for people we don't already have
var joiners = people.filter(function(person) {
    return profiles_str.indexOf(person) === -1;
})
console.log(' - - - - - - - - - - - - - - - - - JOINERS');

console.log(joiners);
joiners.forEach(function(person){
  gs('/'+person, function(err, profile){
    profile.github = person;
    // console.log(profile);
    var json = {
      github : person,
      fullname: profile.fullname,
      website: profile.website || profile.url,
      avatar: profile.avatar
    }
    json = JSON.stringify(json, null, 2);
    console.log(json);
    fs.writeFileSync(__dirname+'/'+person+'.json', json);
  });
});
