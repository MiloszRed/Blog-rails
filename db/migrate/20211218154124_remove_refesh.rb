class RemoveRefesh < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :refreshToken
  end
end
