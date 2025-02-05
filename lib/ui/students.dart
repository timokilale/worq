import 'package:attendance/models/student.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/ui/student_details.dart';
import 'package:attendance/ui/widgets/common/header.dart';
import 'package:attendance/ui/widgets/common/sf_grid.dart';
import 'package:attendance/ui/widgets/data_grid/student_data_source.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:attendance/utils/app_colors.dart';
import 'package:attendance/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:attendance/ui/home.dart';
import 'package:attendance/ui/settings.dart';
import 'package:attendance/ui/finger_scan_active.dart';
import 'package:attendance/ui/widgets/common/custom_icon.dart';

final _locator = GetIt.I;

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  List<Student> students = <Student>[];
  late StudentDataSource studentDataSource;
  List<Student> filteredStudents = <Student>[];
  int currentPage = 1;
  int studentsPerPage = 10;
  String searchQuery = '';
  final currentYear = DateTime.now().year;

  String selectedClassLevel = 'All';
  String selectedAcademicYear = 'All';
  String selectedClass = 'All';
  String selectedSection = 'All';
  String selectedEnrollmentStatus = 'All';
  //String selectedClass = 'All';
  //String selectedAcademicYear = 'All';

  @override
  void initState() {
    super.initState();
    students = _locator<LoginRepository>().getLoginResponse().students;
    filteredStudents = students;
    studentDataSource = StudentDataSource(students: getPaginatedStudents());
  }

  void applyFilters() {
    setState(() {
      filteredStudents = students.where((student) {
        // Search across multiple fields
        bool matchesSearch = searchQuery.isEmpty ||
            student.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            student.roll.toLowerCase().contains(searchQuery.toLowerCase()) ||
            student.studentId.toString().contains(searchQuery);

        // Dropdown filters using exact model properties
        bool matchesClassLevel = selectedClassLevel == 'All' ||
            student.classLevel == selectedClassLevel;

        bool matchesAcademicYear = selectedAcademicYear == 'All' ||
            student.academicYear == selectedAcademicYear;

        bool matchesClass = selectedClass == 'All' ||
            student.className == selectedClass;

        bool matchesSection = selectedSection == 'All' ||
            student.section == selectedSection;

        bool matchesEnrollmentStatus = selectedEnrollmentStatus == 'All' ||
            student.enrollmentStatus == selectedEnrollmentStatus;

        // Combine all filters
        return matchesSearch &&
            matchesClassLevel &&
            matchesAcademicYear &&
            matchesClass &&
            matchesSection &&
            matchesEnrollmentStatus;
      }).toList();

      currentPage = 1;
      studentDataSource = StudentDataSource(students: getPaginatedStudents());
    });
  }

  int getTotalPages() {
    return (filteredStudents.length / studentsPerPage).ceil();
  }

  List<Student> getPaginatedStudents() {
    int startIndex = (currentPage - 1) * studentsPerPage;
    int endIndex = startIndex + studentsPerPage;
    if (endIndex > filteredStudents.length) endIndex = filteredStudents.length;
    return filteredStudents.sublist(startIndex, endIndex);
  }

  void goToPage(int page) {
    setState(() {
      currentPage = page;
      studentDataSource = StudentDataSource(students: getPaginatedStudents());
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> years = List.generate(4, (index) => (currentYear - index).toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(int.parse(AppColors.tableHeaderLightGrey)),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
        FocusScope.of(context).unfocus();
        },
        child: Row(
          children: [
            IgnorePointer(
              ignoring: false,
              child: Container(
                width: 88,
                height: 960,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 60,
                      color: const Color(0xFFE2ECF9).withOpacity(0.5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 120),
                        child: GestureDetector(
                          onTap: () => navigate(context, const Home()),
                          child: Container(
                            width: 42.0,
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(Icons.arrow_back, size: 30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: GestureDetector(
                          onTap: () => navigate(context, const Settings()),
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(int.parse(AppColors.primary)),
                              ),
                            ),
                            child: Center(
                              child: Icon(Icons.settings, size: 30, color: Color(int.parse(AppColors.primary)),),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: GestureDetector(
                          onTap: () => navigate(context, const FingerScanActive()),
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(int.parse(AppColors.primary)),
                              ),
                            ),
                            child: const Center(
                              child: CustomIcon(icon: 'qr.png', size: 30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              width: 1352,
                              height: 54,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Header()
                                ],
                              ),
                            )
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: Row(
                                            children: [
                                              Container(
                                                width: 170,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(5),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFE5E5E5), width: 0.5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.02),
                                                      offset: const Offset(0, 4),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Opacity(
                                                      opacity: 0.7,
                                                      child: Icon(Icons.search),
                                                    ),
                                                    hintText: 'Search...',
                                                    hintStyle: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      color: const Color(0xFF1DB899)
                                                          .withOpacity(0.3),
                                                    ),
                                                    border: InputBorder.none,
                                                    contentPadding: const EdgeInsets
                                                        .symmetric(horizontal: 12),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      searchQuery = value;
                                                      applyFilters();
                                                    });
                                                  },
                                                ),
                                              ),

                                              // Class Level Dropdown:
                                              Container(
                                                width: 150,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(5),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFE5E5E5), width: 0.5),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                child: DropdownButton<String>(
                                                  value: selectedClassLevel,
                                                  isExpanded: true,
                                                  underline: const SizedBox(),
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: const Color(0xFF1DB899)
                                                        .withOpacity(0.8),
                                                  ),
                                                  items: [
                                                    DropdownMenuItem<String>(
                                                      value: 'All',
                                                      child: Text('Class Level'),
                                                    ),
                                                    ...['O-level', 'A-level'].map((
                                                        String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ],
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      selectedClassLevel =
                                                      newValue!;
                                                      applyFilters();
                                                    });
                                                  },
                                                ),
                                              ),

                                              // Academic Year Dropdown:
                                              Container(
                                                width: 190,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(5),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFE5E5E5), width: 0.5),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                child: DropdownButton<String>(
                                                  value: selectedAcademicYear,
                                                  isExpanded: true,
                                                  underline: const SizedBox(),
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: const Color(0xFF1DB899)
                                                        .withOpacity(0.8),
                                                  ),
                                                  items: [
                                                    DropdownMenuItem<String>(
                                                      value: 'All',
                                                      child: Text('Academic Year'),
                                                    ),
                                                    ...years.map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ],
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      selectedAcademicYear =
                                                      newValue!;
                                                      applyFilters();
                                                    });
                                                  },
                                                ),
                                              ),

                                              // Class Dropdown:
                                              Expanded(
                                                child:
                                                Container(
                                                  width: 107,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(5),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFE5E5E5),
                                                        width: 0.5),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 12),
                                                  child: DropdownButton<String>(
                                                    value: selectedClass,
                                                    isExpanded: true,
                                                    underline: const SizedBox(),
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      color: const Color(0xFF1DB899)
                                                          .withOpacity(0.8),
                                                    ),
                                                    items: [
                                                      DropdownMenuItem<String>(
                                                        value: 'All',
                                                        child: Text('Class'),
                                                      ),
                                                      ...[
                                                        'Form One',
                                                        'Form Two',
                                                        'Form Three',
                                                        'Form Four'
                                                      ].map((String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ],
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        selectedClass = newValue!;
                                                        applyFilters();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            ]
                                        )
                                    )
                                  ]
                              ),
                              // Total students display
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 4.0),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        //decoration: TextDecoration.underline,
                                                        //decorationColor: Colors.deepOrangeAccent,
                                                        //decorationStyle: TextDecorationStyle.solid,
                                                        //decorationThickness: 2.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'ALL ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: '${filteredStudents
                                                              .length}',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .deepOrangeAccent,
                                                            backgroundColor: Colors
                                                                .orange[100],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: -1,
                                                // Adjust vertical position of the underline
                                                child: Container(
                                                  height: 2.0,
                                                  color: Colors
                                                      .deepOrangeAccent, // Color of the underline
                                                ),
                                              ),
                                            ]
                                        )

                                    ),
                                    const SizedBox(height: 4),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Showing ${((currentPage - 1) *
                                          studentsPerPage) + 1}-${(currentPage *
                                          studentsPerPage) > filteredStudents.length
                                          ? filteredStudents.length
                                          : currentPage *
                                          studentsPerPage} of ${filteredStudents
                                          .length}'),
                                    ),
                                  ],
                                ),
                              ),
                              // Table
                              Flexible(
                                child: SfDataGridTheme(data: SfDataGridThemeData(
                                  headerColor: Colors.grey[300],
                                  gridLineColor: Color(
                                      int.parse(AppColors.tableHeaderLightGrey)),
                                  gridLineStrokeWidth: 1.0,
                                ),
                                  child: SfDataGrid(
                                    source: studentDataSource,
                                    onQueryRowHeight: (details) => 42.0,
                                    columnWidthMode: ColumnWidthMode.fill,
                                    onCellTap: (details) {
                                      if (details.rowColumnIndex.rowIndex != 0) {
                                        final DataGridRow row = studentDataSource
                                            .effectiveRows[details.rowColumnIndex
                                            .rowIndex - 1];
                                        Student student = _locator<
                                            LoginRepository>().getStudent(
                                            row.getCells()[0].value);

                                        if (equalsIgnoreCase(
                                            student.enrollmentStatus, 'Pending')) {
                                          navigate(context,
                                              StudentDetails(student: student));
                                        } else if (equalsIgnoreCase(
                                            student.enrollmentStatus, 'Enrolled')) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Already enrolled')),
                                          );
                                        }
                                      }
                                    },

                                    columns: <GridColumn>[
                                      sfGridColumn('id', 'REF NO'),
                                      sfGridColumn('name', 'NAME'),
                                      sfGridColumn('roll', 'ROLL/REG NO'),
                                      sfGridColumn('sex', 'GENDER'),
                                      sfGridColumn('status', 'STATUS'),
                                    ],
                                  ),
                                ),
                              ),
                              // Pagination
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Previous page button
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.chevron_left,
                                          color: currentPage > 1
                                              ? const Color(0xFF233253).withOpacity(
                                              0.4)
                                              : Colors.grey.withOpacity(0.2),
                                        ),
                                        onPressed: currentPage > 1
                                            ? () {
                                          setState(() {
                                            currentPage--;
                                            studentDataSource = StudentDataSource(
                                                students: getPaginatedStudents());
                                          });
                                        }
                                            : null,
                                      ),
                                    ),

                                    // Page Numbers
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          // First page
                                          _buildPageNumber(1),

                                          // Show first few pages
                                          if (currentPage > 3) _buildEllipsis(),

                                          // Pages around current page
                                          ...List.generate(
                                              5,
                                                  (index) {
                                                int pageNumber = currentPage - 2 +
                                                    index;
                                                if (pageNumber > 1 &&
                                                    pageNumber < getTotalPages()) {
                                                  return _buildPageNumber(
                                                      pageNumber);
                                                }
                                                return const SizedBox.shrink();
                                              }
                                          )
                                              .where((widget) =>
                                          widget != const SizedBox.shrink())
                                              .toList(),

                                          // Ellipsis before last page
                                          if (currentPage <
                                              getTotalPages() - 2) _buildEllipsis(),

                                          // Last page
                                          _buildPageNumber(getTotalPages()),
                                        ],
                                      ),
                                    ),

                                    // Next page button
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.chevron_right,
                                          color: currentPage < getTotalPages()
                                              ? const Color(0xFF233253).withOpacity(
                                              0.4)
                                              : Colors.grey.withOpacity(0.2),
                                        ),
                                        onPressed: currentPage < getTotalPages()
                                            ? () {
                                          setState(() {
                                            currentPage++;
                                            studentDataSource = StudentDataSource(
                                                students: getPaginatedStudents());
                                          });
                                        }
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _buildPageNumber(int pageNumber) {
    bool isCurrentPage = currentPage == pageNumber;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          setState(() {
            currentPage = pageNumber;
            studentDataSource = StudentDataSource(students: getPaginatedStudents()); // Update data source
          });
        },
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: isCurrentPage
                ? const Color(0xFFF6AD2B).withOpacity(0.7)  // Highlighted color
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '$pageNumber',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: isCurrentPage
                    ? Colors.white
                    : const Color(0xFF233253).withOpacity(0.4),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '...',
        style: TextStyle(
          color: const Color(0xFF233253).withOpacity(0.4),
        ),
      ),
    );
  }
}