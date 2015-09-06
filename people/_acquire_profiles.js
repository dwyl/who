// this script just executes the other node scripts in order:
require('./_scrape_people_list.js')

setTimeout(function() {
  require('./_scrape_profiles.js');
}, 2000);

setTimeout(function() {
  require('./_combine_profiles.js')
}, 5000);
