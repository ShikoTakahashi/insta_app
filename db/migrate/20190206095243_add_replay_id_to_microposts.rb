class AddReplayIdToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :replay_id, :intger
  end
end
