import 'package:attendance/models/supporting_staff.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/ui/staff_details.dart';
import 'package:attendance/ui/widgets/common/header.dart';
import 'package:attendance/ui/widgets/common/sf_grid.dart';
import 'package:attendance/ui/widgets/data_grid/staff_data_source.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:attendance/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final _locator = GetIt.I;

class Staffs extends StatefulWidget {
  const Staffs({super.key});

  @override
  State<Staffs> createState() => _StaffsState();
}

class _StaffsState extends State<Staffs> {
  List<SupportingStaff> staffs = <SupportingStaff>[];
  late StaffDataSource staffDataSource;

  @override
  void initState() {
    super.initState();
    staffs = _locator<LoginRepository>().getLoginResponse().supportingStaffs;
    staffDataSource = StaffDataSource(staffs: staffs);
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
                    source: staffDataSource,
                    onQueryRowHeight: (details) => 42.0,
                    columnWidthMode: ColumnWidthMode.fill,
                    onCellTap: (details) {
                      if (details.rowColumnIndex.rowIndex != 0) {
                        final DataGridRow row = staffDataSource
                            .effectiveRows[details.rowColumnIndex.rowIndex - 1];

                        SupportingStaff staff = _locator<LoginRepository>()
                            .getStaff(row.getCells()[0].value);

                        if (equalsIgnoreCase(
                            staff.enrollmentStatus, 'Pending')) {
                          navigate(context, StaffDetails(staff: staff));
                        } else if (equalsIgnoreCase(
                            staff.enrollmentStatus, 'Enrolled')) {
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
