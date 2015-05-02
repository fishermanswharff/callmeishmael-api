ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

User.destroy_all
Venue.destroy_all
Phone.destroy_all
Story.destroy_all
Button.destroy_all

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
    password_digest: '$2a$10$R4USxlyVTxfpt29btx9ZOeCv7LQ2Ht9vs4Dgaz9oq3Av1oJXIAwk6',
    token: '155a18a873bf4078b60bed27936f2f55'
  },
  {
    firstname: "Shawn",
    lastname: "Kotoske",
    username: "shawnkotoske",
    role: 'admin',
    email: "shawn@test.com",
    phonenumber: 5748509840,
    password_digest: "$2a$10$wHq8qGNohGxYV7ZS16hnvePqyUzycVK9jK4elVq4dJYU.j6QzlOfi",
    token: "5f780acadc3d4091b88749e8e289de49",
  },
  {
    firstname: "Chris",
    lastname: "Spence",
    username: "chrisspence",
    role: 'admin',
    email: "chris@test.com",
    phonenumber: 5085071285,
    password_digest: "$2a$10$LXCvp9murX/Q89oozsBA3eKwfXVb3R6E1eG.vonA0eCstqzriV1we",
    token: "658ad3dfbbbc4230a2d989053d25830d",
  },
  {
    firstname: "Ayodamola",
    lastname: "Okunseinde",
    username: "ayodamolaokunseinde",
    role: 'admin',
    email: "ayo@test.com",
    phonenumber: 5554443333,
    password_digest: "$2a$10$s1kpIuXhWRgAris6yLmb7.42OP7flqDUurK9mdx7nuy8Uygf2RJyK",
    token: "0ca0b535bb8245bc82d2726ced45c741",
  },
  {
    firstname: "Andy",
    lastname: "Cavatorta",
    username: "andycavatorta",
    role: 'admin',
    email: "andy@test.com",
    phonenumber: 5554443333,
    password_digest: "$2a$10$94LnIQeGX65mxMAMxGGehem0NqfzdBCf0Ay5.dSsDcMwwD8JdYSMq",
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
  { name: 'The Strand', user: User.find_by_email('fishermanswharff@mac.com') },
  { name: 'Reading Rainbow', user: User.find_by_email('fishermanswharff@mac.com') },
  { name: 'Sesame Street', user: User.find_by_email('fishermanswharff@mac.com') },
])
puts "Seeded #{venues.length} venues:"
venues.each { |v| p v.name }
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
  { title: 'The Infernal Devices', url: 'http://callmeishmael.com/story1.mp3', story_type: 'venue', author_last: 'Clare' },
  { title: 'Trigger', url: 'http://callmeishmael.com/story2.mp3', story_type: 'venue', author_last: 'Vaught' },
  { title: 'Battle Royale', url: 'http://callmeishmael.com/story3.mp3', story_type: 'venue', author_last: 'Takami' },
  { title: 'Looking For Alaska', url: 'http://callmeishmael.com/story4.mp3', story_type: 'venue', author_last: 'Green', author_first: 'John' },
  { title: 'The Fault In Our Stars', url: 'http://callmeishmael.com/story5.mp3', story_type: 'venue', author_last: 'Green', author_first: 'John' },
  { title: 'Bossy Pants', url: 'http://callmeishmael.com/story6.mp3', story_type: 'venue', author_last: 'Fey' },
  { title: 'A Dogs Purpose', url: 'http://callmeishmael.com/story7.mp3', story_type: 'venue', author_last: 'Cameron', author_first: 'Bruce' },
  { title: 'City of Bones (Mortal Instruments)', url: 'http://callmeishmael.com/story8.mp3', story_type: 'venue', author_last: 'Clare', author_first: '' },
  { title: 'Radical', url: 'http://callmeishmael.com/story9.mp3', story_type: 'venue', author_last: 'Platt', author_first: 'David' },
  { title: 'A Prayer for Owen Meany', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Irving', author_first: 'John' },
  { title: 'Speak', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Anderson', author_first: 'Laurie' },
  { title: 'If I Stay', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Forman', author_first: 'Gayle' },
  { title: 'The Perks of Being A Wallflower', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Chbosky', author_first: 'Stephen' },
  { title: 'The Great Gatsby', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Fitzgerald', author_first: 'F Scott' },
  { title: 'Eleanor & Park', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Rowell', author_first: 'Rainbow' },
  { title: 'The Spectacular Now', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Tim', author_first: 'Tharp' },
  { title: 'Feed', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Grant', author_first: 'Mira' },
  { title: 'The Alchemist', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Coelho', author_first: 'Paulo' },
  { title: 'Moby Dick', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Melville', author_first: 'Herman' },
  { title: 'Where’d You Go Bernadette', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Semple', author_first: 'Maria' },
  { title: 'Gone Girl', url: 'http://callmeishmael.com', story_type: 0, author_last: 'Flynn', author_first: 'Gillian' },
  { title: 'Crime And Punishment', url: 'http://callmeishmael.com', story_type: 0, author_last: 'Fyodor', author_first: 'Dostoyevsky' },
  { title: 'Peter Pan', url: 'http://callmeishmael.com', story_type: 0, author_last: 'Barrie', author_first: 'J. M.' },
])
puts "Seeded #{stories.length} stories: "
stories.each { |s| p "#{s.title} by #{s.author_last}, story_type: #{s.story_type}" }
puts "\n\n"

puts 'Seeing buttons…'
buttons = Button.create!([
  { assignment: '*', story: Story.find_by_title('Gone Girl'), phone: phones[0] },
  { assignment: '#', story: Story.find_by_title('Crime And Punishment'), phone: phones[0] },
  { assignment: '0', story: Story.find_by_title('Peter Pan'), phone: phones[0] },
  { assignment: '*', story: Story.find_by_title('Gone Girl'), phone: phones[1] },
  { assignment: '#', story: Story.find_by_title('Crime And Punishment'), phone: phones[1] },
  { assignment: '0', story: Story.find_by_title('Peter Pan'), phone: phones[1] },
  { assignment: '*', story: Story.find_by_title('Gone Girl'), phone: phones[2] },
  { assignment: '#', story: Story.find_by_title('Crime And Punishment'), phone: phones[2] },
  { assignment: '0', story: Story.find_by_title('Peter Pan'), phone: phones[2] },
  { assignment: '1', story: Story.find_by_title('The Infernal Devices'), phone: phones[0] },
  { assignment: '2', story: Story.find_by_title('Trigger'), phone: phones[0] },
  { assignment: '3', story: Story.find_by_title('Battle Royale'), phone: phones[0] },
  { assignment: '4', story: Story.find_by_title('Looking For Alaska'), phone: phones[0] },
  { assignment: '5', story: Story.find_by_title('The Fault In Our Stars'), phone: phones[0] },
  { assignment: '6', story: Story.find_by_title('Bossy Pants'), phone: phones[0] },
  { assignment: '7', story: Story.find_by_title('A Dogs Purpose'), phone: phones[0] },
  { assignment: '8', story: Story.find_by_title('City of Bones (Mortal Instruments)'), phone: phones[0] },
  { assignment: '9', story: Story.find_by_title('Radical'), phone: phones[0] }
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
