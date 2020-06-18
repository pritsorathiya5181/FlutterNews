import 'package:FlutterNews/views/article_view.dart';
import 'package:flutter/material.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  const BlogTile(
      {@required this.imageUrl, @required this.title, @required this.desc, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl: url,
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              desc,
              maxLines: 2,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
