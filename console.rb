require("pry-byebug")
require_relative("models/artist")
require_relative("models/album")

Album.delete_all
Artist.delete_all


arcade_fire = Artist.new({"name" => "Arcade Fire"})
garfunkel = Artist.new({"name" => "Simon and Garfunkel"})
mountain = Artist.new({"name" => "The Mountain Goats"})
arcade_fire.save
garfunkel.save
mountain.save

suburbs = Album.new({
  "name" => "The Suburbs",
  "genre" => "Indie Rock",
  "artist_id" => arcade_fire.id
  })
suburbs.save

reflektor = Album.new({
  "name" => "The Suburbs",
  "genre" => "Indie Pop",
  "artist_id" => arcade_fire.id
  })
reflektor.save

bridge = Album.new({
  "name" => "Bridge Over Troubled Water",
  "genre" => "Folk",
  "artist_id" => garfunkel.id
  })
bridge.save

sunset = Album.new({
  "name" => "The Sunset Tree",
  "genre" => "Indie Rock",
  "artist_id" => mountain.id
  })
sunset.save

sunset.genre = "Folk Rock"
sunset.update

Album.all

binding.pry
nil
