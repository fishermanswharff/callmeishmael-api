ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

User.destroy_all

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
    confirmed: true,
  },
  {
    firstname: "Chris",
    lastname: "Spence",
    username: "chrisspence",
    role: 'admin',
    email: "chris@thinqmail.com",
    phonenumber: 5085071285,
    password_digest: "$2a$10$nOGhPDyCgixq3PxBZj3.4OT2AzSvDAGNfuoccUHV/W9rL6dWY4bcm",
    token: "6b6d0ee3fbb44ddd945411d9c4100c36",
    confirmed: true,
  },
  {
    firstname: "Shawn",
    lastname: "Kotoske",
    username: "shawnkotoske",
    role: 'admin',
    email: "shawn@thinqmail.com",
    phonenumber: 5748509840,
    password_digest: "$2a$10$CWNNDKCHM1QW75aUlAZT5uDF9DNW.XV6QD2TiIIzTDjhqqYZt8pbO",
    token: "dc4b66780bc749ca8572d1d2d175f60f",
    confirmed: true,
  },
  {
    firstname: "joe",
    lastname: "user",
    username: "joeuser",
    role: 'venue_admin',
    email: "fishermanswharff@mac.com",
    phonenumber: 6173889520,
    password_digest: "$2a$10$0WiosQNv78CTlgWugln50uopUvmwS.saaLbtWWjTgVy9qwnabVVTa",
    token: "b4f9f9e3db0d46a3a568b1cc48fc529a",
  },
])

# curl -d "user[firstname]=Jason&user[lastname]=Wharff&user[password]=Rolla@1878&user[password_confirmation]=Rolla@1878&user[username]=jasonwharff&user[email]=fishermanswharff@mac.com&user[role]=admin&user[phonenumber]=6173889520" -X POST localhost:3000/admin/users
# curl -d "user[firstname]=Shawn&user[lastname]=Kotoske&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=shawnkotoske&user[email]=shawn@thinqmail.com&user[role]=admin&user[phonenumber]=5748509840" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# curl -d "user[firstname]=Chris&user[lastname]=Spence&user[password]=tqi$2015&user[password_confirmation]=tqi$2015&user[username]=chrisspence&user[email]=chris@thinqmail.com&user[role]=admin&user[phonenumber]=5085071285" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# curl -d "user[firstname]=joe&user[lastname]=user&user[password]=secret&user[password_confirmation]=secret&user[username]=joeuser&user[email]=fishermanswharff@mac.com&user[role]=venue_admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users
# curl -d "user[firstname]=ricky&user[lastname]=bobby&user[password]=secret&user[password_confirmation]=secret&user[username]=rickybobby&user[email]=fishermanswharff@mac.com&user[role]=venue_admin&user[phonenumber]=6173889520" -H 'AUTHORIZATION: Token token=53193128a1ce4fcc8a57b4c95268c3ba' -X POST localhost:3000/admin/users

=begin
Jason
——————————————————————————————————————————
id: "298ed1c1-82c4-45fe-97a1-913a193e6acb",
firstname: "Jason",
lastname: "Wharff",
username: "jasonwharff",
role: 0,
email: "fishermanswharff@mac.com",
phonenumber: 6173889520,
password_digest: "$2a$10$g0nkXPBOkJWCaCquG49Z8O3wutYc/wWY1sEkHy8qDQqwBM5mLzcHC",
token: "53193128a1ce4fcc8a57b4c95268c3ba",
reset_password_token: nil,
reset_password_sent_at: nil,
remember_created_at: nil,
sign_in_count: 0,
current_sign_in_at: nil,
last_sign_in_at: nil,
active: true,
main_store_contact: false,
main_business_contact: false,
created_at: Sun, 12 Apr 2015 20:56:26 UTC +00:00,
updated_at: Sun, 12 Apr 2015 20:56:26 UTC +00:00

Chris
——————————————————————————————————————————
id: "d73b0150-7034-489a-84ba-7f8a7875808d",
firstname: "Chris",
lastname: "Spence",
username: "chrisspence",
role: 0,
email: "chris@thinqmail.com",
phonenumber: 5085071285,
password_digest: "$2a$10$nOGhPDyCgixq3PxBZj3.4OT2AzSvDAGNfuoccUHV/W9rL6dWY4bcm",
token: "6b6d0ee3fbb44ddd945411d9c4100c36",
reset_password_token: nil,
reset_password_sent_at: nil,
remember_created_at: nil,
sign_in_count: 0,
current_sign_in_at: nil,
last_sign_in_at: nil,
active: true,
main_store_contact: false,
main_business_contact: false,
created_at: Sun, 12 Apr 2015 21:08:18 UTC +00:00,
updated_at: Sun, 12 Apr 2015 21:08:18 UTC +00:00

Shawn
——————————————————————————————————————————
id: "0172e0e1-ed09-4052-9a59-bbd99b0de937",
firstname: "Shawn",
lastname: "Kotoske",
username: "shawnkotoske",
role: 0,
email: "shawn@thinqmail.com",
phonenumber: 5748509840,
password_digest: "$2a$10$CWNNDKCHM1QW75aUlAZT5uDF9DNW.XV6QD2TiIIzTDjhqqYZt8pbO",
token: "dc4b66780bc749ca8572d1d2d175f60f",
reset_password_token: nil,
reset_password_sent_at: nil,
remember_created_at: nil,
sign_in_count: 0,
current_sign_in_at: nil,
last_sign_in_at: nil,
active: true,
main_store_contact: false,
main_business_contact: false,
created_at: Sun, 12 Apr 2015 21:18:43 UTC +00:00,
updated_at: Sun, 12 Apr 2015 21:18:43 UTC +00:00

joe user
——————————————————————————————————————————
id: "b4e24afc-f7a0-4f71-999f-3b99d360f2ff",
firstname: "joe",
lastname: "user",
username: "joeuser",
role: 1,
email: "fishermanswharff@mac.com",
phonenumber: 6173889520,
password_digest: "$2a$10$0WiosQNv78CTlgWugln50uopUvmwS.saaLbtWWjTgVy9qwnabVVTa",
token: "b4f9f9e3db0d46a3a568b1cc48fc529a",
reset_password_token: nil,
reset_password_sent_at: nil,
remember_created_at: nil,
sign_in_count: 0,
current_sign_in_at: nil,
last_sign_in_at: nil,
active: true,
main_store_contact: false,
main_business_contact: false,
created_at: Sun, 12 Apr 2015 21:16:25 UTC +00:00,
updated_at: Sun, 12 Apr 2015 21:16:25 UTC +00:00
=end