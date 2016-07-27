require 'proj4'
require 'csv'
require 'memoizable'

module GCPS2TILES; class GCPs

  attr_reader :csv
  include Memoizable

  def transform_3857_to_4326(rw, hw, zw=0)
    proj_epsg_3857 = Proj4::Projection.new(['init=epsg:3857'])
    proj_epsg_4326 = Proj4::Projection.new(['init=epsg:4326'])
    proj_epsg_3857.transform(proj_epsg_4326, Proj4::Point.new(rw, hw, zw))
  end

  def initialize(csv_file_path)
    @csv = CSV.table(csv_file_path)
  end

  def mapx_min
    @csv.map{ |e| e[:mapx] }.min
  end

  def mapx_max
    @csv.map{ |e| e[:mapx] }.max
  end

  def mapy_min
    @csv.map{ |e| e[:mapy] }.min
  end

  def mapy_max
    @csv.map{ |e| e[:mapy] }.max
  end

  def lon_min
    transform_3857_to_4326(mapx_min, mapy_min).x * Proj4::RAD_TO_DEG
  end

  def lon_max
    transform_3857_to_4326(mapx_max, mapy_max).x * Proj4::RAD_TO_DEG
  end

  def lat_min
    transform_3857_to_4326(mapx_min, mapy_min).y * Proj4::RAD_TO_DEG
  end

  def lat_max
    transform_3857_to_4326(mapx_max, mapy_max).y * Proj4::RAD_TO_DEG
  end

  def lon_avg
    (lon_min + lon_max) / 2
  end

  def lat_avg
    (lat_min + lat_max) / 2
  end

  def to_h
    {
      mapx_min:mapx_min,
      mapx_max:mapx_max,
      mapy_min:mapy_min,
      mapy_max:mapy_max,
      lon_min:lon_min,
      lon_max:lon_max,
      lat_min:lat_min,
      lat_max:lat_max,
      lon_avg:lon_avg,
      lat_avg:lat_avg,
    }
  end

  memoize :mapx_min, :mapx_max, :mapy_min, :mapy_max
  memoize :lon_min, :lon_max, :lat_min, :lat_max, :lon_avg, :lat_avg
  memoize :to_h

end; end
