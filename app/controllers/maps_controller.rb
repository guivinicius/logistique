class MapsController < ApplicationController

  def create
    @map = Map.new(name: params[:map][:name])
    if @map.save

      if params[:map][:network]
        TopologyService.new(@map, params[:map][:network]).create!
        render json: @map
      else
        render json: "network can't be empty"
      end

    else
      render json: @map.errors
    end

  end

  def best_route
    @map  = Map.find(params[:id])
    route = Route.new(@map, params[:source], params[:target])

    if route.calculate
      cost  = route.length.to_f * (params[:fuel_price].to_f / params[:vehicle_autonomy].to_f)
      render json: { route: route.path, cost: cost }
    else
      render json: route.errors
    end
  end

end
