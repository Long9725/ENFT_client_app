class User {
  final String nickname;
  final String location;
  final String address;
  final String sex;
  String profile;
  String jwtToken;

  User(
      {required this.nickname,
      required this.location,
      required this.address,
      required this.sex,
      this.jwtToken = "",
      this.profile = 'assets/photos/basic-profile.jpg'});

  User.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        location = json['location'],
        profile = json['profile'],
        address = json['address'],
        sex = json['sex'],
        jwtToken = json['jwtToken'];

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'location': location,
        'profile': profile,
        'address': address,
        'sex': sex
      };
}

final userList = [
  User(
      nickname: "strong_sun9",
      location: "경기도 수원시",
      address: '',
      sex: 'male',
      jwtToken: ''),
  User(
      nickname: "mmin_goo",
      location: "경기도 수원시",
      address: '',
      sex: 'male',
      jwtToken: ''),
  User(
      nickname: "예능퀸",
      location: "경기도 수원시",
      address: '',
      sex: 'male',
      jwtToken: ''),
  User(
      nickname: "sh_z_1119",
      location: "경기도 기산동",
      address: '',
      sex: 'male',
      jwtToken: ''),
];
