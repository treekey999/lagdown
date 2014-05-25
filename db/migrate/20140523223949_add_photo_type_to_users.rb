class AddPhotoTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo_provider, :string, default: "default"
  end
end
