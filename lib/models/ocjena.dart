class Ocjena {
  int ocjenaId;
  int klijentId;
  int ocjena1;
  int jeloId;

  Ocjena({this.ocjenaId, this.klijentId, this.ocjena1, this.jeloId});

  Ocjena.fromJson(Map<String, dynamic> json) {
    ocjenaId = json['ocjenaId'];
    klijentId = json['klijentId'];
    ocjena1 = json['ocjena1'];
    jeloId = json['jeloId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ocjenaId'] = this.ocjenaId;
    data['klijentId'] = this.klijentId;
    data['ocjena1'] = this.ocjena1;
    data['jeloId'] = this.jeloId;
    return data;
  }
}