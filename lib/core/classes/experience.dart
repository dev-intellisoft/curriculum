class Experience {
  int? id;
  int? tempId;
  String? company;
  String? title;
  String? start;
  String? end;
  List<String>? keywords;
  String? description;
  String? location;

  Experience({
    this.id,
    this.tempId,
    this.company,
    this.title,
    this.start,
    this.end,
    this.keywords,
    this.description,
    this.location
  });

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    title = json['title'];
    start = json['start'];
    end = json['end'];
    keywords = json['keywords'].cast<String>();
    description = json['description'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['company'] = company;
    data['title'] = title;
    data['start'] = start;
    data['end'] = end;
    data['keywords'] = keywords;
    data['description'] = description;
    data['location'] = location;
    return data;
  }
}
