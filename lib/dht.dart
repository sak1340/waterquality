class DHT {
  final double temp;
  final double sal;
  final double ec;

  DHT({this.ec, this.sal, this.temp});

  factory DHT.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return DHT(
        ec: parser(json['ec']),
        sal: parser(json['sal']),
        temp: parser(json['temp']));
  }
}