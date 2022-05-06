import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firstskillpro/Models/competencyDetails.dart';
import 'package:firstskillpro/Models/competencyList.dart';
import 'package:firstskillpro/Models/evaluationForm.dart';
import 'package:firstskillpro/Models/loginCheck.dart';
import 'package:firstskillpro/Models/one2oneStudentList.dart';
import 'package:firstskillpro/Models/profile.dart';
import 'package:firstskillpro/Models/referenceNeededList.dart';
import 'package:firstskillpro/Models/seeEvaluationForm.dart';
import 'package:firstskillpro/Models/specialityCheck.dart';
import 'package:firstskillpro/Models/specialityList.dart';
import 'package:firstskillpro/Models/studentEvaluation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api extends ChangeNotifier {
  String globalPassword = "";
  String globalEmail = "";
  LoginCheck? loginCheck;
  CompetencyList? competencyList;
  List<CompetencyDetails> competencyDetailsList = [];
  List<StudentcompetencyList> studentcompetencyList = [];
  List<Profile> profileData = [];
  EvaluationForm? evaluationForm;
  List<StudentEvaluation> studentEvaluation = [];
  SeeEvaluationForm? seeEvaluationForm;
  SeeStudentEvaluation? seeStudentEvaluation;
  SpecialityCheck? specialityCheck;
  List<One2OneMeet> one2oneList = [];
  List<One2OneMeetStudent> one2oneStudentList = [];
  List<ReferenceNeeded> referenceList = [];
  List<ReferenceStudentList> referenceStudentList = [];
  SpecialitiesList? specialitiesList;

  void notify() {
    notifyListeners();
  }

//------------------------ Local Storage ---------------------

  Future<bool> changeLoginStatus(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool m = await prefs.setString("email", email);
    m = await prefs.setString("password", password);
    globalEmail = prefs.getString("email")!;
    globalPassword = prefs.getString("password")!;
    notifyListeners();
    return true;
  }

  Future<bool> removeLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool m = await prefs.remove("email");
    m = await prefs.remove("password");
    globalPassword = "";
    globalEmail = "";
    competencyDetailsList = [];
    studentcompetencyList = [];
    profileData = [];
    studentEvaluation = [];
    one2oneList = [];
    one2oneStudentList = [];
    referenceList = [];
    referenceStudentList = [];
    notifyListeners();
    return true;
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    bool e = await prefs.containsKey('email');
    // ignore: await_only_futures
    bool p = await prefs.containsKey('password');
    if (e && p) {
      globalEmail = prefs.getString("email")!;
      globalPassword = prefs.getString("password")!;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

//------------------------ For DashBoard ---------------------

  Future<bool> getCompetencyList({required String speciality}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/fdashboard/competencydetails/$speciality',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        competencyList = CompetencyList.fromJson(response.data);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in login check");
      return false;
    }
  }

  Future<bool> getSpecialityList() async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/studentdashboard/specialities',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        specialitiesList = SpecialitiesList.fromJson(response.data);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in login check");
      return false;
    }
  }

  Future<bool> getCompetencyDetailsList(
      {required String speciality, required int competencyid}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/fdashboard/competencydetails/speciality/$speciality/competencyid/$competencyid',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        competencyDetailsList =
            competencyDetailsFromJson(json.encode(response.data));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in competenct list");
      print(e);
      return false;
    }
  }

  Future<bool> getStudentcompetencyList(
      {required String speciality, required String mail}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/studentdashboard/email/$mail/speciality/$speciality',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        studentcompetencyList =
            studentcompetencyListFromJson(json.encode(response.data));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in login check");
      return false;
    }
  }

//------------------------ Profile Details & Login ---------------------

  Future<bool> loginStatusCheck(
      {required String mail, required String password}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/login/$mail/$password',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        loginCheck = LoginCheck.fromJson(response.data);
        bool m = await changeLoginStatus(mail, password);
        notifyListeners();
        return m;
      }
      return false;
    } catch (e) {
      print(e);
      print("error in login check");
      return false;
    }
  }

  Future<bool> specialityStatusCheck({required String mail}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/fdashboard/details/$mail',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        specialityCheck = SpecialityCheck.fromJson(response.data);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in speciality check");
      return false;
    }
  }

  Future<bool> getProfile({required String email}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/profile/email/$email',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        profileData = profileFromJson(json.encode(response.data));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in profile api");
      return false;
    }
  }

//------------------------ Fetch Evaluation Form Details ---------------------

  Future<bool> getStudentEvaluation(
      {required String studentid, required int competencyid}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/competencyevaluations/competencyid/$competencyid/studentid/$studentid',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("updated");
      if (response.statusCode == 200) {
        studentEvaluation =
            studentEvaluationFromJson(json.encode(response.data));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in login check");
      return false;
    }
  }

  Future<bool> getEvaluationForm(
      {required int competencyevaluationid, required int competencyid}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/competencyevaluations/competencyid/$competencyid/competencyevaluationid/$competencyevaluationid',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        evaluationForm = EvaluationForm.fromJson(response.data);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in login check");
      return false;
    }
  }

//------------------------ View Submitted Evaluation Form ---------------------

  Future<bool> checkEvaluationForm(
      {required int competencyevaluationid, required int competencyid}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/competencyevaluations/facultyview/competencyid/$competencyid/competencyevaluationid/$competencyevaluationid',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        seeEvaluationForm = SeeEvaluationForm.fromJson(response.data);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in login check");
      return false;
    }
  }

  Future<bool> checkStudentEvaluationForm(
      {required int competencyevaluationid, required int competencyid}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/competencyevaluations/selfview/competencyid/$competencyid/competencyevaluationid/$competencyevaluationid',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        seeStudentEvaluation = SeeStudentEvaluation.fromJson(response.data);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("error in login check");
      return false;
    }
  }

//------------------------Create new row (Only Faculty) ----------------------
  Future<bool> createUser(
      {required String opnum,
      required String fmail,
      required int competencyid,
      required String studentid}) async {
    try {
      var formData = {"opnum": opnum, "fmail": fmail};
      Response response = await Dio().post(
        'https://api421.herokuapp.com/competencyevaluations/competencyid/$competencyid/studentid/$studentid/opnum',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'application/json', 'accept': '*/*'},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        bool k = await getStudentEvaluation(
            studentid: studentid, competencyid: competencyid);
        if (k) {
          //TODO Notification
          notifyListeners();
          return true;
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

//------------------------Submit the Form ------------------------------------

  Future<bool> submitEvaluationForm({
    required int competencyevaluationid,
    required var formData,
  }) async {
    try {
      Response response = await Dio().post(
        'https://api421.herokuapp.com/competencyevaluations/competencyevaluationid/$competencyevaluationid',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'application/json', 'accept': '*/*'},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> submitStudentEvaluationForm({
    required int competencyevaluationid,
    required var formData,
  }) async {
    try {
      Response response = await Dio().post(
        'https://api421.herokuapp.com/competencyevaluations/self/competencyevaluationid/$competencyevaluationid',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'application/json', 'accept': '*/*'},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

//----------------------- Faculty Todo ----------------------------------

  Future<bool> getOne2OneList({required String mail}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/facultytodo/meet/$mail',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        one2oneList = one2OneMeetFromJson(json.encode(response.data));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getReferenceList({required String mail}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/facultytodo/reference/$mail',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print(response);
      if (response.statusCode == 200) {
        print(response);
        referenceList = referenceNeededFromJson(json.encode(response.data));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> submitOne2One({required var formData}) async {
    try {
      Response response = await Dio().post(
        'https://api421.herokuapp.com/facultytodo/postmeet',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'application/json', 'accept': '*/*'},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        bool k = await getOne2OneList(mail: profileData.first.email);
        if (k) {
          notifyListeners();
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> submitReference({required var formData}) async {
    try {
      Response response = await Dio().post(
        'https://api421.herokuapp.com/facultytodo/postrefernce',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'application/json', 'accept': '*/*'},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        bool k = await getReferenceList(mail: profileData.first.email);
        if (k) {
          notifyListeners();
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

//----------------------- Student Todo ----------------------------------

  Future<bool> getOne2OneStudentList({required String mail}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/studenttodo/meet/$mail',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        one2oneStudentList =
            one2OneMeetStudentFromJson(json.encode(response.data));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getReferenceStudentList({required String mail}) async {
    try {
      Response response = await Dio().get(
        'https://api421.herokuapp.com/studenttodo/reference/$mail',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print(response);
      if (response.statusCode == 200) {
        referenceStudentList =
            referenceStudentListFromJson(json.encode(response.data));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
