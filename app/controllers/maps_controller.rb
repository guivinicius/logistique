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
    @map = Map.find(params[:id])

    source = @map.nodes.find_by(:name => params[:source])
    target = @map.nodes.find_by(:name => params[:target])

    sql = <<-eos
      SELECT string_agg((SELECT name FROM nodes WHERE id = id1), ' ') as route,
             SUM(cost) as length
      FROM pgr_dijkstra(
             'SELECT id, source, target, cost
              FROM edges
              WHERE map_id = #{@map.id}',
           #{source.id}, #{target.id}, false, false);
    eos
    records = ActiveRecord::Base.connection.execute(sql)

    route = records.first["route"]
    cost  = records.first["length"].to_f * (params[:fuel_price].to_f / params[:vehicle_autonomy].to_f)

    render json: { route: route, cost: cost }
  end

end
