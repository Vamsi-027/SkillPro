import 'dart:async';

import 'package:firstskillpro/Models/studentEvaluation.dart';
import 'package:firstskillpro/Services/api.dart';
import 'package:firstskillpro/screens/faculty/evaluationForm/eval_form.dart';
import 'package:firstskillpro/screens/faculty/evaluationForm/viewForm.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<GridColumn> getColumn() {
  return <GridColumn>[
    GridColumn(
      columnName: 'PatientOp',
      label: Container(
        color: primaryColor,
        alignment: Alignment.center,
        child:
            Text('PatientOp', style: GoogleFonts.poppins(color: Colors.white)),
      ),
    ),
    GridColumn(
      columnName: 'Date',
      label: Container(
        color: primaryColor,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text('Date', style: GoogleFonts.poppins(color: Colors.white)),
      ),
    ),
    GridColumn(
      columnName: 'Self',
      label: Container(
        color: primaryColor,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text('Self', style: GoogleFonts.poppins(color: Colors.white)),
      ),
    ),
    GridColumn(
      columnName: 'Faculty',
      label: Container(
        color: primaryColor,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          'Faculty',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    ),
  ];
}

class TableDetailsDataGridSource extends DataGridSource {
  TableDetailsDataGridSource(
      this.studentEvaluation, this.context, this.competencyid, this.studentID) {
    buildTableDataGridRow();
  }
  late List<StudentEvaluation> studentEvaluation;
  late BuildContext context;
  late List<DataGridRow> dataGridRows;
  late int competencyid;
  late Api obj;
  late String studentID;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    obj = Provider.of<Api>(context, listen: false);
    return DataGridRowAdapter(
      color: Colors.white,
      cells: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Center(
            child: Text(
              row.getCells()[0].value.toString(),
              textAlign: TextAlign.center,
              style: poppins,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Center(
            child: Text(
              row.getCells()[1].value.toString(),
              textAlign: TextAlign.center,
              style: poppins,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Center(
            child: TextButton(
              onPressed: obj.loginCheck!.role == 'student'
                  ? () {
                      if (row.getCells()[2].value.toString() == "0") {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => EvaluationForm(
                              competencyid: competencyid,
                              studentEvaluation: row.getCells()[4].value,
                              studentId: studentID,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                ViewEvaluationForm(
                              competencyid: competencyid,
                              studentEvaluation: row.getCells()[4].value,
                            ),
                          ),
                        );
                      }
                    }
                  : () {},
              child: Text(
                row.getCells()[2].value.toString() == "0"
                    ? "NA"
                    : row.getCells()[2].value.toString(),
                style: poppins,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Center(
            child: TextButton(
              onPressed: obj.loginCheck!.role == 'faculty'
                  ? () {
                      if (row.getCells()[3].value.toString() == "0") {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => EvaluationForm(
                              competencyid: competencyid,
                              studentEvaluation: row.getCells()[4].value,
                              studentId: studentID,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                ViewEvaluationForm(
                              competencyid: competencyid,
                              studentEvaluation: row.getCells()[4].value,
                            ),
                          ),
                        );
                      }
                    }
                  : () {},
              child: Text(
                row.getCells()[3].value.toString() == "0"
                    ? "NA"
                    : row.getCells()[3].value.toString(),
                style: poppins,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  void buildTableDataGridRow() {
    dataGridRows = studentEvaluation.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'PatientOp', value: dataGridRow.patientop),
        DataGridCell<String>(columnName: 'Date', value: dataGridRow.date),
        DataGridCell<int>(columnName: 'Self', value: dataGridRow.self),
        DataGridCell<int>(columnName: 'Faculty', value: dataGridRow.faculty),
        DataGridCell<StudentEvaluation>(columnName: "data", value: dataGridRow),
      ]);
    }).toList(growable: true);
  }
}

class DemoTable extends StatefulWidget {
  final int competencyid;
  final String studentid;
  const DemoTable(
      {Key? key, required this.competencyid, required this.studentid})
      : super(key: key);

  @override
  State<DemoTable> createState() => _DemoTableState();
}

class _DemoTableState extends State<DemoTable> {
  bool first = true;
  bool loading = true;
  late Api obj;

  bool submitLoading = false;
  TextEditingController opController = TextEditingController();

  void getData() async {
    bool k = await obj.getStudentEvaluation(
        studentid: widget.studentid, competencyid: widget.competencyid);
    print(k);
    if (k) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    obj = Provider.of<Api>(context);
    // first = true;
    if (first) {
      first = false;
      getData();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Competency Table"),
        backgroundColor: primaryColor,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 140,
                      width: MediaQuery.of(context).size.width,
                      child: SfDataGrid(
                        defaultColumnWidth:
                            MediaQuery.of(context).size.width / 4,
                        columnWidthMode: ColumnWidthMode.none,
                        columnWidthCalculationRange:
                            ColumnWidthCalculationRange.allRows,
                        gridLinesVisibility: GridLinesVisibility.vertical,
                        shrinkWrapColumns: true,
                        shrinkWrapRows: true,
                        verticalScrollPhysics: const BouncingScrollPhysics(),
                        allowSorting: true,
                        source: TableDetailsDataGridSource(
                          obj.studentEvaluation,
                          context,
                          widget.competencyid,
                          widget.studentid,
                        ),
                        columns: getColumn(),
                      ),
                    ),
                    obj.loginCheck!.role == 'faculty'
                        ? SizedBox(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      controller: opController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FloatingActionButton.extended(
                                    heroTag: opController.text,
                                    onPressed: submitLoading ||
                                            opController.text == ""
                                        ? null
                                        : () async {
                                            setState(() {
                                              submitLoading = true;
                                            });
                                            bool k = await obj.createUser(
                                              opnum: opController.text,
                                              fmail:
                                                  obj.profileData.first.email,
                                              competencyid: widget.competencyid,
                                              studentid: widget.studentid,
                                            );
                                            if (k) {
                                              setState(() {
                                                submitLoading = false;
                                                opController.text = "";
                                              });
                                            }
                                          },
                                    label: submitLoading
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : const Text('Add Row'),
                                    backgroundColor: primaryColor,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
    );
  }
}
