import 'package:cloud_firestore/cloud_firestore.dart';

class Clothes{
  String _size, _description, _photo, _title, _type, _state, _uid;
  Timestamp _time;

  Clothes(this._size,this._description,this._photo,this._title,this._type, this._state, this._uid, this._time);

   Clothes.map(dynamic obj){
    this._size = obj['size'];
    this._description = obj['description'];
    this._photo = obj['photo'];
    this._title = obj['title'];
    this._type = obj['type'];
    this._state = obj['state'];
    this._type = obj['type'];
    this._uid = obj['uid'];
    this._time = obj['time'];
  }

  String get size=> _size;
  String get title => _title;
  String get type => _type;
  String get description => _description;
  String get photo => _photo;

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();
    map['size']=_size;
    map['title'] = _title;
    map['type'] = _type;
    map['description'] = _description;
    map['photo'] = _photo;
    map['time'] = _time;
    map['uid'] = _uid;
    map['state'] = _state;
    return map;
  }

  Clothes.fromMap(Map<String,dynamic> map){
    this._size= map['size'];
    this._title = map['title'];
    this._type = map['type'];
    this._description = map['description'];
    this._photo = map['photo'];
    this._time = map['time'];
    this._uid = map['uid'];
    this._state = map['state'];
  }

}