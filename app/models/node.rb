# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  map_id     :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_nodes_on_map_id           (map_id)
#  index_nodes_on_map_id_and_name  (map_id,name) UNIQUE
#

class Node < ActiveRecord::Base

  validates :name,
    :presence => true,
    :uniqueness => { :scope => :map_id }

  belongs_to :map

  has_many :edges

end
