import 'package:firstskillpro/Services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'package:provider/provider.dart';

class Mentoring extends StatefulWidget {
  const Mentoring({
    Key? key,
  }) : super(key: key);

  @override
  State<Mentoring> createState() => _MentoringState();
}

class _MentoringState extends State<Mentoring> {
  List<bool> referencePicked = [];
  Map<int, String> matter = {};
  bool first = true;
  bool loading = true;
  late Api obj;
  void getFacultyData() async {
    bool k = await obj.getOne2OneList(mail: obj.profileData.first.email);
    if (k) {
      if (!mounted) return;
      setState(() {
        for (var i = 0; i < obj.one2oneList.length; i++) {
          referencePicked.add(false);
          matter[obj.one2oneList[i].competencyevaluationId] = "";
        }
        loading = false;
      });
    }
  }

  void getStudentData() async {
    bool k = await obj.getOne2OneStudentList(mail: obj.profileData.first.email);
    if (k) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    obj = Provider.of<Api>(context);
    if (first) {
      loading = true;
      first = false;

      obj.loginCheck!.role == 'student' ? getStudentData() : getFacultyData();
    }
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25,
                  child: Divider(
                    height: 5,
                    thickness: 2,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: (obj.loginCheck!.role == 'faculty')
                      ? obj.one2oneList.length
                      : obj.one2oneStudentList.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                (obj.loginCheck!.role == 'faculty')
                                    ? '${i + 1}. ${obj.one2oneList[i].studentname} - ${obj.one2oneList[i].studentid}'
                                    : '${i + 1}. ${obj.one2oneStudentList[i].facultyname}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                            (obj.loginCheck!.role == 'faculty')
                                ? Checkbox(
                                    value: false,
                                    onChanged: (bool? m) async {
                                      setState(() {
                                        loading = true;
                                      });
                                      var formData = {
                                        "competencyevaluationid": obj
                                            .one2oneList[i]
                                            .competencyevaluationId,
                                        "meettime": matter[obj.one2oneList[i]
                                            .competencyevaluationId],
                                      };
                                      bool k = await obj.submitOne2One(
                                        formData: formData,
                                      );
                                      if (k) {
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    })
                                : Container(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                (obj.loginCheck!.role == 'faculty')
                                    ? 'Competency: ${obj.one2oneList[i].competencyname}'
                                    : 'Competency: ${obj.one2oneStudentList[i].competencyname}',
                                style: GoogleFonts.poppins()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                (obj.loginCheck!.role == 'faculty')
                                    ? matter[obj.one2oneList[i]
                                            .competencyevaluationId] ??
                                        ""
                                    : obj.one2oneStudentList[i].meettime,
                                style: GoogleFonts.poppins()),
                          ],
                        ),

                        (obj.loginCheck!.role == 'faculty')
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      addmentoring(
                                          context,
                                          obj.one2oneList[i]
                                              .competencyevaluationId);
                                    },
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(Icons.alarm),
                                        Text(
                                          'Add Slot',
                                          style: poppins,
                                        )
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 20,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      primary: secondaryColor,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        // Visibility(
                        //   child: PickTime(),
                        //   visible: timepicked,
                        // ),
                        SizedBox(
                          height: 25,
                          child: Divider(
                            height: 5,
                            thickness: 2,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
  }

  void done(int id) {
    setState(() {
      matter[id] =
          "${selectedTime.hour}h : ${selectedTime.hour}m ${selectedDate.toString().split(" ").first}";
    });
  }

  void addmentoring(BuildContext context, int id) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (a1, a2, child) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(child: Text("Please Select Date and Time")),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Date : ${selectedDate.toString().split(' ').first}",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Time : ${selectedTime.hour} h : ${selectedTime.minute} m",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.4,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          disabledColor: Colors.white,
                          color: Colors.white,
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100));
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                          child: Text(
                            "Pick Date",
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
                      SizedBox(height: 5),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.4,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          disabledColor: Colors.white,
                          color: Colors.white,
                          onPressed: () async {
                            final TimeOfDay? picked_s = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );

                            if (picked_s != null && picked_s != selectedTime)
                              setState(() {
                                selectedTime = picked_s;
                              });
                          },
                          child: Text(
                            "Pick Time",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
                      SizedBox(height: 5),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.4,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          disabledColor: Colors.white,
                          color: Colors.green,
                          onPressed: () async {
                            done(id);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}

// class PickTime extends StatelessWidget {
//   const PickTime({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TimePickerDialog(
//       helpText: 'Select available time slot',
//       initialEntryMode: TimePickerEntryMode.input,
//       initialTime: TimeOfDay.now(),
//     );
//   }
// }
