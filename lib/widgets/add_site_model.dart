class Site {
  final int id;
  final int userid;
  final String url;
  final String siteName;
  final String sector;
  final String socialMedia;
  final String username;
  final String password;
  final String notes;
  Site(
      {required this.id,
      required this.userid,
      required this.url,
      required this.siteName,
      required this.sector,
      required this.socialMedia,
      required this.username,
      required this.password,
      required this.notes});

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      id: json["id"],
      userid: json["userid"],
      url: json["url"],
      siteName: json["siteName"],
      sector: json["sector"],
      socialMedia: json['socialMedia'],
      username: json['username'],
      password: json['password'],
      notes: json['notes'],
    );
  }
}
