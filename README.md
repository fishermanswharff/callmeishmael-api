# Call Me Ishmael API

:telephone_receiver: :closed_book: :orange_book: :notebook_with_decorative_cover: :notebook: :books: :mega: :zap: :speak_no_evil: :speech_balloon: :thought_balloon:

RESTful API to communicate with Call Me Ishmael phones, and provides the consumer-facing [web portal](https://github.com/fishermanswharff/callmeishmael-webapp) with data, which allows admins to manage their phones and Call Me Ishmael to administer accounts.

## Code Status

[![Build Status][ci-image]][ci-url]
[![Code Climate][cc-climate-image]][cc-climate-url]
[![Test Coverage][cc-coverage-image]][cc-coverage-url]


## Installation

- install dependencies:
  - [Postgres 9.3.5](https://github.com/PostgresApp/PostgresApp/releases/tag/9.3.6.0)
  - [Rails 4.2](https://github.com/rails/rails)
  - [Ruby 2.2.1 using RVM](https://rvm.io/) *I use rvm to manage ruby gems*
  - [Make sure you have Git installed.](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- `$ git checkout <ssh url>`
- `$ cd path/you/just/created`
- `$ bundle`
- `$ rake db:create db:migrate db:seed`
- `$ rails s -p 3333`
- `curl http://localhost:3333/venues/1/phones/1/files` should result in this json array:

```ruby

[
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/703-Extremely-Loud-and-Incredibly-Close-by-Jonathan-Safran-Foer-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/699-On-Looking-by-Alexandra-Horowitz-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/071-Pajama-Time-by-Sandra-Boynton-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/020-Merriam-Webster-Dictionary-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/028-The-Sneetches-by-Dr-Seuss-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/313-Pride-And-Prejudice-by-Jane-Austen-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/323-Anna-Karenina-by-Leo-Tolstoy-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/074-Fault-In-Our-stars-by-John-Green-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/451-Harry-Potter-by-J.K.-Rowling-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/564-The-Oldest-Living-Things-in-the-World-by-Rachel-Sussman-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/592-A-Short-History-of-Nearly-Everything-by-Bill-Bryson-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/064-Not-Even-Wrong-by-Paul-Collins-final.ogg",
  "https://s3-us-west-2.amazonaws.com/callmeishmael-files/whitenoise.ogg"
]

```

- `rspec` should yield all passing results.



## Routes

           Prefix Verb     URI Pattern                                        Controller#Action
      admin_users GET      /admin/users(.:format)                             admin/users#index
                  POST     /admin/users(.:format)                             admin/users#create
       admin_user GET      /admin/users/:id(.:format)                         admin/users#show
                  PATCH    /admin/users/:id(.:format)                         admin/users#update
                  PUT      /admin/users/:id(.:format)                         admin/users#update
                  DELETE   /admin/users/:id(.:format)                         admin/users#destroy
 venue_phone_ping GET|POST /venues/:venue_id/phones/:phone_id/ping(.:format)  phones#ping
venue_phone_files GET      /venues/:venue_id/phones/:phone_id/files(.:format) phones#files
  venue_phone_log POST     /venues/:venue_id/phones/:phone_id/log(.:format)   phones#log
     venue_phones GET      /venues/:venue_id/phones(.:format)                 phones#index
                  POST     /venues/:venue_id/phones(.:format)                 phones#create
      venue_phone GET      /venues/:venue_id/phones/:id(.:format)             phones#show
                  PATCH    /venues/:venue_id/phones/:id(.:format)             phones#update
                  PUT      /venues/:venue_id/phones/:id(.:format)             phones#update
                  DELETE   /venues/:venue_id/phones/:id(.:format)             phones#destroy
           venues GET      /venues(.:format)                                  venues#index
                  POST     /venues(.:format)                                  venues#create
            venue GET      /venues/:id(.:format)                              venues#show
                  PATCH    /venues/:id(.:format)                              venues#update
                  PUT      /venues/:id(.:format)                              venues#update
                  DELETE   /venues/:id(.:format)                              venues#destroy
          stories GET      /stories(.:format)                                 stories#index
                  POST     /stories(.:format)                                 stories#create
            story GET      /stories/:id(.:format)                             stories#show
                  PATCH    /stories/:id(.:format)                             stories#update
                  PUT      /stories/:id(.:format)                             stories#update
                  DELETE   /stories/:id(.:format)                             stories#destroy
           phones GET      /phones(.:format)                                  phones#index
          buttons POST     /buttons(.:format)                                 buttons#create
           button PATCH    /buttons/:id(.:format)                             buttons#update
                  PUT      /buttons/:id(.:format)                             buttons#update
            login POST     /login(.:format)                                   admin/users#login
           logout GET      /logout(.:format)                                  admin/users#logout
    resetpassword GET      /resetpassword(.:format)                           admin/users#resetpassword
  amazon_sign_key GET      /amazon/sign_key(.:format)                         amazon#sign_key
                  GET      /                                                  redirect(301, https://github.com/fishermanswharff/callmeishmael-api)

[ci-image]: https://magnum.travis-ci.com/fishermanswharff/callmeishmael-api.svg?token=ywtwaukB2udjyiFG1GbL&branch=master
[ci-url]: https://magnum.travis-ci.com/fishermanswharff/callmeishmael-api

[cc-climate-image]: https://codeclimate.com/repos/552b1979695680373f000a7d/badges/b6474b9a7d66964c7b98/gpa.svg
[cc-climate-url]: https://codeclimate.com/repos/552b1979695680373f000a7d/feed

[cc-coverage-image]: https://codeclimate.com/repos/552b1979695680373f000a7d/badges/b6474b9a7d66964c7b98/coverage.svg
[cc-coverage-url]: https://codeclimate.com/repos/552b1979695680373f000a7d/feed





