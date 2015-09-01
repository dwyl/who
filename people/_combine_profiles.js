var fs  = require('fs');
// load all the files in the people directory
var dir = fs.readdirSync('./people');
// console.log(dir);
var profiles = dir.filter(function(file){
  return file.match(/\.json/) && file.indexOf('z_people.json') === -1;
});
// console.log(' - - - - - - - - - - - - - - - - - PROFILES');
// console.log(profiles);

var people = [];
profiles.forEach( function (p) {
  var filename = __dirname + '/' + p
  // console.log(filename)
  var json = require(filename);
  // console.log(json);
  // tidy up json strings (we want them to be "pretty" on GitHub)
  var str = JSON.stringify(json).replace(/\\n/g,'').replace(/\s+/g, '');
  // console.log(json);
  var parsed = JSON.parse(str) // , null, 2);
  if(parsed.lady === undefined){
    parsed.lady = 0;
  }
  // console.log(parsed);
  people.push(json);
});
// http://stackoverflow.com/a/1129270/1148249
function compare(a,b) {
  if (a.lady< b.lady)
    return -1;
  if (a.lady > b.lady)
    return 1;
  return 0;
}

people.sort(compare);

// console.log(people);
fs.writeFileSync(__dirname + '/z_people.json', JSON.stringify(people, null, 2) );
