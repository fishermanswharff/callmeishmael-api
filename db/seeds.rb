ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

puts 'Creating users…'
users = User.create!([
  {
    firstname: 'Jason',
    lastname: 'Wharff',
    username: 'jasonwharff',
    role: 'admin',
    email: 'fishermanswharff@mac.com',
    phonenumber: 6173889520,
    password_digest: "$2a$10$g0nkXPBOkJWCaCquG49Z8O3wutYc/wWY1sEkHy8qDQqwBM5mLzcHC",
    token: "53193128a1ce4fcc8a57b4c95268c3ba",
  },
  {
    firstname: 'Logan',
    lastname: 'Smalley',
    username: 'logansmalley',
    role: 'admin',
    email: 'logan@test.com',
    phonenumber: 5554443333,
    password_digest: '$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq',
    token: '155a18a873bf4078b60bed27936f2f55'
  },
  {
    firstname: "Shawn",
    lastname: "Kotoske",
    username: "shawnkotoske",
    role: 'admin',
    email: "shawn@test.com",
    phonenumber: 5748509840,
    password_digest: "$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq",
    token: "5f780acadc3d4091b88749e8e289de49",
  },
  {
    firstname: "Chris",
    lastname: "Spence",
    username: "chrisspence",
    role: 'admin',
    email: "chris@test.com",
    phonenumber: 5085071285,
    password_digest: "$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq",
    token: "658ad3dfbbbc4230a2d989053d25830d",
  },
  {
    firstname: "Ayodamola",
    lastname: "Okunseinde",
    username: "ayodamolaokunseinde",
    role: 'admin',
    email: "ayo@test.com",
    phonenumber: 5554443333,
    password_digest: "$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq",
    token: "0ca0b535bb8245bc82d2726ced45c741",
  },
  {
    firstname: "Andy",
    lastname: "Cavatorta",
    username: "andycavatorta",
    role: 'admin',
    email: "andy@test.com",
    phonenumber: 5554443333,
    password_digest: "$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq",
    token: "b0607162ae7f41baa78f2b7266520b09",
  },
  {
    firstname: "joe",
    lastname: "user",
    username: "joeuser",
    role: 'venue_admin',
    email: "joe@user.com",
    phonenumber: 5554443333,
    password_digest: "$2a$10$n7Buns1Q3ZoRvN.SKUGFy.TsjkmjQ/EqSdm2vmXG1jf51Wa1PgQCi",
    token: "462e4dce8ceb43d7a801e7210ca9073a",
  }
])
puts "seeded #{users.length} users:"
users.each { |u| p "#{u.firstname} #{u.lastname}" }
puts "\n\n"

puts 'Seeding venues…'
venues = Venue.create!([
  { name: 'The Strand'  },
  { name: 'Reading Rainbow' },
  { name: 'Sesame Street' },
  { name: '21 Shepard St.', status: 'paused' },
])
venues.first.users << User.find_by_email('fishermanswharff@mac.com')
venues.first.users << User.find_by_email('shawn@test.com')
venues.first.users << User.find_by_email('logan@test.com')
venues.first.users << User.find_by_email('chris@test.com')
venues.first.users << User.find_by_email('ayo@test.com')
venues.first.users << User.find_by_email('andy@test.com')
venues.first.users << User.find_by_email('joe@user.com')
venues.second.users << User.find_by_email('fishermanswharff@mac.com')
venues.second.users << User.find_by_email('joe@user.com')
venues.third.users << User.find_by_email('fishermanswharff@mac.com')
venues.fourth.users << User.find_by_email('fishermanswharff@mac.com')

puts "Seeded #{venues.length} venues:"
venues.each { |v| p v.name + " has #{v.users.length} users" }
puts "\n\n"

puts 'Seeding Phones:'
phones = Phone.create!([
  { wifiSSID: '78:31:c1:cd:c6:82', wifiPassword: 'secret', venue: Venue.find_by_name('The Strand') },
  { wifiSSID: '71:30:b1:bc:c4:78', wifiPassword: 'password', venue: Venue.find_by_name('The Strand') },
  { wifiSSID: '72:33:a2:ad:c2:69', wifiPassword: 'password', venue: Venue.find_by_name('Reading Rainbow') },
  { wifiSSID: '72:33:a2:ad:c2:69', wifiPassword: 'password', venue: Venue.find_by_name('Reading Rainbow') },
  { wifiSSID: '32:21:d2:bd:a1:85', wifiPassword: 'password', venue: Venue.find_by_name('Sesame Street') },
])
puts "Seeded #{phones.length} phones:"
phones.each { |p| p "#{p.unique_identifier} at venue #{p.venue.name}" }
puts "\n\n"

puts 'Seeding stories…'
stories = Story.create!([
  { title: 'On Looking', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/699-On-Looking-by-Alexandra-Horowitz-final.aif', story_type: 'fixed', author_last: 'Horowitz' },
  { title: 'Extremely Loud and Incredibly Close', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/703-Extremely-Loud-and-Incredibly-Close-by-Jonathan-Safran-Foer-final.aif', story_type: 'fixed', author_last: 'Safran Foer' },
  { title: 'Pajama Time', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/71-Pajama-Time-by-Sandra-Boynton-final.aif', story_type: 'fixed', author_last: 'Boynton' },
  { title: 'Merriam Webster Dictionary', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/020-Merriam-Webster-Dictionary-final.aif', story_type: 'fixed', author_last: 'Webster' },
  { title: 'The Sneetches', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/028-The-Sneetches-by-Dr-Seuss-final.aif', story_type: 'fixed', author_last: 'Seuss' },
  { title: 'Pride And Prejudice', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/313-Pride-And-Prejudice-by-Jane-Austen-final.aif', story_type: 'fixed', author_last: 'Austen' },
  { title: 'Anna Karenina', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/323-Anna-Karenina-by-Leo-Tolstoy-final.aif', story_type: 'fixed', author_last: 'Tolstoy', author_first: 'Leo' },
  { title: 'The Fault In Our Stars', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/074-Fault-In-Our-stars-by-John-Green-final.aif', story_type: 'fixed', author_last: 'Green', author_first: 'John' },
  { title: 'Harry Potter', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/451-Harry-Potter-by-J.K.-Rowling-final.aif', story_type: 'fixed', author_last: 'Rowling' },
  { title: 'The Oldest Living Things in the World', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/564-The-Oldest-Living-Things-in-the-World-by-Rachel-Sussman-final.aif', story_type: 'fixed', author_last: 'Sussman', author_first: 'Rachel' },
  { title: 'A Short History of Nearly Everything', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/592-A-Short-History-of-Nearly-Everything-by-Bill-Bryson-final.aif', story_type: 'fixed', author_last: 'Bryson' },
  { title: 'Not Even Wrong', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/64-Not-Even-Wrong-by-Paul-Collins-final.aif', story_type: 'fixed', author_last: 'Collins'},
  { title: 'Tiny Beautiful Things', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/777-Tiny-Beautiful-Things-by-Cheryl-Strayed-final.aif', story_type: 'venue', author_last: 'Strayed'},
  { title: 'Lets Pretend This Never Happened', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/800-Lets-Pretend-This-Never-Happened-by-Jenny-Lawson-final.aif', story_type: 'venue', author_last: 'Lawson'},
  { title: 'To Kill a Mockingbird', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/888-To-Kill-a-Mockingbird-by-Harper-Lee-final.aif', story_type: 'venue', author_last: 'Lee'}
])
puts "Seeded #{stories.length} stories: "
stories.each { |s| p "#{s.title} by #{s.author_last}, story_type: #{s.story_type}" }
puts "\n\n"

puts 'Seeding buttons…'
buttons = Button.create!([
  { assignment: '*', story: Story.find_by_title('On Looking'), phone: phones[0] },
  { assignment: '#', story: Story.find_by_title('Extremely Loud and Incredibly Close'), phone: phones[0] },
  { assignment: '0', story: Story.find_by_title('Pajama Time'), phone: phones[0] },
  { assignment: '1', story: Story.find_by_title('Merriam Webster Dictionary'), phone: phones[0] },
  { assignment: '2', story: Story.find_by_title('The Sneetches'), phone: phones[0] },
  { assignment: '3', story: Story.find_by_title('Pride And Prejudice'), phone: phones[0] },
  { assignment: '4', story: Story.find_by_title('Anna Karenina'), phone: phones[0] },
  { assignment: '5', story: Story.find_by_title('The Fault In Our Stars'), phone: phones[0] },
  { assignment: '6', story: Story.find_by_title('Harry Potter'), phone: phones[0] },
  { assignment: '7', story: Story.find_by_title('The Oldest Living Things in the World'), phone: phones[0] },
  { assignment: '8', story: Story.find_by_title('A Short History of Nearly Everything'), phone: phones[0] },
  { assignment: '9', story: Story.find_by_title('Not Even Wrong'), phone: phones[0] },
])
puts "Seeded #{buttons.length} buttons as a join table:"
buttons.each { |b| p "#{b.assignment} button is assigned #{b.story.title} on phone #{b.phone.unique_identifier} at venue #{b.phone.venue.name}" }
puts "\n\n"

puts 'Done seeding the database. Farewell.'

# curl -d "user[firstname]=Jason&user[lastname]=Wharff&user[password]=Rolla@1878&user[password_confirmation]=Rolla@1878&user[username]=jasonwharff&user[email]=fishermanswharff@mac.com&user[role]=admin&user[phonenumber]=6173889520" -X POST localhost:3000/admin/users
# curl -d "user[firstname]=Shawn&user[lastname]=Kotoske&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=shawnkotoske&user[email]=jasonwharff@gmail.com&user[role]=admin&user[phonenumber]=5748509840" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# curl -d "user[firstname]=Chris&user[lastname]=Spence&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=chrisspence&user[email]=jason@thinqmail.com&user[role]=admin&user[phonenumber]=5085071285" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# curl -d "user[firstname]=Logan&user[lastname]=Smalley&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=logansmalley&user[email]=smalley@ted.com&user[role]=admin&user[phonenumber]=5555555555" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# curl -d "user[firstname]=Andy&user[lastname]=Cavatorta&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=andycavatorta&user[email]=fishermanswharff@icloud.com&user[role]=admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# curl -d "user[firstname]=Ayodamola&user[lastname]=Okunseinde&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=ayodamolaokunseinde&user[email]=fishermanswharff@me.com&user[role]=admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# curl -d "user[firstname]=joe&user[lastname]=user&user[password]=password&user[password_confirmation]=password&user[username]=joeuser&user[email]=joe@user.com&user[role]=venue_admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
