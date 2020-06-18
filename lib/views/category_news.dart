import 'package:FlutterNews/helper/news.dart';
import 'package:FlutterNews/helper/widget.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  const CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getCategoryNews();
    super.initState();
  }

  void getCategoryNews() async {
    CatrgoryNewsClass news = CatrgoryNewsClass();
    await news.getNews(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.share,
              ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: newslist.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: newslist[index].urlToImage ?? "",
                          title: newslist[index].title ?? "",
                          desc: newslist[index].description ?? "",
                          // content: newslist[index].content ?? "",
                          url: newslist[index].articleUrl ?? "",
                        );
                      }),
                ),
              ),
            ),
    );
  }
}
