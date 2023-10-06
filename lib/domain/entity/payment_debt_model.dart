class PaymentDebt {
  String? imageQr;
  String? description;
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? contentTranfer;

  PaymentDebt(
      {this.imageQr,
      this.description,
      this.bankName,
      this.accountName,
      this.accountNumber,
      this.contentTranfer});

  PaymentDebt.fromJson(Map<String, dynamic> json) {
    imageQr = json['image_qr'];
    description = json['description'];
    bankName = json['bank_name'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    contentTranfer = json['content_tranfer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_qr'] = imageQr;
    data['description'] = description;
    data['bank_name'] = bankName;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['content_tranfer'] = contentTranfer;
    return data;
  }
}
