import 'package:flutter/material.dart';
import 'Login_page.dart';
import 'buildNavButton.dart';
import 'contact.dart';
import 'home_page.dart';
import 'subscription_page.dart';

class About_page extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<About_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(45),
              child: Text(
                'Feautres',
                style: TextStyle(color: Colors.blue, fontSize: 26),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), //
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: [
                Features(title: 'Component Library', features: [
                  'Acess a vast library of pru-built components ready to use in your project '
                ]),
                Features(title: 'Responsive Design', features: [
                  'All generated UIs are fully responsive and work prfectly on any device'
                ]),
                Features(title: 'Theme Customization', features: [
                  'Easily customize colors,fonts and styles to match your brand identity'
                ]),
                Features(title: 'Export Options', features: [
                  'Export your UI in multiple formats inculding HTML,React and Angular'
                ]),
                Features(title: 'Real-time Preview', features: [
                  'See changes instantly as you customize your UI Components'
                ]),
                Features(title: 'Code Generation', features: [
                  'Get clean,optimzed code that follows best practices and modren standers'
                ]),
              ],
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNavButton(context, "assets/images/home.png", Home_page(),
                  widget.runtimeType),
              buildNavButton(context, "assets/images/about.png", About_page(),
                  widget.runtimeType),
              buildNavButton(context, "assets/images/subscrption.png",
                  Subscription_page(), widget.runtimeType),
              buildNavButton(context, "assets/images/contact.png", Contact(),
                  widget.runtimeType),
              buildNavButton(context, "assets/images/login.png", LoginPage(),
                  widget.runtimeType),
            ],
          ),
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  final String title;
  final List<String> features;

  const Features({
    Key? key,
    required this.title,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      alignment: Alignment.topLeft,
      height: 220,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features
                    .map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            ' $feature',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
