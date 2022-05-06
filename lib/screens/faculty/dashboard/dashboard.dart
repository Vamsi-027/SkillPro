import 'package:firstskillpro/Services/api.dart';
import 'package:firstskillpro/screens/faculty/dashboard/competencydata.dart';
import 'package:firstskillpro/screens/faculty/dashboard/demo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'package:provider/provider.dart';

class FacultyDashBoard extends StatefulWidget {
  const FacultyDashBoard({Key? key}) : super(key: key);

  @override
  State<FacultyDashBoard> createState() => _FacultyDashBoardState();
}

class _FacultyDashBoardState extends State<FacultyDashBoard> {
  bool first = true;
  bool loading = true;
  late Api obj;
  void getFacultyData() async {
    if (obj.competencyList != null) {
      setState(() {
        loading = false;
      });
      return;
    }
    bool k = await obj.getCompetencyList(
        speciality: obj.specialityCheck!.details.speciality);
    if (k) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> getStudentData() async {
    if (obj.specialitiesList != null) {
      setState(() {
        loading = false;
      });
      return;
    }
    bool k = await obj.getSpecialityList();

    if (k) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> getCompList() async {
    setState(() {
      fetchingStudentComp = false;
    });
    bool k = await obj.getStudentcompetencyList(
        mail: obj.profileData.first.email, speciality: selectedSpeciality!);

    if (k) {
      if (!mounted) return;
      setState(() {
        fetchingStudentComp = false;
      });
    }
  }

  bool fetchingStudentComp = false;
  String? selectedSpeciality;

  @override
  Widget build(BuildContext context) {
    obj = Provider.of<Api>(context);
    if (first) {
      first = false;
      obj.loginCheck!.role == 'faculty' ? getFacultyData() : getStudentData();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "SKILLPRO",
          style: GoogleFonts.baloo(
            letterSpacing: 5,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                        child: CircleAvatar(
                          backgroundImage: Image.network(
                                  'https://flyinryanhawks.org/wp-content/uploads/2016/08/profile-placeholder.png')
                              .image,
                          radius: 35,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Name : ${obj.profileData.first.name}',
                            style: poppins,
                          ),
                          Text(
                            'Email: ${obj.profileData.first.email}',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(),
                          ),
                          Text(
                            'Role : ${obj.profileData.first.role}',
                            style: poppins,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20.00,
                    thickness: 2.00,
                    color: Colors.black,
                  ),
                  obj.loginCheck!.role == 'faculty'
                      ? ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            for (int i = 0;
                                i < obj.competencyList!.details!.length;
                                i++)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            CompetencydetailsScreen(
                                          competencyID: obj.competencyList!
                                              .details![i].competencyid,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    obj.competencyList!.details![i]
                                        .competencyname,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : Column(
                          children: [
                            Card(
                              elevation: 0,
                              child: Container(
                                color: Colors.grey,
                                padding: const EdgeInsets.all(0),
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    underline: DropdownButtonHideUnderline(
                                      child: Container(),
                                    ),
                                    items: obj.specialitiesList!.details
                                        .map((type) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          type.specialityName,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        value: type.specialityName,
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      "Choose a Speciality",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    value: selectedSpeciality,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedSpeciality = newValue;
                                        getCompList();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            fetchingStudentComp
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: <Widget>[
                                      for (int i = 0;
                                          i < obj.studentcompetencyList.length;
                                          i++)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute<dynamic>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          DemoTable(
                                                    competencyid: obj
                                                        .studentcompetencyList[
                                                            i]
                                                        .competencyid,
                                                    studentid: obj.profileData
                                                        .first.regno,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              obj.studentcompetencyList[i]
                                                  .competencyname,
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          ],
                        ),
                ],
              ),
            ),
    );
  }
}
