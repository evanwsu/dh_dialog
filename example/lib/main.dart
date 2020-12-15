// import 'package:dh_dialog/dh_dialog.dart';
import 'package:dh_dialog/dh_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  showDHDialog(
                      context: context,
                      builder: (context) {
                        return DHAlertDialog(
                          titleText: "确定要删除设备吗",
                          contentText: "删除设备后，需要重新配网才能控制设备",
                          hasPositive: true,
                          hasNegative: false,
                          positiveTap: () {
                            Navigator.pop(context);
                          },
                          negativeTap: () {},
                        );
                      },
                      entryAnimation: EntryAnimation.slideBottom);
                },
                child: Text("Title Content Action")),
            FlatButton(
                onPressed: () {
                  showDHDialog(
                      context: context,
                      builder: (context) {
                        return DHAlertDialog(
                          contentText: "jimmy",
                          positiveText: "确认",
                          negativeText: "取消",
                        );
                      },
                      entryAnimation: EntryAnimation.fade);
                },
                child: Text("Title Content Action")),
            FlatButton(
                onPressed: () {
                  showDHDialog(
                      entryAnimation: EntryAnimation.slideBottom,
                      context: context,
                      builder: (context) {
                        return DHListDialog(
                          titleText: "班级",
                          datas: [
                            DialogListItem(text: "高一(1)班", data: "1"),
                            DialogListItem(text: "高一(2)班", data: "2"),
                            DialogListItem(text: "高一(3)班", data: "3"),
                          ],
                          titleAlign: TextAlign.center,
                          itemAlignment: Alignment.topLeft,
                          // hasNegative: false,
                          hasPositive: false,
                          itemClickListener: (data, position){
                            print('data: $data, position: $position');
                          },
                        );
                      });
                },
                child: Text("List Dialog"))
          ],
        ),
      ),
    );
  }
}
