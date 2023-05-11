class Geocoding {
  String? name;
  LocalNames? localNames;
  double? lat;
  double? lon;
  String? country;

  Geocoding({this.name, this.localNames, this.lat, this.lon, this.country});

  Geocoding.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = json['local_names'] != null
        ? LocalNames?.fromJson(json['local_names'])
        : null;
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
  }
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

  LocalNames(
    this.af,
    this.al,
    this.ar,
    this.az,
    this.ascii,
    this.bg,
    this.ca,
    this.cz,
    this.da,
    this.de,
    this.el,
    this.en,
    this.eu,
    this.fa,
    this.featureName,
    this.fi,
    this.fr,
    this.gl,
    this.he,
    this.hi,
    this.hr,
    this.hu,
    this.id,
    this.it,
    this.ja,
    this.kr,
    this.la,
    this.lt,
    this.mk,
    this.no,
    this.nl,
    this.pl,
    this.pt,
    this.ptBr,
    this.ro,
    this.ru,
    this.sv,
    this.sk,
    this.sl,
    this.sp,
    this.sr,
    this.th,
    this.tr,
    this.ua,
    this.vi,
    this.zhCn,
    this.zhTw,
    this.zu,
  );

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
