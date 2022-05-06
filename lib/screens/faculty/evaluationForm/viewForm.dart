import 'package:firstskillpro/Models/studentEvaluation.dart';
import 'package:firstskillpro/Services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'package:provider/provider.dart';

class ViewEvaluationForm extends StatefulWidget {
  final int competencyid;
  final StudentEvaluation studentEvaluation;
  const ViewEvaluationForm(
      {Key? key, required this.competencyid, required this.studentEvaluation})
      : super(key: key);

  @override
  _ViewEvaluationFormState createState() => _ViewEvaluationFormState();
}

class _ViewEvaluationFormState extends State<ViewEvaluationForm> {
  late Api obj;

  bool first = true;
  bool loading = true;

  void getFacultyData() async {
    bool k = await obj.checkEvaluationForm(
        competencyevaluationid:
            widget.studentEvaluation.compentencyevaluationid,
        competencyid: widget.competencyid);
    if (k) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  void getStudentData() async {
    bool k = await obj.checkStudentEvaluationForm(
        competencyevaluationid:
            widget.studentEvaluation.compentencyevaluationid,
        competencyid: widget.competencyid);
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
      first = false;
      obj.loginCheck!.role == 'faculty' ? getFacultyData() : getStudentData();
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
                                  obj.loginCheck!.role == 'faculty'
                                      ? 'Date: ${obj.seeEvaluationForm!.date}'
                                      : 'Date: ${obj.seeStudentEvaluation!.date}',
                                  style: GoogleFonts.poppins(),
                                ),
                                Text(
                                  obj.loginCheck!.role == 'faculty'
                                      ? 'Patient OP: ${obj.seeEvaluationForm!.patientop}'
                                      : 'Patient OP: ${obj.seeStudentEvaluation!.patientop}',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  obj.loginCheck!.role == 'faculty'
                                      ? 'Time: ${obj.seeEvaluationForm!.time}'
                                      : 'Time: ${obj.seeStudentEvaluation!.time}',
                                  style: GoogleFonts.poppins(),
                                ),
                                Text(
                                  obj.loginCheck!.role == 'faculty'
                                      ? 'For: ${obj.seeEvaluationForm!.studentname}'
                                      : 'For: ${obj.seeStudentEvaluation!.studentname}',
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
                        obj.loginCheck!.role == 'faculty'
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    for (var i = 0;
                                        i <
                                            obj.seeEvaluationForm!
                                                .criteriadetails.length;
                                        i++) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '${i + 1}. ${obj.seeEvaluationForm!.criteriadetails[i].criteriaqs}:',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Switch(
                                            value: obj
                                                        .seeEvaluationForm!
                                                        .criteriadetails[i]
                                                        .refermatter ==
                                                    ""
                                                ? false
                                                : true,
                                            activeColor: secondaryColor,
                                            onChanged: (value) {},
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                                '${obj.seeEvaluationForm!.criteriadetails[i].optionval} - ${obj.seeEvaluationForm!.criteriadetails[i].optionmatter}'),
                                            leading: Radio(
                                              value: 0,
                                              groupValue: 0,
                                              onChanged: (Object? value) {},
                                            ),
                                          ),
                                          obj
                                                      .seeEvaluationForm!
                                                      .criteriadetails[i]
                                                      .refermatter ==
                                                  ""
                                              ? Container()
                                              : Card(
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
                                                          children: const [
                                                            Text(
                                                                "Recommendations"),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(Icons
                                                                .auto_stories_rounded),
                                                          ],
                                                        ),
                                                        const SizedBox(
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
                                                            initialValue: obj
                                                                .seeEvaluationForm!
                                                                .criteriadetails[
                                                                    i]
                                                                .refermatter,
                                                            enabled: false,
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
                                                ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    for (var i = 0;
                                        i <
                                            obj.seeStudentEvaluation!
                                                .criteriadetails.length;
                                        i++) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '${i + 1}. ${obj.seeStudentEvaluation!.criteriadetails[i].criteriaqs}:',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Reference Asked ?',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Switch(
                                                value: obj
                                                            .seeStudentEvaluation!
                                                            .criteriadetails[i]
                                                            .refermatter ==
                                                        ""
                                                    ? false
                                                    : true,
                                                activeColor: secondaryColor,
                                                onChanged: (value) {},
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                                '${obj.seeStudentEvaluation!.criteriadetails[i].optionval} - ${obj.seeStudentEvaluation!.criteriadetails[i].optionmatter}'),
                                            leading: Radio(
                                              value: 0,
                                              groupValue: 0,
                                              onChanged: (Object? value) {},
                                            ),
                                          ),
                                          obj
                                                      .seeStudentEvaluation!
                                                      .criteriadetails[i]
                                                      .refermatter ==
                                                  ""
                                              ? Container()
                                              : Card(
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
                                                          children: const [
                                                            Text(
                                                                "Recommendations"),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(Icons
                                                                .auto_stories_rounded),
                                                          ],
                                                        ),
                                                        const SizedBox(
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
                                                            initialValue: obj
                                                                .seeStudentEvaluation!
                                                                .criteriadetails[
                                                                    i]
                                                                .refermatter,
                                                            enabled: false,
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
                                                ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
