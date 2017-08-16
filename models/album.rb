require_relative("../db/sql_runner")

class Album

  attr_accessor(:name, :genre, :artist_id)
  attr_reader(:id)

  def initialize(album_details)
    @id = album_details["id"].to_i if album_details["id"]
    @name = album_details["name"]
    @genre = album_details["genre"]
    @artist_id = album_details["artist_id"]
  end

  def save
    sql = "
      INSERT INTO albums (
        name,
        genre,
        artist_id
      )
      VALUES (
        $1, $2, $3
      )
      RETURNING id;
    "
    values = [@name, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update
    sql = "
      UPDATE albums SET (
        name,
        genre,
        artist_id
      ) = (
        $1, $2, $3
      )
      WHERE id = $4;
    "
    values = [@name, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM albums WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Album.delete_all
    sql = "DELETE FROM albums WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Album.all
    sql = "SELECT * FROM albums;"
    result = SqlRunner.run(sql)
    albums = result.map {|album| Album.new(album)}
    return albums
  end

  def artist
    sql = "
      SELECT * FROM artists
      WHERE id = $1
    "
    result = SqlRunner.run(sql, [@artist_id])
    artist = result.map {|artist_hash| Artist.new(artist_hash)}
    return artist
  end


end
