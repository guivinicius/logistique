class EnablingPgExtensions < ActiveRecord::Migration
  def up
    enable_extension('postgis')
    enable_extension('pgrouting')
  end

  def down
    disable_extension('pgrouting')
    disable_extension('postgis')
  end
end
