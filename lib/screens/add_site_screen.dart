import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/screens/home_screen.dart';
import 'package:passwordmanager/screens/utils/sqlite_services.dart';
import '../widgets/add_site_model.dart';
import '../widgets/add_site_textfield.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../screens/utils/crypt.dart';

class AddSite extends StatefulWidget {
  String appBarText;
  Site? site;
  int? userid;
  AddSite({required this.appBarText, this.site, this.userid});
  @override
  State<AddSite> createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> with Crypt {
  bool _enable = true;
  bool _passwordVisibility = true;
  @override
  void initState() {
    super.initState();
    if (widget.site != null) {
      _enable = false;

      URlController.text = widget.site!.url;
      SiteNameController.text = widget.site!.siteName;
      SiteNameController.text = widget.site!.siteName;
      SectorController.dropDownValue = DropDownValueModel(
          name: widget.site!.sector, value: widget.site!.sector);
      SocialMediaController.dropDownValue = DropDownValueModel(
          name: widget.site!.socialMedia, value: widget.site!.socialMedia);
      UserNameController.text = widget.site!.username;
      PasswordController.text = Crypt.decryptePassword(widget.site!.password);
      NotesController.text = widget.site!.notes;
    }
  }

  final formKey = GlobalKey<FormState>();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  TextEditingController URlController = TextEditingController();
  TextEditingController SiteNameController = TextEditingController();
  SingleValueDropDownController SectorController =
      SingleValueDropDownController();
  SingleValueDropDownController SocialMediaController =
      SingleValueDropDownController();
  TextEditingController UserNameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController NotesController = TextEditingController();
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      URlController,
      SiteNameController,
      UserNameController,
      PasswordController,
      NotesController
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.appBarText}"),
            Visibility(
              visible: widget.site != null && _enable == false,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _enable = true;
                    widget.appBarText = "Edit";
                  });
                },
                child: Text('Edit'),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0E85FF),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          Text(
                            "URL",
                            style: TextStyle(color: Colors.black26),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          TextFormField(
                            enabled: _enable,
                            controller: URlController,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            "Site Name",
                            style: TextStyle(color: Colors.black26),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          TextFormField(
                            enabled: _enable,
                            controller: SiteNameController,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            "Sector/Folder",
                            style: TextStyle(color: Colors.black26),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          DropDownTextField(
                            isEnabled: _enable,
                            controller: SectorController,
                            listSpace: 5,
                            listPadding: ListPadding(top: 20),
                            enableSearch: false,
                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }
                            },
                            dropDownList: const [
                              DropDownValueModel(
                                  name: 'Social media', value: "Social media"),
                              DropDownValueModel(name: 'Bank', value: "Bank"),
                              DropDownValueModel(
                                  name: 'Personal', value: "Personal"),
                              DropDownValueModel(
                                  name: 'E-Commerce', value: "E-Commerce"),
                              DropDownValueModel(
                                  name: 'Others', value: "Others"),
                            ],
                            dropDownItemCount: 5,
                            onChanged: (val) {},
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            "Social Media",
                            style: TextStyle(color: Colors.black26),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          DropDownTextField(
                            isEnabled: _enable,
                            controller: SocialMediaController,
                            listSpace: 5,
                            listPadding: ListPadding(top: 20),
                            enableSearch: false,
                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }
                            },
                            dropDownList: const [
                              DropDownValueModel(
                                  name: 'Facebook', value: "Facebook"),
                              DropDownValueModel(
                                  name: 'Instagram', value: "Instagram"),
                              DropDownValueModel(
                                  name: 'Youtube', value: "Youtube"),
                              DropDownValueModel(
                                  name: 'Twitter', value: "Twitter"),
                            ],
                            dropDownItemCount: 4,
                            onChanged: (val) {},
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            "User Name",
                            style: TextStyle(color: Colors.black26),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          TextFormField(
                            enabled: _enable,
                            controller: UserNameController,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            "Site Password",
                            style: TextStyle(color: Colors.black26),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          TextFormField(
                            enabled: _enable,
                            obscureText: _passwordVisibility,
                            controller: PasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisibility =
                                        _passwordVisibility == true
                                            ? false
                                            : true;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            "Notes",
                            style: TextStyle(color: Colors.black26),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          TextFormField(
                            enabled: _enable,
                            controller: NotesController,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                        ],
                      ),
                    ),
                    widget.site == null
                        ? Row(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .07,
                                width: MediaQuery.of(context).size.width * .499,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0))),
                                  onPressed: () {
                                    controllers
                                        .forEach((element) => element.clear());
                                  },
                                  child: Text("Clear"),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .07,
                                width: MediaQuery.of(context).size.width * .499,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0))),
                                  onPressed: () {
                                    DatabaseService.instance.createSite({
                                      "url": URlController.text,
                                      "userid": widget.userid,
                                      "siteName": SiteNameController.text,
                                      "sector":
                                          SectorController.dropDownValue!.value,
                                      "socialMedia": SocialMediaController
                                          .dropDownValue!.value,
                                      "username": UserNameController.text,
                                      "password": Crypt.encryptPassword(
                                          PasswordController.text),
                                      "notes": NotesController.text,
                                    });
                                    DatabaseService.instance
                                        .getAllSite(widget.userid!);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Submit"),
                                ),
                              ),
                            ],
                          )
                        : Visibility(
                            visible: _enable,
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .07,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0))),
                                  onPressed: () {
                                    setState(() {
                                      DatabaseService.instance.updateSite({
                                        "id": widget.site!.id,
                                        "userid": widget.userid,
                                        "url": URlController.text,
                                        "userid": widget.userid,
                                        "siteName": SiteNameController.text,
                                        "sector": SectorController
                                            .dropDownValue!.value,
                                        "socialMedia": SocialMediaController
                                            .dropDownValue!.value,
                                        "username": UserNameController.text,
                                        "password": Crypt.encryptPassword(
                                            PasswordController.text),
                                        "notes": NotesController.text,
                                      });
                                      Navigator.pop(context);
                                      // Navigator.of(context).pushReplacement(
                                      // MaterialPageRoute(
                                      //     builder: (context) => HomeScreen(
                                      //         userid: widget.userid!))).then((value) => );
                                    });
                                  },
                                  child: Text("update"),
                                )))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
