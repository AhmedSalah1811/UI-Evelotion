import 'package:flutter/material.dart';

import 'home_page.dart';

class Subscription_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Simple, Transparent Pricing',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black87),
          child: Column(
            children: [
              PriceDetails(
                title: 'Starter',
                price: '29',
                duration: '/month',
                features: [
                  'Up to 5 projects',
                  'Basic Components',
                  'Email Support',
                  'Up to 5 projects',
                ],
              ),
              PriceDetails(
                title: 'Pro',
                price: '59',
                duration: '/month',
                features: [
                  'Up to 10 projects',
                  'Advanced Components',
                  'Priority Support',
                  'Collaboration Tools',
                ],
              ),
              PriceDetails(
                title: 'Enterprise',
                price: '99',
                duration: '/month',
                features: [
                  'Unlimited projects',
                  'All Components',
                  'Dedicated Support',
                  'Custom Solutions',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceDetails extends StatelessWidget {
  final String title;
  final String price;
  final String duration;
  final List<String> features;

  const PriceDetails({
    Key? key,
    required this.title,
    required this.price,
    required this.duration,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topLeft,
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                price,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                duration,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  '* $feature',
                  style: TextStyle(color: Colors.white),
                ),
              )),
          SizedBox(height: 20),
          SizedBox(
            width: 280,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home_page()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
