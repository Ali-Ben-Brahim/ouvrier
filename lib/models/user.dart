
class User {
	int? id;
	String? name;
	String? email;
  String? token ;
	User({this.id, this.name, this.email , this.token});

	User.fromJson(Map<dynamic, dynamic> json) {
		id = json['user']['id'];
		name = json['user']['name'];
		email = json['user']['email'];
    token = json['token'];

	}

	// Map<String, dynamic> toJson() {
	// 	final Map<String, dynamic> data = Map<String, dynamic>();
	// 	data['id'] = this.id;
	// 	data['name'] = this.name;
	// 	data['email'] = this.email;
	// 	return data;
	// }
}