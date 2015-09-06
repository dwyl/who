// this script just executes the other node scripts in order:

var ordem = require('ordem'); // we need the scripts to be run in order...

ordem([
  function(callback){
    require('./_scrape_people_list.js')
    callback(null, 'done')
  },
  function(err, callback) {
    require('./_scrape_profiles.js');
    callback(null, 'done');
  },
  function(err, callback){
    require('./_combine_profiles.js')
    callback(null, 'done')
  }
], function callback(err, result) {
  console.log(result);
});
