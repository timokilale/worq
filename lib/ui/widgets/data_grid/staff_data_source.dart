import 'package:attendance/models/supporting_staff.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StaffDataSource extends DataGridSource {
  StaffDataSource({required List<SupportingStaff> staffs}) {
    _staffs = staffs
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.userID),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'sex', value: e.sex),
              DataGridCell<String>(
                  columnName: 'status', value: e.enrollmentStatus),
            ]))
        .toList();
  }

  List<DataGridRow> _staffs = [];

  @override
  List<DataGridRow> get rows => _staffs;

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
