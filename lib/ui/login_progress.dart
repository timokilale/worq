import 'package:attendance/models/login.dart';
import 'package:attendance/repositories/login_repository.dart';
import 'package:attendance/ui/home.dart';
import 'package:attendance/ui/login_screen.dart';
import 'package:attendance/utils/actions/common_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../blocs/bloc_exports.dart';

final _locator = GetIt.I;

class LoginProgress extends StatefulWidget {
  const LoginProgress({super.key, required this.login});

  final Login login;

  @override
  State<LoginProgress> createState() => _LoginProgressState();
}

class _LoginProgressState extends State<LoginProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  String _statusText = 'Data sync in progress...';
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          if (_progressAnimation.value < 0.5) {
            _statusText = 'Syncing Data.....';
          } else if (_progressAnimation.value < 0.9) {
            _statusText = 'Wait a bit.....';
          }
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isComplete = true;
          });
        }
      });

    _startSync();
  }

  void _startSync() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc()..add(DoLogin(widget.login)),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoaded) {
                _locator<LoginRepository>().storeLoginResponse(state.response);
                Navigator.of(context).pop();
                navigate(context, const Home());
              } else if (state is LoginError) {
                Navigator.of(context).pop();
                navigate(context, const LoginScreen());
              }
            },
            child: Center(
              child: _isComplete ? _buildCompleteView() : _buildProgressView(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _statusText,
          style: const TextStyle(
            color: Color(0xFF1DB899),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _progressAnimation.value,
              backgroundColor: Colors.grey[300],
              valueColor:
              const AlwaysStoppedAnimation<Color>(Color(0xFF1DB899)),
              minHeight: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF1DB899),
          ),
          child: const Icon(
            Icons.check,
            size: 80,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Data Sync Complete',
          style: TextStyle(
            color: Color(0xFF1DB899),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),

      ],
    );
  }
}
