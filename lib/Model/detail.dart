class detail {
  int? Id;
  int? Category_Id;
  //Chapter
  String? Chapter;
  String? zh_Chapter;
  String? es_Chapter;
  String? hi_Chapter;
  String? ar_Chapter;
  String? ru_Chapter;
  String? ja_Chapter;
  String? de_Chapter;
  //Description
  String? Description;
  String? zh_Description;
  String? es_Description;
  String? hi_Description;
  String? ar_Description;
  String? ru_Description;
  String? ja_Description;
  String? de_Description;
  //Short_Description
  String? Short_Description;
  String? zh_Short_Description;
  String? es_Short_Description;
  String? hi_Short_Description;
  String? ar_Short_Description;
  String? ru_Short_Description;
  String? ja_Short_Description;
  String? de_Short_Description;
  //Chapter_Count
  int? Chapter_Count;

  //For BookMark
  //Author_name
  String? en_Author_name;
  String? zh_Author_name;
  String? es_Author_name;
  String? hi_Author_name;
  String? ar_Author_name;
  String? ru_Author_name;
  String? ja_Author_name;
  String? de_Author_name;

  //title
  String? Title;
  String? zh_Title;
  String? es_Title;
  String? hi_Title;
  String? ar_Title;
  String? ru_Title;
  String? ja_Title;
  String? de_Title;
  //Chapter_Total
  int? Chapter_Total;

  detail({
    this.Id,
    this.Category_Id,
    //Chapter
    this.Chapter,
    this.zh_Chapter,
    this.es_Chapter,
    this.hi_Chapter,
    this.ar_Chapter,
    this.ru_Chapter,
    this.ja_Chapter,
    this.de_Chapter,
    //Description
    this.Description,
    this.zh_Description,
    this.es_Description,
    this.hi_Description,
    this.ar_Description,
    this.ru_Description,
    this.ja_Description,
    this.de_Description,
    //Short_Description
    this.Short_Description,
    this.zh_Short_Description,
    this.es_Short_Description,
    this.hi_Short_Description,
    this.ru_Short_Description,
    this.ar_Short_Description,
    this.ja_Short_Description,
    this.de_Short_Description,
    //Chapter_Count
    this.Chapter_Count,
    //Author_name
    this.ar_Author_name,
    this.de_Author_name,
    this.en_Author_name,
    this.es_Author_name,
    this.hi_Author_name,
    this.ja_Author_name,
    this.ru_Author_name,
    this.zh_Author_name,
    //title
    this.Title,
    this.zh_Title,
    this.es_Title,
    this.hi_Title,
    this.ar_Title,
    this.ru_Title,
    this.ja_Title,
    this.de_Title,
    //Chapter_Total
    this.Chapter_Total,
  });
  factory detail.fromJson(Map<String, dynamic> json) => new detail(
        Id: json["Id"],
        Category_Id: json["Category_Id"],
        //Chapter
        Chapter: json["Chapter"],
        zh_Chapter: json["zh_Chapter"],
        es_Chapter: json["es_Chapter"],
        hi_Chapter: json["hi_Chapter"],
        ar_Chapter: json["ar_Chapter"],
        ru_Chapter: json["ru_Chapter"],
        ja_Chapter: json["ja_Chapter"],
        de_Chapter: json["de_Chapter"],
        //Description
        Description: json["Description"],
        zh_Description: json["zh_Description"],
        es_Description: json["es_Description"],
        hi_Description: json["hi_Description"],
        ar_Description: json["ar_Description"],
        ru_Description: json["ru_Description"],
        ja_Description: json["ja_Description"],
        de_Description: json["de_Description"],
        //Short_Description
        Short_Description: json["Short_Description"],
        zh_Short_Description: json["zh_Short_Description"],
        es_Short_Description: json["es_Short_Description"],
        hi_Short_Description: json["hi_Short_Description"],
        ru_Short_Description: json["ru_Short_Description"],
        ar_Short_Description: json["ar_Short_Description"],
        ja_Short_Description: json["ja_Short_Description"],
        de_Short_Description: json["de_Short_Description"],
        //Chapter_Count
        Chapter_Count: json["Chapter_Count"],
        //Author_name
        ar_Author_name: json["ar_Author_name"],
        de_Author_name: json["de_Author_name"],
        en_Author_name: json["en_Author_name"],
        es_Author_name: json["es_Author_name"],
        hi_Author_name: json["hi_Author_name"],
        ja_Author_name: json["ja_Author_name"],
        ru_Author_name: json["ru_Author_name"],
        zh_Author_name: json["zh_Author_name"],
        //title
        Title: json["Title"],
        zh_Title: json["zh_Title"],
        es_Title: json["es_Title"],
        hi_Title: json["hi_Title"],
        ar_Title: json["ar_Title"],
        ru_Title: json["ru_Title"],
        ja_Title: json["ja_Title"],
        de_Title: json["de_Title"],
        //Chapter_Total
        Chapter_Total: json["Total_Chapter"],
        //Other fields items here
      );
}
