var gs  = require('github-scraper');
var url = 'https://github.com/orgs/dwyl/people';
var fs  = require('fs');

gs(url, function(err, data) {
  console.log(data.entries); // or what ever you want to do with the data
  fs.writeFileSync(__dirname+'/_members.txt', data.entries);
  data.entries.forEach(function(person){
    gs('/'+person, function(err, profile){
      profile.github = person;
      // console.log(profile);
      var json = {
        github : person,
        fullname: profile.fullname,
        website: profile.website || profile.url,
        avatar: profile.avatar
      }
      console.log(json);
      fs.writeFileSync(__dirname+'/'+person+'.json', JSON.stringify(json));
    });
  });
})
