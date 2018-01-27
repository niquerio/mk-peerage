class AddAncestryDepthToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :ancestry_depth, :integer, default: 0
  end
end
