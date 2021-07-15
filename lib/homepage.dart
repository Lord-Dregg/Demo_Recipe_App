import 'package:flutter/material.dart';
import 'dart:ui';
import 'Providers/auth_provider.dart';
import './search_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const placeholderImage =
      'https://t4.ftcdn.net/jpg/02/07/87/79/240_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg';
  String name = 'Can\'t fetch data right now';
  String image = placeholderImage;

  String getMonth() {
    var months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var month = dateToday.month;
    var ret = months[month - 1];
    return ret.toString();
  }

  String getDate() {
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var day = dateToday.day;
    return day.toString();
  }

  Future getResult() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/random?number=1&apiKey=567c799a91de47d3bad11c19dad899e4'));
    var result = jsonDecode(response.body);

    setState(() {
      if (result['status'] == null) {
        name = result['recipes'][0]['title'];
        image = result['recipes'][0]['image'];
      } else {
        name = 'Can\'t fetch \ndata right now';
        image = placeholderImage;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getResult();
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    final Widget searchBar = Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(25.0),
      child: TextFormField(
        controller: searchController,
        onFieldSubmitted: (value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage(value)),
          );
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          suffixIcon: Icon(
            Icons.menu,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.only(left: 10.0, top: 15.0),
          hintStyle: TextStyle(
            fontFamily: 'Cooper',
            color: Colors.grey,
          ),
          hintText: 'Search a Recipe',
        ),
      ),
    );

    Widget getCard(String name, String image) {
      getResult();
      return Material(
        elevation: 7.0,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 150.0,
          width: 250.0,
          decoration: BoxDecoration(
            border: Border.all(width: 0.0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(image.toString()),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name.toString(),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 3,
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ],
          ),
        ),
      );
    }

    final Widget header = Row(
      children: [
        Container(
          width: 3.0,
          height: 31.0,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(
          width: 3.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'POPULAR RECIPES\nTHIS WEEK',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ],
    );

    final Widget header2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getMonth() + ' ' + getDate(),
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Comic',
          ),
        ),
        Text(
          'TODAY',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );

    final Widget footer = Container(
      height: 215,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 50.0,
              bottom: 50.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BEST OF\nTHE DAY',
                  style: TextStyle(
                    wordSpacing: 5.0,
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Comic',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 60.0,
                  height: 3.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Recipe App Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //Sign Out User
                AuthClass().signOut();
                Navigator.of(context).pushNamed('login-page');
              }),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Color.fromRGBO(255, 245, 230, 1),
                height: 100.0,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0),
                child: searchBar,
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                color: Color.fromRGBO(255, 245, 230, 1),
                height: 100.0,
                width: double.infinity,
              ),
              Container(
                //height: 560,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          header,
                          SizedBox(
                            height: 27.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              left: 5.0,
                              right: 10.0,
                            ),
                            height: 120,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return getCard(name, image);
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          header2,
                          SizedBox(height: 30),
                          footer,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
