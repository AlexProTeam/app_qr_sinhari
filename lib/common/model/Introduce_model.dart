class Introduce {
  int? status;
  String? message;
  Policy? policy;

  Introduce({this.status, this.message, this.policy});

  Introduce.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    policy =
    json['policy'] != null ? Policy.fromJson(json['policy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (policy != null) {
      data['policy'] = policy!.toJson();
    }
    return data;
  }
}

class Policy {
  int? id;
  String? name;
  String? content;
  String? createdAt;
  String? updatedAt;

  Policy({this.id, this.name, this.content, this.createdAt, this.updatedAt});

  Policy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
