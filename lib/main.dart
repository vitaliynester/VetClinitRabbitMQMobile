import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'pages/pages.dart';
import 'providers/providers.dart';
import 'services/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

  var rabbit = RabbitMQService();
  await rabbit.init(
    rabbitChannelUrl,
    rabbitPort,
    rabbitVHost,
    rabbitLogin,
    rabbitPassword,
    rabbitQueueName,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CheckupProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFBFCFF),
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(color: lineColor),
            iconTheme: const IconThemeData(color: secondaryTextColor),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                color: ancientColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                color: lineColor,
                width: 2,
              ),
            ),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ancientColor,
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
