class Namirnica {
  int namirnicaId;
  String naziv;
  double cijenaPoKomadu;
  bool isPrilog;
  double stanjeNaSkladistu;

  Namirnica(
      {this.namirnicaId,
      this.naziv,
      this.cijenaPoKomadu,
      this.isPrilog,
      this.stanjeNaSkladistu});

  Namirnica.fromJson(Map<String, dynamic> json) {
    namirnicaId = json['namirnicaId'];
    naziv = json['naziv'];
    cijenaPoKomadu = json['cijenaPoKomadu'];
    isPrilog = json['isPrilog'];
    stanjeNaSkladistu = json['stanjeNaSkladistu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['namirnicaId'] = this.namirnicaId;
    data['naziv'] = this.naziv;
    data['cijenaPoKomadu'] = this.cijenaPoKomadu;
    data['isPrilog'] = this.isPrilog;
    data['stanjeNaSkladistu'] = this.stanjeNaSkladistu;
    return data;
  }
}