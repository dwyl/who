var gs  = require('github-scraper');
var url = 'https://github.com/orgs/dwyl/people';
var fs  = require('fs');

// load all the files in the people directory
var dir = fs.readdirSync('./people');
console.log(dir);
var profiles = dir.filter(function(file){ return file.match(/json/) });
console.log(' - - - - - - - - - - - - - - - - - ');
console.log(profiles);
// fs.readFileSync()
  // data.entries.forEach(function(person){
  //   gs('/'+person, function(err, profile){
  //     profile.github = person;
  //     // console.log(profile);
  //     var json = {
  //       github : person,
  //       fullname: profile.fullname,
  //       website: profile.website || profile.url,
  //       avatar: profile.avatar
  //     }
  //     json = JSON.stringify(json, null, 2);
  //     console.log(json);
  //     fs.writeFileSync(__dirname+'/'+person+'.json', json);
  //   });
  // });
