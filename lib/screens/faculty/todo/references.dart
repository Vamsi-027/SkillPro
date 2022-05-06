import 'package:firstskillpro/Services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'package:provider/provider.dart';

class FacultyReferences extends StatefulWidget {
  const FacultyReferences({
    Key? key,
  }) : super(key: key);

  @override
  State<FacultyReferences> createState() => _FacultyReferencesState();
}

class _FacultyReferencesState extends State<FacultyReferences> {
  List<bool> referencePicked = [];
  Map<int, String> matter = {};
  bool first = true;
  bool loading = true;
  late Api obj;

  void getFacultyData() async {
    bool k = await obj.getReferenceList(mail: obj.profileData.first.email);
    if (k) {
      if (!mounted) return;
      setState(() {
        for (var i = 0; i < obj.referenceList.length; i++) {
          referencePicked.add(false);
          matter[obj.referenceList[i].competencyevaluationId] = "";
        }
        loading = false;
      });
    }
  }

  void getStudentData() async {
    bool k =
        await obj.getReferenceStudentList(mail: obj.profileData.first.email);
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
      loading = true;
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
                      ? obj.referenceList.length
                      : obj.referenceStudentList.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                obj.loginCheck!.role == 'student'
                                    ? '${i + 1}. ${obj.referenceStudentList[i].facultyname} - ${obj.referenceStudentList[i].evaluationtype}'
                                    : '${i + 1}. ${obj.referenceList[i].studentname} - ${obj.referenceList[i].studentid}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                            obj.loginCheck!.role == 'student'
                                ? Container()
                                : Checkbox(
                                    value: false,
                                    onChanged: (bool? m) async {
                                      setState(() {
                                        loading = true;
                                      });
                                      var formData = {
                                        "competencyevaluationid": obj
                                            .referenceList[i]
                                            .competencyevaluationId,
                                        "refermatter": matter[obj
                                            .referenceList[i]
                                            .competencyevaluationId],
                                        "criteriaid":
                                            obj.referenceList[i].criteriaid,
                                      };
                                      bool k = await obj.submitReference(
                                        formData: formData,
                                      );
                                      if (k) {
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                obj.loginCheck!.role == 'student'
                                    ? 'Competency: ${obj.referenceStudentList[i].competencyname}'
                                    : 'Competency: ${obj.referenceList[i].competencyname}',
                                style: GoogleFonts.poppins()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                obj.loginCheck!.role == 'student'
                                    ? 'Criteria qs: ${obj.referenceStudentList[i].criteriaqs}'
                                    : 'Criteria qs: ${obj.referenceList[i].criteriaqs}',
                                style: GoogleFonts.poppins()),
                          ],
                        ),
                        obj.loginCheck!.role == 'student'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Reference : ${obj.referenceStudentList[i].reference}',
                                      style: GoogleFonts.poppins()),
                                ],
                              )
                            : Container(),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Text('Asked on 25/Dec/20201',
                        //         style: GoogleFonts.poppins()),
                        //   ],
                        // ),
                        obj.loginCheck!.role == 'student'
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        referencePicked[i] =
                                            !referencePicked[i];
                                      });
                                    },
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(Icons.add),
                                        Text(
                                          'Add Reference',
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
                              ),
                        obj.loginCheck!.role == 'student'
                            ? Container()
                            : referencePicked[i]
                                ? Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Recommendations"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(Icons.auto_stories_rounded),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3,
                                            child: TextFormField(
                                              initialValue: matter[obj
                                                  .referenceList[i]
                                                  .competencyevaluationId],
                                              onChanged: (data) {
                                                matter[obj.referenceList[i]
                                                        .competencyevaluationId] =
                                                    data;
                                              },
                                              keyboardType: TextInputType.text,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
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
}
