class AddPostIdToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :post_id, :integer
  end
end
