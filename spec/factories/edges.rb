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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :edge do
    source 1
    target 1
    cost 1.5
    map_id 1
  end
end
