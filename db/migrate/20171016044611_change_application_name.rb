class ChangeApplicationName < ActiveRecord::Migration
  def change
    rename_table :applications, :registered_applications
  end
end
