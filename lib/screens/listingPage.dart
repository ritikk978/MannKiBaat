import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mannkibaat/screens/diarypage.dart';
import 'package:mannkibaat/screens/homepage.dart';
import 'package:mannkibaat/screens/nearestplace.dart';
import 'package:mannkibaat/widgets/Button.dart';
import 'package:firebase_database/firebase_database.dart';

class ListingPage extends StatefulWidget {
  static const String id = 'listingPage';


  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {

  List<Map<String, String>> send=[
    {"WifiHub": "https://i2.wp.com/www.cablefree.net/wp-content/uploads/2017/05/CableFree-Wi-Fi_Logo.png?fit=2000%2C1283&ssl=1"},
    {"Yoga Centres" : "https://images.vexels.com/media/users/3/153134/isolated/preview/855e1b2ba8f42ddfcc5668c6371dba23-easy-yoga-pose-silhouette-by-vexels.png"},
    {"Sports Club": "https://www.searchpng.com/wp-content/uploads/2019/01/Cricket-Sports-PNG-715x715.png"},
    {"Bars": "https://www.pngkey.com/png/full/890-8902429_pineapple-clipart-wine-clip-art-wine-cheers.png"},
    {"Gym": "https://lh3.googleusercontent.com/proxy/Ddf2ExtZI7rFjDLz-N5P3tcNg3_c8WsMdXoFH82BGA2SK3Y00HdqBUGPhuAqou01vyDhRI6mMSZ2ayP4C-oQfv2-fNzfZHXNgZZ6Z0_wZ6IzrSEkar0cWc19bPMDtv_AQgc"},
    {"Libary": "https://png.pngtree.com/png-clipart/20190117/ourmid/pngtree-hand-painted-teachers-day-a-stack-of-books-book-png-image_432486.jpg"},
    {"Theatres": "https://lh3.googleusercontent.com/proxy/9DWyFTBaZFdIzjwfpKFbg9IPbc81HKvD3HLMGDkkzjgaHtqQ14mP4xnPp_CUlSBGDmJka_pEB1HQv0orWEJsP-4QRniXIRins8HN1pJdi0dPHGoyhEA"},
    {"Mental Health Checkup": "https://freepngimg.com/thumb/health/22905-6-health-file.png"},
  ] ;


  // DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('listing');

  // void readData(){
  //   // databaseReference.once().then((DataSnapshot snapshot) {
  //   //   print('Data : ${snapshot.value}');
  //   // });
  //
  //   ///////////Write Data///////////////
  //   // DBRef.child("listing").push().set({
  //   //   "id": '2',
  //   //   "name": 'YogaHub',
  //   //
  //   // });
  // }
  final DBRef = FirebaseDatabase.instance.reference();
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              Button(
                title: 'No',
                color: Color(0xFF167F67),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              Button(
                title: 'Yes',
                color: Color(0xFF167F67),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        ) ??
        false;
  }


  // Widget _buildListingListItem({Map listing}){
  //   return Container(
  //     height: 100,
  //     color: Colors.white,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //
  //       children: [
  //         Row(
  //           children: [
  //             Text(listing['name'], style: TextStyle(fontSize: 16,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold),
  //             )
  //           ],
  //         )
  //       ],
  //
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, DiaryPage.id, (route) => false);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
              child: Text(
                'Listings',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions:[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffc478),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0, right: 2),
                          child: Icon(
                            Icons.book,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Smart Diary', style: TextStyle(color: Colors.black),)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],

          ),
          body: SafeArea(
            child: Container(
              color: Color(0xffbbdfc8),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Column(
                    children: [
                      InkWell(

                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NearestPlace(nameOfActivity: 'WifiHub',),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 3),
                                  borderRadius: BorderRadius.all(
                              Radius.circular(5.0) //                 <--- border radius here
                            ),
                                  boxShadow: [BoxShadow(blurRadius: 5,color: Color(0xffffc478))]
                              ),

                              child: Column(
                                children: [
                                  Image(
                                  image: AssetImage('images/WifiHub.png'),
                                    height: 150,
                                    width: 250,),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text('WifiHub', style: TextStyle(fontSize: 30),),
                                  )
                                ],
                              ),
                            ),
                          ),

                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestPlace(nameOfActivity: 'Theatres',),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0) //                 <--- border radius here
                                ),
                                boxShadow: [BoxShadow(blurRadius: 5,color:  Color(0xffffc478))]
                            ),
                            child: Column(
                              children: [

                                Image(
                                  image: AssetImage('images/theatre.png'),
                                  height: 80,
                                  width: 100,),
                                Text('Theatres')
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestPlace(nameOfActivity: 'Yoga Centers',),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0) //                 <--- border radius here
                                ),
                                boxShadow: [BoxShadow(blurRadius: 5,color:  Color(0xffffc478))]
                            ),
                            child: Column(
                              children: [
                                Image.network("https://images.vexels.com/media/users/3/153134/isolated/preview/855e1b2ba8f42ddfcc5668c6371dba23-easy-yoga-pose-silhouette-by-vexels.png",
                                  height: 80,
                                  width: 80,),
                                Text('Yoga Centres')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestPlace(nameOfActivity: 'Sports Club',),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0) //                 <--- border radius here
                                ),
                                boxShadow: [BoxShadow(blurRadius: 5,color:  Color(0xffffc478))]
                            ),
                            child: Column(
                              children: [
                                Image.network("https://www.searchpng.com/wp-content/uploads/2019/01/Cricket-Sports-PNG-715x715.png",
                                  height: 80,
                                  width: 80,),
                                Text('Sports Club'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestPlace(nameOfActivity: 'Bars',),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0) //                 <--- border radius here
                                ),
                                boxShadow: [BoxShadow(blurRadius: 5,color: Color(0xffffc478))]
                            ),
                            child: Column(
                              children: [
                                Image.network("https://www.pngkey.com/png/full/890-8902429_pineapple-clipart-wine-clip-art-wine-cheers.png",
                                  height: 80,
                                  width: 80,),
                                Text('Bars')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 25),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestPlace(nameOfActivity: 'Gym',),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0) //                 <--- border radius here
                                ),
                                boxShadow: [BoxShadow(blurRadius: 5,color:  Color(0xffffc478))]
                            ),
                            child: Column(
                              children: [

                                Image(
                                  image: AssetImage('images/gym.png'),
                                  height: 80,
                                  width: 80,),
                                Text('Gym')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 25,),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestPlace(nameOfActivity: 'Library',),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0) //                 <--- border radius here
                                ),
                                boxShadow: [BoxShadow(blurRadius: 5,color:  Color(0xffffc478))]
                            ),
                            child: Column(

                              children: [
                                Image.network("https://i.pinimg.com/originals/5f/fb/de/5ffbdeceb84323decd76084b2efca958.png",
                                  height: 80,
                                  width: 80,),
                                Text('Library'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestPlace(nameOfActivity: 'Mental Health Checkup',),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0) //                 <--- border radius here
                                ),
                                boxShadow: [BoxShadow(blurRadius: 5,color:  Color(0xffffc478))]
                            ),
                            child: Column(
                                  children: [
                                    Image.network("https://freepngimg.com/thumb/health/22905-6-health-file.png",
                                      height: 80,
                                      width: 80,),
                                    Text('Mental Health Checkup')
                                  ],
                                ),
                          ),
                        ),
                      ),

                                         // Padding(
                      //   padding: const EdgeInsets.only(top: 8.0, left: 18, right:24),
                      //   child: Column(
                      //     children: [
                      //       Image.network("https://i2.wp.com/www.cablefree.net/wp-content/uploads/2017/05/CableFree-Wi-Fi_Logo.png?fit=2000%2C1283&ssl=1",
                      //         height: 80,
                      //         width: 80,),
                      //       Text('Sport\'s Club'),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),

                ],
              ),
            ),
          )

        ),
    );
  }
}

