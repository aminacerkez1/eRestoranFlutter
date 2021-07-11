class Narudzba {
  int narudzbaId;
  int klijentId;
  String datumNarudzbe;
  String vrijemeNarudzbe;
  double cijenaNarudzbe;
  Null status;
  bool prihvaceno;
  bool otkazano;
  bool izvrseno;
  bool naCekanju;

  Narudzba(
      {this.narudzbaId,
      this.klijentId,
      this.datumNarudzbe,
      this.vrijemeNarudzbe,
      this.cijenaNarudzbe,
      this.status,
      this.prihvaceno,
      this.otkazano,
      this.izvrseno,
      this.naCekanju});

  Narudzba.fromJson(Map<String, dynamic> json) {
    narudzbaId = json['narudzbaId'];
    klijentId = json['klijentId'];
    datumNarudzbe = json['datumNarudzbe'];
    vrijemeNarudzbe = json['vrijemeNarudzbe'];
    cijenaNarudzbe = json['cijenaNarudzbe'];
    status = json['status'];
    prihvaceno = json['prihvaceno'];
    otkazano = json['otkazano'];
    izvrseno = json['izvrseno'];
    naCekanju = json['naCekanju'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['narudzbaId'] = this.narudzbaId;
    data['klijentId'] = this.klijentId;
    data['datumNarudzbe'] = this.datumNarudzbe;
    data['vrijemeNarudzbe'] = this.vrijemeNarudzbe;
    data['cijenaNarudzbe'] = this.cijenaNarudzbe;
    data['status'] = this.status;
    data['prihvaceno'] = this.prihvaceno;
    data['otkazano'] = this.otkazano;
    data['izvrseno'] = this.izvrseno;
    data['naCekanju'] = this.naCekanju;
    return data;
  }
}