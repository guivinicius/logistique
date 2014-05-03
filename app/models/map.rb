# == Schema Information
#
# Table name: maps
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Map < ActiveRecord::Base

  validates :name,
    :presence => true,
    :uniqueness => true

  has_many :nodes,
    :dependent => :destroy

  has_many :edges,
    :dependent => :destroy

end
