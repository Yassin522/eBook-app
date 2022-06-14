class Category {
  int? Id;
  //title
  String? Title;
  String? zh_Title;
  String? es_Title;
  String? hi_Title;
  String? ar_Title;
  String? ru_Title;
  String? ja_Title;
  String? de_Title;
  //Author
  String? Author;
  String? zh_Author;
  String? es_Author;
  String? hi_Author;
  String? ar_Author;
  String? ru_Author;
  String? ja_Author;
  String? de_Author;

  int? Chapter;

  Category({
    this.Id,
    //title
    this.Title,
    this.zh_Title,
    this.es_Title,
    this.hi_Title,
    this.ar_Title,
    this.ru_Title,
    this.ja_Title,
    this.de_Title,
    // Author
    this.Author,
    this.zh_Author,
    this.es_Author,
    this.hi_Author,
    this.ar_Author,
    this.ru_Author,
    this.ja_Author,
    this.de_Author,
    this.Chapter,
  });
  factory Category.fromJson(Map<String, dynamic> json) => Category(
        Id: json["Id"],
        //title
        Title: json["Title"],
        zh_Title: json["zh_Title"],
        es_Title: json["es_Title"],
        hi_Title: json["hi_Title"],
        ar_Title: json["ar_Title"],
        ru_Title: json["ru_Title"],
        ja_Title: json["ja_Title"],
        de_Title: json["de_Title"],
        Author: json["Author_name"],
        Chapter: json["Total_Chapter"],

        zh_Author: json["zh_Author_name"],
        es_Author: json["es_Author_name"],
        hi_Author: json["hi_Author_name"],
        ar_Author: json["ar_Author_name"],
        ru_Author: json["ru_Author_name"],
        ja_Author: json["ja_Author_name"],
        de_Author: json["de_Author_name"],

        //Other fields items here
      );
}
