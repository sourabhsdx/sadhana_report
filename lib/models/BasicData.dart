class BasicData {
  String? uid;
  List<String>? deviceTokens;
  String? email;
  String? iYF;
  int? rounds;
  String? counsellor;
  String? sl;
  String? fullName;
  String? contactNo;
  String? address;

  BasicData(
      {this.uid,
        this.deviceTokens,
        this.email,
        this.iYF,
        this.rounds,
        this.counsellor,
        this.sl,
        this.fullName,
        this.contactNo,
        this.address});

  BasicData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    deviceTokens = json['deviceTokens']?.cast<String>();
    email = json['email'];
    iYF = json['IYF'];
    rounds = json['rounds'];
    counsellor = json['counsellor'];
    sl = json['sl'];
    fullName = json['fullName'];
    contactNo = json['contactNo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['deviceTokens'] = this.deviceTokens;
    data['email'] = this.email;
    data['IYF'] = this.iYF;
    data['rounds'] = this.rounds;
    data['counsellor'] = this.counsellor;
    data['sl'] = this.sl;
    data['fullName'] = this.fullName;
    data['contactNo'] = this.contactNo;
    data['address'] = this.address;
    return data;
  }
}
