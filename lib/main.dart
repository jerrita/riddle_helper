import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/helper.dart';
import 'view_models/organ_view_model.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => OrganViewModel())],
    child: MyApp()));

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Genshin Helper',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: RiddleHelper(),
    );
  }
}
