import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/ui/widgets/skeleton.dart';

class ArticleItemTablet extends StatelessWidget {
  final Article _article;

  const ArticleItemTablet({@required article}) : _article = article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: CachedNetworkImage(
              height: 250.0,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: _article.urlToImage,
              placeholder: (context, url) =>
                  Skeleton(height: 250.0, width: double.infinity),
              errorWidget: (context, url, error) => Container(
                  child: Center(child: Icon(Icons.image, size: 40.0)),
                  width: double.infinity,
                  height: 250.0),
            ),
          ),
          SizedBox(height: 8.0),

          ///Expanded para softwrap no Text()
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _article.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'BreeSerif',
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: Visibility(
                    visible: _article.description.isNotEmpty,
                    child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        _article.description,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'BreeSerif',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
