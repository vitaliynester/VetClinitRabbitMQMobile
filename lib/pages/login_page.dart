import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text(
                      'Vet',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 36,
                        color: ancientColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      'clinic'.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 36,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 75),
              CustomTextfieldWidget(
                controller: emailController,
                onTap: () {},
                prefixIcon: const Icon(Icons.person),
                suffixIcon: null,
                hintText: "Логин",
                obscureText: false,
              ),
              const SizedBox(height: 15),
              CustomTextfieldWidget(
                controller: passwordController,
                onTap: () {},
                prefixIcon: const Icon(Icons.key),
                suffixIcon: null,
                hintText: "Пароль",
                obscureText: true,
              ),
              const SizedBox(height: 50),
              CustomElevatedButtonWidget(
                onPressed: () async {
                  if (emailController.text.trim().isEmpty) {
                    UtilService.showSnackBar(context, "Укажите логин!");
                    return;
                  }
                  if (passwordController.text.trim().isEmpty) {
                    UtilService.showSnackBar(context, "Укажите пароль!");
                    return;
                  }
                  var service = UserService();
                  var result = await service.authorizeUser(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  if (result) {
                    var user = await service.getUser();
                    Provider.of<UserProvider>(context, listen: false)
                        .updateUser(user!);
                    NavigationService.pushAndRemoveUntil(
                      context,
                      const HomePage(),
                    );
                    return;
                  }
                  UtilService.showSnackBar(
                    context,
                    "Не удалось авторизоваться!",
                  );
                },
                text: "Войти",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
