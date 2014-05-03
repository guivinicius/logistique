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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node do
    name "A"
  end
end
