# gcps2tiles

## Installation

```bash
$ gem install gcps2tiles
```

### Dependencies

1. `gdal_translate`
2. `gdal2tiles.py`

These command-line tools are executed by `systemu` or `open3` from `gcps2tiles`.

### Example for Instllation

* macOS
* macPorts
* RubyGems

```bash
# for gdal_translate
$ sudo port install gdal
$ which -a gdal_translate
/opt/local/bin/gdal_translate

# for gdal2tiles.py
$ sudo port install py27-gdal
$ which /opt/local/share/doc/py27-gdal/examples/scripts/gdal2tiles.py
/opt/local/share/doc/py27-gdal/examples/scripts/gdal2tiles.py

# for gcps2tiles
$ sudo port install proj
$ gem install proj4rb -- --with-opt-include=/opt/local/include --with-opt-lib=/opt/local/lib
$ gem install gcps2tiles
$ which gcps2tiles 
/Users/masayuki/.rbenv/shims/gcps2tiles

# run help of gcps2tiles
$ gcps2tiles help
Commands:
  gcps2tiles generate --gcps-file-path=GCPS_FILE_PATH --image-file-path=IMAGE_FILE_PATH  # generator TMS (Tile Map Service) tiles from a image and its GCPs (Ground Control Points) 
  gcps2tiles help [COMMAND]                                                              # Describe available commands or one specific command

Options:
  [--gdal-translate-path=GDAL_TRANSLATE_PATH]  
                                               # Default: gdal_translate
  [--python-path=PYTHON_PATH]                  
                                               # Default: python
  [--gdal2tiles-path=GDAL2TILES_PATH]          
                                               # Default: gdal2tiles.py
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
