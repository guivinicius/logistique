class DeliveryCostService
  include ActiveModel::Validations

  attr_accessor :length, :vehicle_autonomy, :fuel_price

  validates :length, :vehicle_autonomy, :fuel_price,
            presence: true,
            numericality: { greater_than: 0 }

  def initialize(length, vehicle_autonomy, fuel_price)
    @length           = length.to_f
    @vehicle_autonomy = vehicle_autonomy.to_f
    @fuel_price       = fuel_price.to_f
  end

  def cost
    valid? ? @length * (@fuel_price / @vehicle_autonomy) : errors
  end

end
