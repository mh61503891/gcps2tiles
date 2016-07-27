require 'gcps2tiles/version'
require 'gcps2tiles/gcps'
require 'systemu'
require 'colorize'
require 'open3'

module GCPS2TILES

  def self.create_vrt_file(options)
    gcps = GCPs.new(options['gcps_file_path']).csv.map { |row|
      [row[:pixelx].to_f, -row[:pixely].to_f, row[:mapx].to_f, row[:mapy].to_f].join(' ')
    }.map { |gcp|
      "-gcp #{gcp}"
    }.join(' ')
    gdal_translate_path = options['gdal_translate_path']
    image_file_path = options['image_file_path']
    vrt_file_path = Tempfile.open(File.basename(image_file_path, File.extname(image_file_path)) + '.vrt'){ |f| f.to_path }
    program = "#{gdal_translate_path} -of VRT #{gcps} #{image_file_path} #{vrt_file_path}"
    puts '$ '+ program.colorize(:blue)
    status, = systemu(program)
    return vrt_file_path if status.success?
  end

  def self.create_tile_files(options)
    python_path = options['python_path']
    gdal2tiles_path = options['gdal2tiles_path']
    output_dir_path = options['output_dir_path']
    vrt_file_path = create_vrt_file(options)
    program = "#{python_path} #{gdal2tiles_path} --s_srs epsg:3857 #{vrt_file_path} #{output_dir_path}"
    puts '$ '+ program.colorize(:blue)
    x = Open3.popen3(program) do |i, o, e, w|
      o.each_char{ |char| print char }
      e.each_char{ |char| print char }
      p w
    end
    p x.value
  end

  def self.execute(options)
    p options
    # %w(gdal_translate gdalwarp gdal2tiles python cs2cs).map{ |program|
    #   options["#{program}_path"]
    # }.each{ |program|
    #   which(program)
    # }

    create_tile_files(options)
  end

end



def which(program)
  status, stdout, stderr = systemu("which #{program}")
  if status.success?
    STDERR.puts "which #{program}".colorize(:blue)
    path = stdout.lines.first
    STDERR.puts "  #{path}" if path
  else
  end
end
