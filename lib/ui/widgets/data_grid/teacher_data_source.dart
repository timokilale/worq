import 'package:attendance/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TeacherDataSource extends DataGridSource {
  TeacherDataSource({required List<Teacher> teachers}) {
    _teachers = teachers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.teacherID),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'sex', value: e.sex),
              DataGridCell<String>(
                  columnName: 'status', value: e.enrollmentStatus),
            ]))
        .toList();
  }

  List<DataGridRow> _teachers = [];

  @override
  List<DataGridRow> get rows => _teachers;

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
