class Bottle {
  String _title;
  String _fill_volume;
  String _water_type;
  String _water_degree;
  String _tag_hardware_id;
  String? _path_image;

  Bottle({
    required String title,
    required String fill_volume,
    required String water_type,
    required String tag_hardware_id,
    String? path_image,
    required String water_degree,
  })  : _title = title,
        _fill_volume = fill_volume,
        _water_type = water_type,
        _tag_hardware_id = tag_hardware_id,
        _path_image = path_image,
        _water_degree = water_degree;

  String get title => _title;
  set title(String value) {
    _title = value;
  }

  String get fill_volume => _fill_volume;
  set fill_volume(String value) {
    _fill_volume = value;
  }

  String get water_type => _water_type;
  set water_type(String value) {
    _water_type = value;
  }

  String get tag_hardware_id => _tag_hardware_id;
  set tag_hardware_id(String value) {
    _tag_hardware_id = value;
  }

  String? get path_image => _path_image;
  set path_image(String? value) {
    _path_image = value;
  }

  String get water_degree => _water_degree;
  set water_degree(String value) {
    _water_degree = value;
  }
}
