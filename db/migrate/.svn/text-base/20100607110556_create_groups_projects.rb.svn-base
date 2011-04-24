class CreateGroupsProjects < ActiveRecord::Migration
  def self.up
    create_table :groups_projects, :id => false, :force => true do |t|
      t.integer :group_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :groups_projects
  end
end
