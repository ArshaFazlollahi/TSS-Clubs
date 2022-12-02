class club {
  String _club_name;
  int _id;
  String _meeting_room;
  String _image_url;
  String _meeting_days;
  String _techear;
  String _description;
  String _category;
  bool _ismr;
  String _admincode;
  List _gallery_image = [];

  List get gallery_image => this._gallery_image;

  set gallery_image(List value) => this._gallery_image = value;

  String get admincode => this._admincode;

  set admincode(String value) => this._admincode = value;

  String get club_name => this._club_name;

  set club_name(String value) => this._club_name = value;

  get id => this._id;

  set id(value) => this._id = value;

  get meeting_room => this._meeting_room;

  set meeting_room(value) => this._meeting_room = value;

  get image_url => this._image_url;

  set image_url(value) => this._image_url = value;

  get meeting_days => this._meeting_days;

  set meeting_days(value) => this._meeting_days = value;

  get techear => this._techear;

  set techear(value) => this._techear = value;

  get description => this._description;

  set description(value) => this._description = value;

  get category => this._category;

  set category(value) => this._category = value;

  get ismr => this._ismr;

  set ismr(value) => this._ismr = value;

  club(
    this._club_name,
    this._id,
    this._meeting_room,
    this._image_url,
    this._meeting_days,
    this._techear,
    this._description,
    this._category,
    this._ismr,
    this._admincode,
    this._gallery_image,
  );
}
