class AddDefaultValueToStatus < ActiveRecord::Migration[5.2]
def up
  change_column :products, :status, :string, default: "approved"
end

def down
  change_column :products, :status, :string, default: nil
end
end
