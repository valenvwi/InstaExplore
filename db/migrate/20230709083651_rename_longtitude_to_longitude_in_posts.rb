class RenameLongtitudeToLongitudeInPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :longtitude, :longitude
  end
end
