class NarudzbaJela {
  int narudzbaJeloId;
  int narudzbaId;
  int jeloId;
  String jelo;
  int kolicinaJela;
  int prilogJelaId;
  double kolicinaPriloga;

  NarudzbaJela(
      {this.narudzbaJeloId,
      this.narudzbaId,
      this.jeloId,
      this.jelo,
      this.kolicinaJela,
      this.prilogJelaId,
      this.kolicinaPriloga});

  NarudzbaJela.fromJson(Map<String, dynamic> json) {
    narudzbaJeloId = json['narudzbaJeloId'];
    narudzbaId = json['narudzbaId'];
    jeloId = json['jeloId'];
    jelo = json['jelo'];
    kolicinaJela = json['kolicinaJela'];
    prilogJelaId = json['prilogJelaId'];
    kolicinaPriloga = json['kolicinaPriloga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['narudzbaJeloId'] = this.narudzbaJeloId;
    data['narudzbaId'] = this.narudzbaId;
    data['jeloId'] = this.jeloId;
    data['jelo'] = this.jelo;
    data['kolicinaJela'] = this.kolicinaJela;
    data['prilogJelaId'] = this.prilogJelaId;
    data['kolicinaPriloga'] = this.kolicinaPriloga;
    return data;
  }
}