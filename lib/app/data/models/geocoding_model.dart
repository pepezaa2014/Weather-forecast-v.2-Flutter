class Geocoding {
  String? name;
  LocalNames? localNames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  Geocoding.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = json['local_names'] != null
        ? LocalNames?.fromJson(json['local_names'])
        : null;
    lat = (json['lat'] as num).toDouble();
    lon = (json['lon'] as num).toDouble();
    country = json['country'];
    state = json['state'];
  }
}

List<Geocoding> geocodingListFromJson(List<dynamic> json) {
  return json.map((item) => Geocoding.fromJson(item)).toList();
}

class LocalNames {
  String? af;
  String? al;
  String? ar;
  String? az;
  String? ascii;
  String? bg;
  String? ca;
  String? cz;
  String? da;
  String? de;
  String? el;
  String? en;
  String? eu;
  String? fa;
  String? featureName;
  String? fi;
  String? fr;
  String? gl;
  String? he;
  String? hi;
  String? hr;
  String? hu;
  String? id;
  String? it;
  String? ja;
  String? kr;
  String? la;
  String? lt;
  String? mk;
  String? no;
  String? nl;
  String? pl;
  String? pt;
  String? ptBr;
  String? ro;
  String? ru;
  String? sv;
  String? sk;
  String? sl;
  String? sp;
  String? sr;
  String? th;
  String? tr;
  String? ua;
  String? vi;
  String? zhCn;
  String? zhTw;
  String? zu;

  LocalNames.fromJson(Map<String, dynamic> json) {
    af = json['af'];
    al = json['al'];
    ar = json['ar'];
    az = json['az'];
    ascii = json['ascii'];
    bg = json['bg'];
    ca = json['ca'];
    cz = json['cz'];
    da = json['da'];
    de = json['de'];
    el = json['el'];
    en = json['en'];
    eu = json['eu'];
    fa = json['fa'];
    featureName = json['featureName'];
    fi = json['fi'];
    fr = json['fr'];
    gl = json['gl'];
    he = json['he'];
    hi = json['hi'];
    hr = json['hr'];
    hu = json['hu'];
    id = json['id'];
    it = json['it'];
    ja = json['ja'];
    kr = json['kr'];
    la = json['la'];
    lt = json['lt'];
    mk = json['mk'];
    no = json['no'];
    nl = json['nl'];
    pl = json['pl'];
    pt = json['pt'];
    ptBr = json['ptBr'];
    ro = json['ro'];
    ru = json['ru'];
    sv = json['sv'];
    sk = json['sk'];
    sl = json['sl'];
    sp = json['sp'];
    sr = json['sr'];
    th = json['th'];
    tr = json['tr'];
    ua = json['ua'];
    vi = json['vi'];
    zhCn = json['zhCn'];
    zhTw = json['zhTw'];
    zu = json['zu'];
  }
}
