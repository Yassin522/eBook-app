// divece hight  and width
double? width;
double? height;
// according to language Book_name
String? en_Title;
String? zh_Title;
String? hi_Title;
String? ru_Title;
String? ar_Title;
String? es_Title;
String? de_Title;
String? ja_Title;
// according to language Author_name
String Author_name = "";
String zh_Author_name = "";
String hi_Author_name = "";
String ru_Author_name = "";
String ar_Author_name = "";
String es_Author_name = "";
String de_Author_name = "";
String ja_Author_name = "";
//total chapter
int? chapter_total;
//For Drawer Animation Variable
bool isDrawerOpen = false;
double xOffset = 0;
double yOffset = 0;
double scaleFactor = 1;
// app color
bool dark_mode = true;
// read along with text
String detailtext = " ";
double Fontsize_for_read_along = 15;
double Linespacing_for_read_along = 1;
double Lattersapcing_for_read_along = 1;

// Flag of Last chapter of Book After this book will be a complete
int? Last_Chapter;

//book complete
bool book_notcomplete = true;

// Global Language Variable
String? Language_flag;
