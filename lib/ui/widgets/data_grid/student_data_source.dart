import 'package:flutter/material.dart';
import 'package:attendance/models/student.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StudentDataSource extends DataGridSource {
  StudentDataSource({required List<Student> students}) {
    _students = students
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.studentId),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'roll', value: e.roll),
              DataGridCell<String>(columnName: 'sex', value: e.sex),
              DataGridCell<String>(
                  columnName: 'status', value: e.enrollmentStatus),
            ]))
        .toList();
  }

  List<DataGridRow> _students = [];

  @override
  List<DataGridRow> get rows => _students;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      TextStyle? getTextStyle() {
        if (e.columnName == 'status') {
          return TextStyle(
            fontSize: 10.0,
            color: e.value == 'Enrolled' ? Colors.green : Colors.red,
          );
        } else {
          return const TextStyle(fontSize: 10.0);
        }
      }

      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          style: getTextStyle(),
        ),
      );
    }).toList());
  }
}
