# == Schema Information
#
# Table name: maps
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_maps_on_name  (name) UNIQUE
#

class Map < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: true

  has_many :nodes, dependent: :destroy
  has_many :edges, dependent: :destroy
end
