class Rezervacija {
  int rezervacijaID;
  int klijentId;
  String datumRezervacije;
  String vrijemeRezervacije;
  int brojOsoba;
  Null status;
  bool otkazano;
  bool prihvaceno;
  bool naCekanju;
  bool izvrseno;

  Rezervacija(
      {this.rezervacijaID,
      this.klijentId,
      this.datumRezervacije,
      this.vrijemeRezervacije,
      this.brojOsoba,
      this.status,
      this.otkazano,
      this.prihvaceno,
      this.naCekanju,
      this.izvrseno});

  Rezervacija.fromJson(Map<String, dynamic> json) {
    rezervacijaID = json['rezervacijaID'];
    klijentId = json['klijentId'];
    datumRezervacije = json['datumRezervacije'];
    vrijemeRezervacije = json['vrijemeRezervacije'];
    brojOsoba = json['brojOsoba'];
    status = json['status'];
    otkazano = json['otkazano'];
    prihvaceno = json['prihvaceno'];
    naCekanju = json['naCekanju'];
    izvrseno = json['izvrseno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rezervacijaID'] = this.rezervacijaID;
    data['klijentId'] = this.klijentId;
    data['datumRezervacije'] = this.datumRezervacije;
    data['vrijemeRezervacije'] = this.vrijemeRezervacije;
    data['brojOsoba'] = this.brojOsoba;
    data['status'] = this.status;
    data['otkazano'] = this.otkazano;
    data['prihvaceno'] = this.prihvaceno;
    data['naCekanju'] = this.naCekanju;
    data['izvrseno'] = this.izvrseno;
    return data;
  }
}