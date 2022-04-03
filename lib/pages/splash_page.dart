import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import 'pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Future<User?> loadedPage;

  @override
  void initState() {
    super.initState();
    loadedPage =
        Provider.of<UserProvider>(context, listen: false).checkAuthorization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadedPage,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _navigateToPage();
          } else {
            return _loadWidget();
          }
        },
      ),
    );
  }

  _navigateToPage() {
    Timer(const Duration(seconds: 1), () async {
      var user = await loadedPage;
      if (user != null) {
        NavigationService.pushAndRemoveUntil(context, const HomePage());
      } else {
        NavigationService.pushAndRemoveUntil(context, const LoginPage());
      }
    });
    return _loadWidget();
  }

  Widget _loadWidget() {
    return const Center(child: CircularProgressIndicator());
  }
}
