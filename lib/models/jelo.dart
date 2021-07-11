class Jelo {
  String naziv;
  double cijena;
  String slika;
  String slikaThumb;
  int vrstaJelaId;
  Null jeloNaziv;
  String vrstaJela;
  int jeloId;
  String prosjecnaOcjena;

  Jelo(
      {this.naziv,
      this.cijena,
      this.slika,
      this.slikaThumb,
      this.vrstaJelaId,
      this.jeloNaziv,
      this.vrstaJela,
      this.jeloId,
      this.prosjecnaOcjena});

  Jelo.fromJson(Map<String, dynamic> json) {
    naziv = json['naziv'];
    cijena = json['cijena'];
    slika = json['slika'];
    slikaThumb = json['slikaThumb'];
    vrstaJelaId = json['vrstaJelaId'];
    jeloNaziv = json['jeloNaziv'];
    vrstaJela = json['vrstaJela'];
    jeloId = json['jeloId'];
    prosjecnaOcjena = json['prosjecnaOcjena'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['naziv'] = this.naziv;
    data['cijena'] = this.cijena;
    data['slika'] = this.slika;
    data['slikaThumb'] = this.slikaThumb;
    data['vrstaJelaId'] = this.vrstaJelaId;
    data['jeloNaziv'] = this.jeloNaziv;
    data['vrstaJela'] = this.vrstaJela;
    data['jeloId'] = this.jeloId;
    data['prosjecnaOcjena'] = this.prosjecnaOcjena;
    return data;
  }
}