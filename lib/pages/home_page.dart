import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veterinary_clinic_mobile/models/models.dart';

import '../constants.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future loadedPage;

  @override
  void initState() {
    super.initState();
    loadedPage =
        Provider.of<CheckupProvider>(context, listen: false).getAllCheckups();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: FutureBuilder(
          future: loadedPage,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done &&
                    snapshot.data == true
                ? RefreshIndicator(
                    onRefresh: () async {
                      await Provider.of<CheckupProvider>(context, listen: false)
                          .getAllCheckups();
                    },
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Consumer<CheckupProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: size.height * .35,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          ancientColor,
                                          Color(0xFF0B9FF5),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: SafeArea(
                                      child: Positioned(
                                        right: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.2),
                                            border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(.5),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(360),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: IconButton(
                                              onPressed: () {
                                                NavigationService.push(
                                                  context,
                                                  const UserPage(),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.person,
                                                size: 32,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 1,
                                    left: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 25,
                                      ),
                                      child: Text(
                                        "Личный кабинет врача",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * .42,
                                          child: RoundedContainerWidget(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    provider.totalCheckupsCount
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: ancientColor,
                                                      fontSize: 34,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    "Всего предстоящих записей",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: lineColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * .42,
                                          child: RoundedContainerWidget(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    provider.todayCheckupsCount
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: ancientColor,
                                                      fontSize: 34,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    "Записей на сегодня\n",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: lineColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Divider(color: lineColor),
                                    ),
                                    const TabBar(
                                      tabs: [
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            "Текущие записи",
                                            style:
                                                TextStyle(color: ancientColor),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            "Прошедшие записи",
                                            style:
                                                TextStyle(color: ancientColor),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: size.height * 2,
                                      child: TabBarView(
                                        children: [
                                          Expanded(
                                            child: _generateWidgets(
                                              provider.activeCheckups,
                                            ),
                                          ),
                                          Expanded(
                                            child: _generateWidgets(
                                              provider.historyCheckups,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _generateWidgets(List<Checkup> checkups) {
    var widgets = <Widget>[];
    for (var checkup in checkups) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PreviewCardWidget(checkup: checkup),
        ),
      );
    }
    return Column(children: widgets);
  }
}
