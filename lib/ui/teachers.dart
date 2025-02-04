import 'package:attendance/models/teacher.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/ui/teacher_details.dart';
import 'package:attendance/ui/widgets/common/header.dart';
import 'package:attendance/ui/widgets/common/sf_grid.dart';
import 'package:attendance/ui/widgets/data_grid/teacher_data_source.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:attendance/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final _locator = GetIt.I;

class Teachers extends StatefulWidget {
  const Teachers({super.key});

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  List<Teacher> teachers = <Teacher>[];
  late TeacherDataSource teacherDataSource;

  @override
  void initState() {
    super.initState();
    teachers = _locator<LoginRepository>().getLoginResponse().teachers;
    teacherDataSource = TeacherDataSource(teachers: teachers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Header(),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(8.0),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: Color(
                      int.parse(AppColors.tableHeaderLightGrey),
                    ),
                    gridLineColor:
                        Color(int.parse(AppColors.tableHeaderLightGrey)),
                    gridLineStrokeWidth: 1.0,
                  ),
                  child: SfDataGrid(
                    source: teacherDataSource,
                    onQueryRowHeight: (details) => 42.0,
                    columnWidthMode: ColumnWidthMode.fill,
                    onCellTap: (details) {
                      if (details.rowColumnIndex.rowIndex != 0) {
                        final DataGridRow row = teacherDataSource
                            .effectiveRows[details.rowColumnIndex.rowIndex - 1];

                        Teacher teacher = _locator<LoginRepository>()
                            .getTeacher(row.getCells()[0].value);

                        if (equalsIgnoreCase(
                            teacher.enrollmentStatus, 'Pending')) {
                          navigate(context, TeacherDetails(teacher: teacher));
                        } else if (equalsIgnoreCase(
                            teacher.enrollmentStatus, 'Enrolled')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Already enrolled')),
                          );
                        }
                      }
                    },
                    columns: <GridColumn>[
                      sfGridColumn('id', 'REF NO'),
                      sfGridColumn('name', 'NAME'),
                      sfGridColumn('sex', 'GENDER'),
                      sfGridColumn('status', 'STATUS'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
