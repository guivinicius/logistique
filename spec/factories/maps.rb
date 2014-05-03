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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :map do
    name "Default"
  end
end
