class Role {
  String? status;
  String? role;

  Role({this.status, this.role});

  Role.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['role'] = role;
    return data;
  }
}
