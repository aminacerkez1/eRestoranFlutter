class Klijent {
  int klijentId;
  String ime;
  String prezime;
  String username;
  String brojTelefona;
  String adresa;

  Klijent(
      {this.klijentId,
      this.ime,
      this.prezime,
      this.username,
      this.brojTelefona,
      this.adresa});

  Klijent.fromJson(Map<String, dynamic> json) {
    klijentId = json['klijentId'];
    ime = json['ime'];
    prezime = json['prezime'];
    username = json['username'];
    brojTelefona = json['brojTelefona'];
    adresa = json['adresa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['klijentId'] = this.klijentId;
    data['ime'] = this.ime;
    data['prezime'] = this.prezime;
    data['username'] = this.username;
    data['brojTelefona'] = this.brojTelefona;
    data['adresa'] = this.adresa;
    return data;
  }
}
