class Record < ActiveRecord::Base
  belongs_to :user
	belongs_to :ticket
	has_many :attaches, :dependent => :destroy
end
