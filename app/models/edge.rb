# == Schema Information
#
# Table name: edges
#
#  id         :integer          not null, primary key
#  source     :integer
#  target     :integer
#  cost       :float
#  map_id     :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_edges_on_map_id  (map_id)
#

class Edge < ActiveRecord::Base
  validates :source, :target, :cost, :map_id,
            presence: true

  belongs_to :map
end
