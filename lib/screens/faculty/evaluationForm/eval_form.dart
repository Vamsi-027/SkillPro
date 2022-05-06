import 'package:firstskillpro/Models/studentEvaluation.dart';
import 'package:firstskillpro/Services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'package:provider/provider.dart';

class EvaluationForm extends StatefulWidget {
  final int competencyid;
  final StudentEvaluation studentEvaluation;
  final String studentId;
  const EvaluationForm(
      {Key? key,
      required this.competencyid,
      required this.studentEvaluation,
      required this.studentId})
      : super(key: key);

  @override
  _EvaluationFormState createState() => _EvaluationFormState();
}

class _EvaluationFormState extends State<EvaluationForm> {
  List<int> value = [];
  List<bool> referenceReq = [];
  Map<int, String> matter = {};
  late Api obj;
  bool mentoring = false;

  late ScrollController controller;
  bool fabIsVisible = true;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(() {
      setState(() {
        fabIsVisible =
            controller.position.userScrollDirection == ScrollDirection.forward;
      });
    });
  }

  bool first = true;
  bool loading = true;
  bool submitLoading = false;
  void getData() async {
    bool k = await obj.getEvaluationForm(
        competencyevaluationid:
            widget.studentEvaluation.compentencyevaluationid,
        competencyid: widget.competencyid);
    if (k) {
      if (!mounted) return;
      setState(() {
        loading = false;
        for (var i = 0; i < obj.evaluationForm!.criteriadetails.length; i++) {
          value.add(0);
          referenceReq.add(false);
          matter[obj.evaluationForm!.criteriadetails[i].criteiaid] = "";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    obj = Provider.of<Api>(context);
    if (first) {
      first = false;
      getData();
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "Evaluation Form",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                controller: controller,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        // Details of the competency...
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  obj.loginCheck!.role == 'student'
                                      ? 'Competency: ${obj.studentcompetencyList.where((e) => e.competencyid == widget.competencyid).toList().first.competencyname}'
                                      : 'Competency: ${obj.competencyList!.details!.where((e) => e.competencyid == widget.competencyid).toList().first.competencyname}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Date: ${obj.evaluationForm!.date}',
                                  style: GoogleFonts.poppins(),
                                ),
                                Text(
                                  'Patient OP: ${obj.evaluationForm!.patientop}',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Time: ${obj.evaluationForm!.time}',
                                  style: GoogleFonts.poppins(),
                                ),
                                Text(
                                  'For: ${obj.evaluationForm!.studentname}',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                          child: Divider(
                            height: 5,
                            thickness: 2,
                          ),
                        ),

                        // List of criterias and their details

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              for (var i = 0;
                                  i <
                                      obj.evaluationForm!.criteriadetails
                                          .length;
                                  i++) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${i + 1}. ${obj.evaluationForm!.criteriadetails[i].criteriaqs}:',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Need Reference ?',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Switch(
                                            value: referenceReq[i],
                                            activeColor: secondaryColor,
                                            onChanged: (value) {
                                              setState(() {
                                                referenceReq[i] =
                                                    !referenceReq[i];
                                              });
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                          '0 - ${obj.evaluationForm!.criteriadetails[i].option0}'),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: value[i],
                                        onChanged: (int? value1) =>
                                            setState(() {
                                          value[i] = value1!;
                                        }),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                          '1 - ${obj.evaluationForm!.criteriadetails[i].option1}'),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: value[i],
                                        onChanged: (int? value1) =>
                                            setState(() {
                                          value[i] = value1!;
                                        }),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                          '2 - ${obj.evaluationForm!.criteriadetails[i].option2}'),
                                      leading: Radio(
                                        value: 2,
                                        groupValue: value[i],
                                        onChanged: (int? value1) =>
                                            setState(() {
                                          value[i] = value1!;
                                        }),
                                      ),
                                    ),
                                    obj.loginCheck!.role == 'student'
                                        ? Container()
                                        : referenceReq[i]
                                            ? Card(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              "Recommendations"),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Icon(Icons
                                                              .auto_stories_rounded),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                        child: TextFormField(
                                                          initialValue: matter[obj
                                                              .evaluationForm!
                                                              .criteriadetails[
                                                                  i]
                                                              .criteiaid],
                                                          onChanged: (data) {
                                                            matter[obj
                                                                .evaluationForm!
                                                                .criteriadetails[
                                                                    i]
                                                                .criteiaid] = data;
                                                          },
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        //Submit Button
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: FloatingActionButton.extended(
                            onPressed: submitLoading
                                ? null
                                : () async {
                                    setState(() {
                                      submitLoading = true;
                                    });
                                    if (obj.loginCheck!.role == 'student') {
                                      var formData = {
                                        "criterias": [
                                          for (var i = 0;
                                              i <
                                                  obj.evaluationForm!
                                                      .criteriadetails.length;
                                              i++)
                                            {
                                              "criteriaid": obj.evaluationForm!
                                                  .criteriadetails[i].criteiaid,
                                              "score": value[i],
                                              "needrefermatter":
                                                  referenceReq[i] ? 1 : 0,
                                            },
                                        ],
                                        "needMeet": mentoring ? 1 : 0,
                                      };
                                      bool k =
                                          await obj.submitStudentEvaluationForm(
                                        formData: formData,
                                        competencyevaluationid: obj
                                            .evaluationForm!.compevaluationid,
                                      );
                                      if (k) {
                                        bool k = await obj.getStudentEvaluation(
                                            studentid: widget.studentId,
                                            competencyid: widget.competencyid);
                                        if (k) {
                                          setState(() {
                                            submitLoading = false;
                                          });
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    } else {
                                      var formData = {
                                        "criterias": [
                                          for (var i = 0;
                                              i <
                                                  obj.evaluationForm!
                                                      .criteriadetails.length;
                                              i++)
                                            {
                                              "criteriaid": obj.evaluationForm!
                                                  .criteriadetails[i].criteiaid,
                                              "score": value[i],
                                              "matter": matter[obj
                                                  .evaluationForm!
                                                  .criteriadetails[i]
                                                  .criteiaid]
                                            },
                                        ],
                                        "meettime": !mentoring
                                            ? ""
                                            : "${selectedTime.hour}h : ${selectedTime.hour}m ${selectedDate.toString().split(" ").first}"
                                      };

                                      bool k = await obj.submitEvaluationForm(
                                        formData: formData,
                                        competencyevaluationid: obj
                                            .evaluationForm!.compevaluationid,
                                      );
                                      if (k) {
                                        setState(() {
                                          submitLoading = false;
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  },
                            label: submitLoading
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Text(
                                    ' Submit ',
                                    style: poppins,
                                  ),
                            backgroundColor: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButton: obj.loginCheck!.role == 'student'
            ? AnimatedOpacity(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      mentoring = true;
                    });
                  },
                  label: Text(
                    mentoring ? 'Added' : 'Need mentoring ?',
                    style: poppins,
                  ),
                  backgroundColor: mentoring ? Colors.green : secondaryColor,
                ),
                duration: const Duration(milliseconds: 300),
                opacity: fabIsVisible ? 1 : 0,
              )
            : AnimatedOpacity(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    addmentoring(context);
                  },
                  label: Text(
                    mentoring ? 'Added' : 'Add mentoring ?',
                    style: poppins,
                  ),
                  backgroundColor: mentoring ? Colors.green : secondaryColor,
                ),
                duration: const Duration(milliseconds: 300),
                opacity: fabIsVisible ? 1 : 0,
              ),
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

  void done() {
    setState(() {
      mentoring = true;
    });
  }

  void addmentoring(BuildContext context) {
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
                            done();
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
