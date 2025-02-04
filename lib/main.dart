import 'dart:async';
import 'dart:io';

import 'package:attendance/database/hive/storage_keys.dart';
import 'package:attendance/models/academic_year.dart';
import 'package:attendance/models/class.dart';
import 'package:attendance/models/class_level.dart';
import 'package:attendance/models/dashboard_summary.dart';
import 'package:attendance/models/enrollment_option.dart';
import 'package:attendance/models/login_response.dart';
import 'package:attendance/models/student.dart';
import 'package:attendance/models/supporting_staff.dart';
import 'package:attendance/models/teacher.dart';
import 'package:attendance/models/user_attendance.dart';
import 'package:attendance/repositories/user_attendance_repository.dart';
import 'package:attendance/services/service_locator.dart';
import 'package:attendance/ui/login_screen.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/bloc_exports.dart';

final _locator = GetIt.I;

const platformMethodChannel =
    MethodChannel('africa.shulesoft.attendance/device-sdk');

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load(fileName: '.env');
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.registerAdapter(LoginResponseAdapter());
  Hive.registerAdapter(DashboardSummaryAdapter());
  Hive.registerAdapter(ClassLevelAdapter());
  Hive.registerAdapter(ClassAdapter());
  Hive.registerAdapter(AcademicYearAdapter());
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(EnrollmentOptionAdapter());
  Hive.registerAdapter(TeacherAdapter());
  Hive.registerAdapter(SupportingStaffAdapter());
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox(StorageKeys.attendanceBox);
  HttpOverrides.global = MyHttpOverrides();
  serviceLocatorInit();
  runApp(const Attendance());
}

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      initFingerprintDevice(platformMethodChannel);
    });

    Timer.periodic(const Duration(minutes: 60), (timer) async {
      List<UserAttendance>? attendances =
          await _locator<UserAttendanceRepository>().getStoredUserAttendances();
      if (attendances != null) {
        List<UserAttendance> filtered =
            attendances.where((item) => item.synchronized != true).toList();
        for (UserAttendance attendance in filtered) {
          await _locator<UserAttendanceRepository>()
              .registerAttendance(attendance)
              .then((response) async {
            await _locator<UserAttendanceRepository>()
                .updateUserAttendance(attendance);
          });
        }
      }
    });

    Timer.periodic(const Duration(minutes: 60), (timer) async {
      await _locator<UserAttendanceRepository>().deleteUserAttendance(true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<AttendanceBloc>(create: (context) => AttendanceBloc()),
        BlocProvider<EnrollmentBloc>(create: (context) => EnrollmentBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0.4,
          ),
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(surface: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
