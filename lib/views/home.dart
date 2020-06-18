import 'package:FlutterNews/helper/news.dart';
import 'package:FlutterNews/helper/widget.dart';
import 'package:FlutterNews/models/article_model.dart';
import 'package:FlutterNews/models/category_model.dart';
import 'package:FlutterNews/helper/data.dart';
import 'package:FlutterNews/views/category_news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
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
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categorieName,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].articleUrl,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  const CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120.0,
                height: 60.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
