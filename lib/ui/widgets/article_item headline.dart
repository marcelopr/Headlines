import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/ui/widgets/skeleton.dart';

class ArticleItemHeadLine extends StatelessWidget {
  final Article _article;

  const ArticleItemHeadLine({@required article}) : _article = article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 12.0,
      ),
      child: InkWell(
          onTap: () => _launchURL(context),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(
                  height: 240.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: _article.urlToImage,
                  placeholder: (context, url) =>
                      new Skeleton(height: 240.0, width: double.infinity),
                  errorWidget: (context, url, error) => Container(
                      child: Center(child: Icon(Icons.image, size: 50)),
                      height: 240.0),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      stops: [0, 1],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 100.0),
                    Text(
                      _article.title,
                      style: TextStyle(
                        fontFamily: 'BreeSerif',
                        fontSize: 21.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      _article.publishedAt,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.0,
                          fontFamily: 'BreeSerif'),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  void _launchURL(BuildContext context) async {
    try {
      await launch(
        _article.url,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation(
            startEnter: 'slide_up',
            startExit: 'android:anim/fade_out',
            endEnter: 'android:anim/fade_in',
            endExit: 'slide_down',
          ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível abrir a página')));
    }
  }
}
