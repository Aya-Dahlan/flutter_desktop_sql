class AccountsJson {
  int? accId;
  String? accHolder;
  String? accName;
  int? accStatus;
  String? createdAt;

  AccountsJson(
      {this.accId,
      this.accHolder,
      this.accName,
      this.accStatus,
      this.createdAt});

  AccountsJson.fromJson(Map<String, dynamic> json) {
    accId = json['accId'];
    accHolder = json['accHolder'];
    accName = json['accName'];
    accStatus = json['accStatus'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accId'] = this.accId;
    data['accHolder'] = this.accHolder;
    data['accName'] = this.accName;
    data['accStatus'] = this.accStatus;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
