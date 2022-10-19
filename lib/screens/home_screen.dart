import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/screens/utils/sqlite_services.dart';
import 'package:sqflite/sqflite.dart';
import '../widgets/add_site_model.dart';
import 'add_site_screen.dart';
import 'package:passwordmanager/widgets/custom_card.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomeScreen extends StatefulWidget {
  int userid;
  HomeScreen({required this.userid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isselect = false;
  String? selectedValue;
  List<String> items = [
    'all',
    'Social media',
    'Bank',
    'Personal',
    'E-Commerce',
    'Others'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/pass_manager.png'),
        backgroundColor: const Color(0xFF0E85FF),
        elevation: 10,
        // leadingWidth: 30,
        leading: Image.asset('images/burger_menu.png'),
        actions: [
          Image.asset('images/search.png'),
          GestureDetector(
            child: Image.asset('images/sync_icn.png'),
            onTap: () {
              setState(() {});
            },
          ),
          Image.asset('images/profile.png'),
        ],
      ),
      body: Container(
        //  padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sites',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3C4857),
                            fontSize: 30),
                      ),
                      Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFFFA222),
                        ),
                      ),
                    ],
                  ),
                ),
                DropdownButton2(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                  hint: Text(
                    'Select Catagory',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black26,
                    ),
                  ),
                  items: items
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black54),
                          ),
                        ),
                      )
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _isselect = true;
                      if (selectedValue == 'Others' || selectedValue == "all") {
                        _isselect = false;
                      }
                      selectedValue = value as String;
                    });
                  },
                  buttonHeight: 60,
                  buttonWidth: 200,
                  itemHeight: 40,
                ),
              ],
            ),
            FutureBuilder(
              future: _isselect == false
                  ? DatabaseService.instance.getAllSite(widget.userid)
                  : DatabaseService.instance
                      .getSiteFilter(widget.userid, selectedValue!),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Site>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error ${snapshot.error.toString()}');
                  } else if (snapshot.hasData) {
                    List<Site> site = snapshot.data!;
                    return site.length > 0
                        ? Container(
                            height: MediaQuery.of(context).size.height - 198,
                            child: ListView.builder(
                                itemCount: site.length,
                                itemBuilder: (context, i) {
                                  print(site[i]);
                                  return InkWell(
                                    child: CustomCard(site: site[i]),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => AddSite(
                                                  appBarText: "Site Details",
                                                  userid: widget.userid,
                                                  site: site[i])));
                                    },
                                  );
                                  // return CustomCard(site[i]);
                                }),
                          )
                        : Text("nothing to show here");
                  } else {
                    return Center(child: const Text('Empty data'));
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  AddSite(appBarText: "Add Site", userid: widget.userid)));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
