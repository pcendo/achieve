class AddColumnsToFeeds < ActiveRecord::Migration[5.1]
  def change
        add_column :feeds, :blog_id, :integer
  end
end
