# README

## HOW TOs

### How to build the project
```
bundle install
rails db:migrate RAILS_ENV=development
rails db:migrate RAILS_ENV=test
rails s
```

### You can explore the API based on Swagger, here is the URL:
```
http://localhost:3000/index.html
```

### How to run the tests
```
bundle exec rspec
```

### How to run a single test
```
bundle exec rspec path/to/spec.rb
```

### How to run migrations
```
rails db:migrate RAILS_ENV=development
rails db:migrate RAILS_ENV=test
```

### How to generate documentation after a change
```
bundle exec rake swagger:docs
```

## Abstract

You are creating an API for your new music streaming service

Create API endpoints that enable the following:

#### Albums
- creating and deleting albums
- changing album details (name, artist, album art)
- adding / removing songs

#### Artists (musicians/bands)
- creating and deleting artists
- changing artist details (name, bio, albums)

#### Songs
- creating and deleting songs
- changing song details (name, duration, genre, album, artist, etc)
- songs can be featured and featured songs have a here image and extra texts to describe or promote it

#### Playlists
- creating and deleting playlists
- changing playlist name
- adding / removing songs from playlist

The API should be written in Ruby: Rails and/or an API framework such as Grape

The information should be stored in a database of your choice

Document the API so a developer can understand how to use it

Explain the architectural and design decisions you make

Publish the code on GitHub & deploy the API so we can take a look at it

I would like you to use your creativity to make this application as practical and realistic as possible

Use your creativity!