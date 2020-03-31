import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/ui/widgets/skeleton.dart';

class ArticleItem extends StatelessWidget {
  final Article _article;

  const ArticleItem({@required article}) : _article = article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CachedNetworkImage(
                        width: 90.0,
                        fit: BoxFit.fitHeight,
                        imageUrl: _article.urlToImage,
                        placeholder: (context, url) => Skeleton(width: 90),
                        errorWidget: (context, url, error) => Container(
                            child: Center(child: Icon(Icons.image)),
                            width: 90.0),
                      ),
                    ),
                    SizedBox(width: 12.0),

                    ///Expanded para softwrap no Text()
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _article.title,
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'BreeSerif',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Opacity(
                  opacity: 0.5,
                  child: Text(
                    _article.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'BreeSerif',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
