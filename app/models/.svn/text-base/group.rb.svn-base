class Group < ActiveRecord::Base
	has_and_belongs_to_many :projects
  has_and_belongs_to_many :users

	validates_length_of :name, :within => 3..15
	validates_uniqueness_of :name, :case_sensitive => false

end
