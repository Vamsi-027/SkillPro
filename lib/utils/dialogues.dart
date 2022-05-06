import 'package:flutter/material.dart';

void addmentoring(BuildContext context) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (a1, a2, child) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(0),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text("Are you sure to quit login?")),
                  SizedBox(height: 5),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.4,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      disabledColor: Colors.white,
                      color: Colors.white,
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RenewPackage(),
                        //   ),
                        // );
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.4,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      disabledColor: Colors.white,
                      color: Colors.white,
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SubscriptionPage(
                        //       pass1: widget.pass1,
                        //       renew: true,
                        //       isChangePlan: true,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                            ),
                            Text(
                              "  or  ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                letterSpacing: 1,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
