ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")
end

puts "\n\n"

#   USERS
# —————————————————
puts 'Creating users…'
users = [
  User.find_or_create_by!(firstname: 'Jason', lastname: 'Wharff', username: 'jasonwharff', role: 'admin', email: 'fishermanswharff@mac.com', phonenumber: 6173889520, password_digest: "$2a$10$g0nkXPBOkJWCaCquG49Z8O3wutYc/wWY1sEkHy8qDQqwBM5mLzcHC", token: "53193128a1ce4fcc8a57b4c95268c3ba"),
  User.find_or_create_by!(firstname: 'Logan',lastname: 'Smalley',username: 'logansmalley',role: 'admin',email: 'logan@test.com',phonenumber: 5554443333,password_digest: '$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq',token: '155a18a873bf4078b60bed27936f2f55'),
  User.find_or_create_by!(firstname: "Shawn",lastname: "Kotoske",username: "shawnkotoske",role: 'admin',email: "shawn@test.com",phonenumber: 5748509840,password_digest: "$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq",token: "5f780acadc3d4091b88749e8e289de49"),
  User.find_or_create_by!(firstname: "Chris",lastname: "Spence",username: "chrisspence",role: 'admin',email: "chris@test.com",phonenumber: 5085071285,password_digest: "$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq",token: "658ad3dfbbbc4230a2d989053d25830d"),
  User.find_or_create_by!(firstname: "Ayodamola",lastname: "Okunseinde",username: "ayodamolaokunseinde",role: 'admin',email: "ayo@test.com",phonenumber: 5554443333,password_digest: "$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq",token: "0ca0b535bb8245bc82d2726ced45c741"),
  User.find_or_create_by!(firstname: "Andy",lastname: "Cavatorta",username: "andycavatorta",role: 'admin',email: "andy@test.com",phonenumber: 5554443333,password_digest: "$2a$10$5GPaXAOo5BUa9RhMjnbxQ.P3lq6wSB3uYUFaH2gFa1qFLDDfKBwCq",token: "b0607162ae7f41baa78f2b7266520b09"),
  User.find_or_create_by!(firstname: "joe",lastname: "user",username: "joeuser",role: 'venue_admin',email: "joe@user.com",phonenumber: 5554443333,password_digest: "$2a$10$n7Buns1Q3ZoRvN.SKUGFy.TsjkmjQ/EqSdm2vmXG1jf51Wa1PgQCi",token: "462e4dce8ceb43d7a801e7210ca9073a"),
  User.find_or_create_by!(firstname: 'Estella',lastname: 'Wharff',username: 'estella',role: 'venue_admin',email: 'fishermanswharff@me.com',phonenumber: 6173889520,password_digest: '$2a$10$ukerRC64qS146G.bhY65A.iKh.tdG194qErA5.i1gAi46dneu2t4m',token: '25f41b2be80747ceb2fe2ab059163903')
]
puts "seeded #{users.length} users, total users: #{User.count}"
User.all.each { |u| p "#{u.firstname} #{u.lastname}" }
puts "\n\n"

#   VENUES
# —————————————————
puts 'Seeding venues…'
venues = [
  Venue.find_or_create_by!(name: 'The Strand'),
  Venue.find_or_create_by!(name: 'Reading Rainbow'),
  Venue.find_or_create_by!(name: 'Sesame Street'),
  Venue.find_or_create_by!(name: '21 Shepard St.'),
]

Venue.find_by!(name: 'The Strand').users << User.find_by!(email: 'fishermanswharff@mac.com')
Venue.find_by!(name: 'The Strand').users << User.find_by!(email: 'shawn@test.com')
Venue.find_by!(name: 'The Strand').users << User.find_by!(email: 'logan@test.com')
Venue.find_by!(name: 'The Strand').users << User.find_by!(email: 'chris@test.com')
Venue.find_by!(name: 'The Strand').users << User.find_by!(email: 'ayo@test.com')
Venue.find_by!(name: 'The Strand').users << User.find_by!(email: 'andy@test.com')
Venue.find_by!(name: 'The Strand').users << User.find_by!(email: 'joe@user.com')

Venue.find_by!(name: 'Reading Rainbow').users << User.find_by!(email: 'fishermanswharff@mac.com')
Venue.find_by!(name: 'Reading Rainbow').users << User.find_by!(email: 'joe@user.com')
Venue.find_by!(name: 'Sesame Street').users << User.find_by!(email: 'fishermanswharff@mac.com')
Venue.find_by!(name: '21 Shepard St.').users << User.find_by!(email: 'fishermanswharff@mac.com')
Venue.find_by!(name: '21 Shepard St.').users << User.find_by!(email: 'fishermanswharff@me.com')

puts "Seeded #{venues.length} venues, total venues: #{Venue.count}"
Venue.all.each { |v| p v.name + " has #{v.users.length} users" }
puts "\n\n"

#   PHONES
# —————————————————
puts 'Seeding Phones:'
phones = [
  Phone.find_or_create_by!(status: 'active', venue: Venue.find_by(name: 'The Strand')),
  Phone.find_or_create_by!(status: 'active', venue: Venue.find_by(name: 'Reading Rainbow')),
  Phone.find_or_create_by!(status: 'active', venue: Venue.find_by(name: 'Sesame Street')),
  Phone.find_or_create_by!(status: 'active', venue: Venue.find_by(name: '21 Shepard St.')),
]
puts "Seeded #{phones.length} phones, total phones: #{Phone.count}"
phones.each { |p| p "#{p.unique_identifier} at venue #{p.venue.name}" }
puts "\n\n"

#   STORIES
# —————————————————
puts 'Seeding stories…'
stories = [
  Story.find_or_create_by!(title: 'On Looking', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/699-On-Looking-by-Alexandra-Horowitz-final.ogg', story_type: 'ishmaels',author_first: 'Alexandra', author_last: 'Horowitz', call_length: '0:00', common_title: 'On Looking Review', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Extremely Loud and Incredibly Close', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/703-Extremely-Loud-and-Incredibly-Close-by-Jonathan-Safran-Foer-final.ogg', story_type: 'ishmaels', author_last: 'Safran Foer', author_first: 'Jonathan', call_length: '0:00', common_title: '703-Extremely-Loud-and-Incredibly-Close-by-Jonathan-Safran-Foer-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Pajama Time', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/071-Pajama-Time-by-Sandra-Boynton-final.ogg', story_type: 'ishmaels', author_last: 'Boynton', author_first: 'Sandra', call_length: '0:00', common_title: '071-Pajama-Time-by-Sandra-Boynton-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Merriam Webster Dictionary', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/020-Merriam-Webster-Dictionary-final.ogg', story_type: 'ishmaels', author_last: 'Webster', author_first: 'Merriam', call_length: '0:00', common_title: '020-Merriam-Webster-Dictionary-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'The Sneetches', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/028-The-Sneetches-by-Dr-Seuss-final.ogg', story_type: 'ishmaels', author_last: 'Seuss', author_first: 'Dr.', call_length: '0:00', common_title: '028-The-Sneetches-by-Dr-Seuss-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Pride And Prejudice', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/313-Pride-And-Prejudice-by-Jane-Austen-final.ogg', story_type: 'ishmaels', author_last: 'Austen', author_first: 'Jane', call_length: '0:00', common_title: '313-Pride-And-Prejudice-by-Jane-Austen-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Anna Karenina', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/323-Anna-Karenina-by-Leo-Tolstoy-final.ogg', story_type: 'ishmaels', author_last: 'Tolstoy', author_first: 'Leo', call_length: '0:00', common_title: '323-Anna-Karenina-by-Leo-Tolstoy-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'The Fault In Our Stars', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/074-Fault-In-Our-stars-by-John-Green-final.ogg', story_type: 'ishmaels', author_last: 'Green', author_first: 'John', call_length: '0:00', common_title: '074-Fault-In-Our-stars-by-John-Green-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Harry Potter', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/451-Harry-Potter-by-J.K.-Rowling-final.ogg', story_type: 'ishmaels', author_last: 'Rowling', author_first: 'JK', call_length: '0:00', common_title: '451-Harry-Potter-by-J.K.-Rowling-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'The Oldest Living Things in the World', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/564-The-Oldest-Living-Things-in-the-World-by-Rachel-Sussman-final.ogg', story_type: 'ishmaels', author_last: 'Sussman', author_first: 'Rachel', call_length: '0:00', common_title: '564-The-Oldest-Living-Things-in-the-World-by-Rachel-Sussman-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'A Short History of Nearly Everything', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/592-A-Short-History-of-Nearly-Everything-by-Bill-Bryson-final.ogg', story_type: 'ishmaels', author_last: 'Bryson', author_first: 'Bill', call_length: '0:00', common_title: '592-A-Short-History-of-Nearly-Everything-by-Bill-Bryson-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Not Even Wrong', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/064-Not-Even-Wrong-by-Paul-Collins-final.ogg', story_type: 'ishmaels', author_last: 'Collins', author_first: 'Paul', call_length: '0:00', common_title: '064-Not-Even-Wrong-by-Paul-Collins-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Tiny Beautiful Things', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/777-Tiny-Beautiful-Things-by-Cheryl-Strayed-final.ogg', story_type: 'ishmaels', author_last: 'Strayed', author_first: 'Cheryl', call_length: '0:00', common_title: '777-Tiny-Beautiful-Things-by-Cheryl-Strayed-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'Lets Pretend This Never Happened', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/800-Lets-Pretend-This-Never-Happened-by-Jenny-Lawson-final.ogg', story_type: 'ishmaels', author_last: 'Lawson', author_first: 'Jenny', call_length: '0:00', common_title: '800-Lets-Pretend-This-Never-Happened-by-Jenny-Lawson-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'To Kill a Mockingbird', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/888-To-Kill-a-Mockingbird-by-Harper-Lee-final.ogg', story_type: 'ishmaels', author_last: 'Lee', author_first: 'Harper', call_length: '0:00', common_title: '888-To-Kill-a-Mockingbird-by-Harper-Lee-final', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
  Story.find_or_create_by!(title: 'White Noise', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/whitenoise.ogg', story_type: 'postroll', author_last: 'White', author_first: 'Noise', call_length: '0:00', common_title: 'White noise for testing purposes', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0),
]

puts "Seeded #{stories.length} stories, total stories: #{Story.count}"
stories.each { |s| p "#{s.title} by #{s.author_last}, story_type: #{s.story_type}" }
puts "\n\n"

puts 'Seeding venue stories for 21 Shepard St.'
Venue.find_by(name: '21 Shepard St.').stories << Story.create!([
  {title: 'Coming Home', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/01_Coming_Home.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Coming Home by Leon Bridges', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'Better Man', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/02_Better_Man.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Better Man by Leon Bridges', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'Brown Skin Girl', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/03_Brown_Skin_Girl.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Brown Skin Girl by Leon Bridges', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'Smooth Sailin', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/04_Smooth_Sailin_39_.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Smooth Sailing', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'Shine', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/05_Shine.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Shine', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'Lisa Sawyer', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/06_Lisa_Sawyer.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Lisa Sawyer', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'Flowers', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/07_Flowers.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Flowers', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'Pull Away', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/08_Pull_Away.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Pull Away', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'Twistin and Groovin', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/09_Twistin_39_and_Groovin_39_.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'Twistin & Groovin', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
  {title: 'River', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/10_River.ogg', story_type: 'venue', author_last: 'Bridges', author_first: 'Leon', call_length: '0:00', common_title: 'River', call_date: Date.today, transcript_url: 'http://www.google.com', call_uuid: 0 },
])
puts '21 Shepard St. has: '
Venue.find_by(name: '21 Shepard St.').stories.each { |s| p "#{s.title} by #{s.author_last}, url: #{s.url}, story_type: #{s.story_type}" }
puts "\n\n"

#   BUTTONS
# —————————————————
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
  { assignment: 'PR', story: Story.find_by_title('White Noise'), phone: phones[0] },
  { assignment: '*', story: Story.find_by_title('On Looking'), phone: phones[3] },
  { assignment: '#', story: Story.find_by_title('Extremely Loud and Incredibly Close'), phone: phones[3] },
  { assignment: '0', story: Story.find_by_title('Pajama Time'), phone: phones[3] },
  { assignment: '1', story: Story.find_by_title('Merriam Webster Dictionary'), phone: phones[3] },
  { assignment: '2', story: Story.find_by_title('The Sneetches'), phone: phones[3] },
  { assignment: '3', story: Story.find_by_title('Pride And Prejudice'), phone: phones[3] },
  { assignment: '4', story: Story.find_by_title('Anna Karenina'), phone: phones[3] },
  { assignment: '5', story: Story.find_by_title('The Fault In Our Stars'), phone: phones[3] },
  { assignment: '6', story: Story.find_by_title('Harry Potter'), phone: phones[3] },
  { assignment: '7', story: Story.find_by_title('The Oldest Living Things in the World'), phone: phones[3] },
  { assignment: '8', story: Story.find_by_title('A Short History of Nearly Everything'), phone: phones[3] },
  { assignment: '9', story: Story.find_by_title('Not Even Wrong'), phone: phones[3] },
  { assignment: 'PR', story: Story.find_by_title('White Noise'), phone: phones[3] }
])
puts "Seeded #{buttons.length} buttons as a join table:"
buttons.each { |b| p "#{b.assignment} button is assigned #{b.story.title} on phone #{b.phone.unique_identifier} at venue #{b.phone.venue.name}" }
puts "\n\n"

puts 'Done seeding the database. Farewell.'

# # curl -d "user[firstname]=Jason&user[lastname]=Wharff&user[password]=Rolla@1878&user[password_confirmation]=Rolla@1878&user[username]=jasonwharff&user[email]=fishermanswharff@mac.com&user[role]=admin&user[phonenumber]=6173889520" -X POST localhost:3000/admin/users
# # curl -d "user[firstname]=Shawn&user[lastname]=Kotoske&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=shawnkotoske&user[email]=jasonwharff@gmail.com&user[role]=admin&user[phonenumber]=5748509840" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# # curl -d "user[firstname]=Chris&user[lastname]=Spence&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=chrisspence&user[email]=jason@thinqmail.com&user[role]=admin&user[phonenumber]=5085071285" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# # curl -d "user[firstname]=Logan&user[lastname]=Smalley&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=logansmalley&user[email]=smalley@ted.com&user[role]=admin&user[phonenumber]=5555555555" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# # curl -d "user[firstname]=Andy&user[lastname]=Cavatorta&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=andycavatorta&user[email]=fishermanswharff@icloud.com&user[role]=admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# # curl -d "user[firstname]=Ayodamola&user[lastname]=Okunseinde&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=ayodamolaokunseinde&user[email]=fishermanswharff@me.com&user[role]=admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# # curl -d "user[firstname]=joe&user[lastname]=user&user[password]=password&user[password_confirmation]=password&user[username]=joeuser&user[email]=joe@user.com&user[role]=venue_admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# # curl -d "user[firstname]=Estella&user[lastname]=Wharff&user[password]=password&user[password_confirmation]=password&user[username]=estella&user[email]=fishermanswharff@me.com&user[role]=venue_admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users



