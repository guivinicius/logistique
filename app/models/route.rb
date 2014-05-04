class Route
  include ActiveModel::Model

  attr_reader :path, :length

  attr_accessor :map, :source_name, :target_name, :source, :target

  validates :map, :source, :target,
            presence: true

  def initialize(map, source_name, target_name)
    @map    = map
    @source = find_node(source_name)
    @target = find_node(target_name)
  end

  def calculate
    if valid?
      @result = ActiveRecord::Base.connection.execute(pgr_dijkstra)

      @path   = @result.first["route"]
      @length = @result.first["length"]
    end
  end

  private

  def find_node(name)
    @map.nodes.find_by(name: name) if @map
  end

  def pgr_dijkstra
    <<-eos
      SELECT string_agg((SELECT name FROM nodes WHERE id = id1), ' ') as route,
             SUM(cost) as length
      FROM pgr_dijkstra(
             'SELECT id, source, target, cost
              FROM edges
              WHERE map_id = #{map.id}',
           #{source.id}, #{target.id}, false, false);
    eos
  end
end
