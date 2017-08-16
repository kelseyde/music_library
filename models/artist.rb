require_relative("../db/sql_runner")

class Artist

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(artist_details)
    @id = artist_details["id"].to_i if artist_details["id"]
    @name = artist_details["name"]
  end

  def save
    sql = "
      INSERT INTO artists (name)
      VALUES ($1)
      RETURNING id;
    "
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update
    sql = "
      UPDATE artists SET
      (name) = ($1)
      WHERE id = $2;
    "
    values = [@name, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM artists WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Artist.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def Artist.all
    sql = "SELECT * FROM artists;"
    result = SqlRunner.run(sql)
    artists = result.map {|artist| Artist.new(artist)}
    return artists
  end

  def albums
    sql = "
      SELECT * FROM albums
      WHERE artist_id = $1
    "
    result = SqlRunner.run(sql, [@id])
    albums = result.map {|album_hash| Album.new(album_hash)}
    return albums
  end

end
