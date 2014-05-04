class MapsController < ApplicationController
  def create
    map = Map.new(name: params[:map][:name])
    if map.save

      if params[:map][:network]
        TopologyService.new(map, params[:map][:network]).create!
        render json: map
      else
        render json: "network can't be empty"
      end

    else
      render json: map.errors
    end
  end

  def best_route
    map   = Map.find_by(id: params[:id])
    route = Route.new(map, params[:source], params[:target])

    if route.calculate
      cost  = DeliveryCostService.new(route.length, params[:vehicle_autonomy], params[:fuel_price]).cost
      render json: { route: route.path, cost: cost }
    else
      render json: route.errors
    end
  end
end
