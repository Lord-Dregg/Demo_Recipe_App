import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  final search;
  SearchPage(this.search);
  @override
  _SearchPageState createState() => _SearchPageState(search);
}

class _SearchPageState extends State<SearchPage> {
  var search;

  _SearchPageState(this.search);

  var imageUrl = '';
  var name = 'Loading...';
  var itemCount = 1;
  var res;
  //List searchresults = [];

  Future getResult() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$search&apiKey=567c799a91de47d3bad11c19dad899e4'));
    res = jsonDecode(response.body);

    setState(() {
      if (res['status'] == null) itemCount = res['number'];
      print(itemCount);
    });
  }

  @override
  void initState() {
    super.initState();
    this.getResult();
  }

  /*Widget resultTile = Material(
    elevation: 7.0,
    borderRadius: BorderRadius.circular(12.0),
    child: Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 0.0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(
            'https://t4.ftcdn.net/jpg/02/07/87/79/240_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg',
            scale: 1.2,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 90.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 70.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              Row(children: [
                SizedBox(
                  width: 70.0,
                ),
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
              ]),
            ],
          ),
        ],
      ),
    ),
  ); */

  List splitText(String text) {
    return text.split(' ').toList();
  }

  Widget buildTile(String name, String image) {
    return Material(
      elevation: 7.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        height: 180.0,
        width: double.infinity, //250.0,
        decoration: BoxDecoration(
          border: Border.all(width: 0.0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.orangeAccent.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 70.0,
              backgroundImage: NetworkImage(image.toString()),
            ),
            SizedBox(
              width: 20.0,
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
      ),
    );
  }

  Widget getTiles(BuildContext context, int i) {
    if (res['status'] == null) {
      name = res['results'][i]['title'].toString();
      imageUrl = res['results'][i]['image'].toString();
      return buildTile(name, imageUrl);
    } else {
      return Center(child: Text('Couldn\'t fetch data now'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          search.toString().toUpperCase() + ' Search Results',
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      backgroundColor: Colors.orangeAccent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(
            bottom: 20.0,
            right: 10.0,
            left: 10.0,
          ),
          itemCount: itemCount,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return getTiles(context, index);
          },
        ),
      ),
    );
  }
}

/*ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            var count = 0;
            if (count < itemCount) {
              count++;
              print(count);
              return getTiles();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),*/

/*
image: DecorationImage(
            image: NetworkImage(
              image.toString(),
              //'https://t4.ftcdn.net/jpg/02/07/87/79/240_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg',
              scale: 1.2,
            ),
            fit: BoxFit.fill,
          ),
*/

/* 
  Material(
      elevation: 7.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        height: 200.0,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 0.0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 135.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70.0,
                    ),
                    Text(
                      name.toString(),
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                Row(children: [
                  SizedBox(
                    width: 70.0,
                  ),
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
                ]),
              ],
            ),
          ],
        ),
      ),
    );
*/
