class MapsController < ApplicationController

  def create

    @map = Map.new(name: params[:map][:name])
    if @map.save
      
      # Adding everything into one single transaction
      ActiveRecord::Base.transaction do
        # Iterating through network
        params[:map][:network].each_line do |s|
          edge   = s.split(' ')

          # Creating nodes or finding it
          source = Node.find_or_create_by(name: edge[0], map: @map)
          target = Node.find_or_create_by(name: edge[1], map: @map)

          # Creating edge
          Edge.create(source: source.id, target: target.id, cost: edge[2], map: @map)
        end

      end
      render json: @map
    else
      render json: @map.errors
    end

  end

end
