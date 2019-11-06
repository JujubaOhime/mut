class Contact {

  String _name;
  String _description;
  String _photo;

  String get description => _description;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  set description(String value) {
    _description = value;
  }

  String get photo => _photo;

  set photo(String value) {
    _photo = value;
  }

  Contact(this._name, this._description, this._photo);

}