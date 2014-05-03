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

end
