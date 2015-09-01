var fs     = require('fs');
var sortBy = require('lodash.sortby');
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
// http://stackoverflow.com/a/10542368/1148249
var ladiesfirst = sortBy( people, 'lady' );
console.log(ladiesfirst);
fs.writeFileSync(__dirname + '/z_people.json',
JSON.stringify(ladiesfirst, null, 2) );
