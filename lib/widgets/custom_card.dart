import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_site_model.dart';
import '../screens/utils/crypt.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomCard extends StatefulWidget {
  Site site;

  CustomCard({required this.site});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with Crypt {
  String iconLink = "images/logo/facebook_logo.png";
  String getLogo(String socialMediaChoice) {
    if (socialMediaChoice == 'Facebook') {
      iconLink = "images/logo/facebook_logo.png";
    } else if (socialMediaChoice == 'Instagram') {
      iconLink = "images/logo/Instagram.png";
    } else if (socialMediaChoice == 'Youtube') {
      iconLink = "images/logo/youtube.png";
    } else {
      iconLink = "images/logo/twitter.png";
    }
    return iconLink;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  getLogo(widget.site.socialMedia),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${widget.site.siteName}",
                      style: TextStyle(
                        color: Color(0xFF0E85FF),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(2),
                          child: const Icon(
                            Icons.copy_all_rounded,
                            color: Color(0xFF0E85FF),
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            'Copy Password',
                            style: TextStyle(
                                color: const Color(0xFF0E85FF).withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          onTap: () async {
                            Fluttertoast.showToast(
                              msg: "Copied to clipboard",
                              fontSize: 20,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                            );
                            await Clipboard.setData(
                              ClipboardData(
                                  text: Crypt.decryptePassword(
                                      widget.site.password)),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          Text(
            '${widget.site.url}',
            style: TextStyle(
              color: const Color(0xFF3C4857).withOpacity(0.8),
              fontSize: 15.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
