import 'dart:async';

import 'package:firstskillpro/Models/competencyDetails.dart';
import 'package:firstskillpro/Services/api.dart';
import 'package:firstskillpro/screens/faculty/dashboard/demo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../utils/styling.dart';
import 'package:firstskillpro/utils/styling.dart';

//GridView to display the data as table
List<GridColumn> getColumn() {
  return <GridColumn>[
    GridColumn(
      columnName: 'RegNo',
      label: Container(
        color: primaryColor,
        alignment: Alignment.center,
        child: Text('RegNo', style: GoogleFonts.poppins(color: Colors.white)),
      ),
    ),
    GridColumn(
      columnName: 'Name',
      label: Container(
        color: primaryColor,
        alignment: Alignment.center,
        child: Text('Name', style: GoogleFonts.poppins(color: Colors.white)),
      ),
    ),
    GridColumn(
      columnName: 'Self',
      label: Container(
        color: primaryColor,
        alignment: Alignment.center,
        child: Text('Self', style: GoogleFonts.poppins(color: Colors.white)),
      ),
    ),
    GridColumn(
      columnName: 'Faculty',
      label: Container(
        color: primaryColor,
        alignment: Alignment.center,
        child: Text(
          'Faculty',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    ),
  ];
}

class CompetenciesDataGridSource extends DataGridSource {
  CompetenciesDataGridSource(
      this.competencyDetails, this.context, this.competencyID) {
    buildDataGridRow();
  }
  late List<CompetencyDetails> competencyDetails;
  late List<DataGridRow> dataGridRows;
  late BuildContext context;
  late int competencyID;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: Colors.white,
      cells: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => DemoTable(
                    competencyid: competencyID,
                    studentid: row.getCells()[0].value,
                  ),
                ),
              );
            },
            child: Text(
              row.getCells()[0].value,
              style: poppins,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            row.getCells()[1].value,
            style: poppins,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            row.getCells()[2].value.toString() == "0"
                ? "NA"
                : row.getCells()[2].value.toString(),
            style: poppins,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            row.getCells()[3].value.toString() == "0"
                ? "NA"
                : row.getCells()[3].value.toString(),
            style: poppins,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  void buildDataGridRow() {
    dataGridRows = competencyDetails.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'RegNo', value: dataGridRow.regno),
        DataGridCell<String>(columnName: 'Name', value: dataGridRow.name),
        DataGridCell<int>(columnName: 'Self', value: dataGridRow.self),
        DataGridCell<int>(columnName: 'Faculty', value: dataGridRow.faculty),
      ]);
    }).toList(growable: true);
  }
}

class CompetencydetailsScreen extends StatefulWidget {
  final int competencyID;
  const CompetencydetailsScreen({Key? key, required this.competencyID})
      : super(key: key);

  @override
  State<CompetencydetailsScreen> createState() =>
      _CompetencydetailsScreenState();
}

class _CompetencydetailsScreenState extends State<CompetencydetailsScreen> {
  bool first = true;
  bool loading = true;
  late Api obj;
  void getData() async {
    bool k = await obj.getCompetencyDetailsList(
        speciality: obj.specialityCheck!.details.speciality,
        competencyid: widget.competencyID);
    if (k) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  late String title;

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 3), (timer) {
    //   getData();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    obj = Provider.of<Api>(context);
    if (first) {
      first = false;
      getData();
      title = obj.competencyList!.details!
          .where((e) => e.competencyid == widget.competencyID)
          .toList()
          .first
          .competencyname;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        backgroundColor: primaryColor,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SfDataGrid(
                defaultColumnWidth: MediaQuery.of(context).size.width / 4,
                columnWidthMode: ColumnWidthMode.none,
                columnWidthCalculationRange:
                    ColumnWidthCalculationRange.allRows,
                gridLinesVisibility: GridLinesVisibility.vertical,
                shrinkWrapColumns: true,
                shrinkWrapRows: true,
                verticalScrollPhysics: const BouncingScrollPhysics(),
                allowSorting: true,
                source: CompetenciesDataGridSource(
                  obj.competencyDetailsList,
                  context,
                  widget.competencyID,
                ),
                columns: getColumn(),
              ),
            ),
    );
  }
}
