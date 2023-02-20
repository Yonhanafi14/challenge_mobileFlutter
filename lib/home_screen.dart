import 'dart:io';
//import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:battery_plus/battery_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:login_form_challenge/location_kedua.dart';
import 'package:login_form_challenge/location_page.dart';
import 'package:login_form_challenge/contstant.dart';
import 'package:login_form_challenge/maps_page.dart';
import 'package:login_form_challenge/soc_data.dart';
import 'location_page.dart';
import 'camera_page.dart';
//import 'package:http/http.dart' as http;
//import 'package:register_talk/register_screen.dart';
//import 'package:register_talk/res_login.dart';
//import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  File? imageFile;
  //bool _load = false;
  late PageController _pageController;

//int _currentIndex = 0;
  var battery = Battery();
  int percentage = 0;

  void getBatteryPerentage() async {
    final level = await battery.batteryLevel;
    percentage = level;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getBatteryPerentage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff635985),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80.0),
                      bottomLeft: Radius.circular(80.0)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xff443C68),
                        Color(0xff18122B),
                        //#18122B
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/synapsis.png',
                        width: 100,
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Welcome back sir !!",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffECF2FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 432,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  // BOTTOM 1
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 45, right: 45),
                    width: 300,
                    height: 350,
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMMMEd().format(DateTime.now()),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: darkBlueColor,
                            ),
                          ),
                          Text(
                            DateFormat.jm().format(DateTime.now()),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: darkBlueColor,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          //FOR BATTERY
                          Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.battery_charging_full,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 8,
                                ),

                                // Displaying battery percentage
                                Text(
                                  'Battery Percentage: $percentage %',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => GPSCoordinate()));
                              //_load = false;
                              setState(() {});
                            },
                            child: const Text('GPS Coordinate'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DeviceInfoApp()));
                              //_load = false;
                              setState(() {});
                            },
                            child: const Text('GPS Coordinate'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BOTTOM 2
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        width: 300,
                        height: 350,
                        color: Colors.grey[200],
                        child: (imageFile != null)
                            ? Image.file(imageFile!)
                            : const SizedBox(),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          imageFile = await Navigator.push(context,
                              MaterialPageRoute(builder: (_) => CameraPage()));
                          //_load = false;
                          setState(() {});
                        },
                        child: const Text('Take a Picture'),
                      ),
                    ],
                  ),

                  // BOTTOM 3
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => MapsPage()));
                            //_load = false;
                            setState(() {});
                          },
                          child: const Text('Peta GPS'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage_sharp),
            label: 'Halaman A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Halaman C',
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme:
            const IconThemeData(color: Color(0xff8BF5FA), size: 40),
        selectedItemColor: const Color(0xff8BF5FA),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
      // _currentIndex =index;
    });
  }
}
