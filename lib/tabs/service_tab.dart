import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zukes/widgets/getNewAPIdata.dart';

class ServiceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          onRefresh: getLatestTrans,
          child: ListView(children: [
            KraCardSample(),
            KraGrid(),
          ]),
        ),
      ),
    ));
  }
}

class KraCardSample extends StatelessWidget {
  const KraCardSample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            height: 180.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://sokodirectory.com/wp-content/uploads/2015/10/kenya-revenue-authority.png",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  //Image.network(
                  //   'https://sokodirectory.com/wp-content/uploads/2015/10/kenya-revenue-authority.png',
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Positioned(
                  top: 150.0,
                  left: 16.0,
                  right: 16.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Partner Image Card',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  final url = "tel:0709090909";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text('📞 Contact Sales Department'),
              ),
            ],
          ),
        ]));
  }
}

class KraGrid extends StatefulWidget {
  @override
  _KraGridState createState() => _KraGridState();
}

class _KraGridState extends State<KraGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          ServiceTile(
            route: "/kraform",
            description: "Apply for Automated KRA tax filing.\n",
            imageURL:
                "https://sokodirectory.com/wp-content/uploads/2015/10/kenya-revenue-authority.png",
            status: true,
          ),
          ServiceTile(
            route: "/kraform",
            description: "Apply for an 💷insuarnce policy for your property.",
            imageURL:
                "https://cdn.logojoy.com/wp-content/uploads/2018/07/30124946/insuranceb.png",
            status: false,
          ),
          ServiceTile(
            route: "/kraform",
            description:
                "Apply for a 🏡Property advertising policy for your property.",
            imageURL:
                "https://images-platform.99static.com/eWZkBuTHmSjfhUu2JQbP6zmIPAc=/0x0:1500x1500/500x500/top/smart/99designs-contests-attachments/105/105938/attachment_105938209",
            status: false,
          ),
        ],
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String imageURL;
  final String description;
  final bool status;
  final String route;

  const ServiceTile({
    Key key,
    @required this.route,
    @required this.imageURL,
    @required this.description,
    @required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
          child: Stack(
        children: [
          GridTile(
            footer: Container(color: Colors.white, child: Text(description)),
            child: Container(
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: imageURL,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              status ? Text("Active ✅") : Text("Not Active ⏳"),
            ],
          )
        ],
      )),
    );
  }
}
