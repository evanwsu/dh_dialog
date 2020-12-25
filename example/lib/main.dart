import 'package:dh_dialog/dh_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    List<DialogListItem> weeks = <DialogListItem>[
      DialogListItem<ChoiceItem, String>(
          ChoiceItem(
              imgWidth: 22,
              imgHeight: 22,
              text: Selected.all("星期天"),
              image: Selected.normal(
                  normal: '$imagePathPrefix/check_nor.png',
                  active: '$imagePathPrefix/check_sel.png'),
              selected: false),
          data: "0"),
      DialogListItem<ChoiceItem, String>(
          ChoiceItem(
              imgWidth: 22,
              imgHeight: 22,
              text: Selected.all("星期一"),
              image: Selected.normal(
                  normal: '$imagePathPrefix/check_nor.png',
                  active: '$imagePathPrefix/check_sel.png'),
              selected: false),
          data: "1"),
      DialogListItem<ChoiceItem, String>(
          ChoiceItem(
              imgWidth: 22,
              imgHeight: 22,
              text: Selected.all("星期二"),
              image: Selected.normal(
                  normal: '$imagePathPrefix/check_nor.png',
                  active: '$imagePathPrefix/check_sel.png'),
              selected: false),
          data: "2"),
      DialogListItem<ChoiceItem, String>(
          ChoiceItem(
              imgWidth: 22,
              imgHeight: 22,
              text: Selected.all("星期三"),
              textStyle: Selected.normal(
                  normal: TextStyle(color: Colors.black, fontSize: 12),
                  active: TextStyle(color: Colors.red, fontSize: 14)),
              image: Selected.normal(
                  normal: '$imagePathPrefix/check_nor.png',
                  active: '$imagePathPrefix/check_sel.png'),
              selected: false),
          data: "3"),
      DialogListItem<ChoiceItem, String>(
          ChoiceItem(
              imgWidth: 22,
              imgHeight: 22,
              text: Selected.all("星期四"),
              image: Selected.normal(
                  normal: '$imagePathPrefix/check_nor.png',
                  active: '$imagePathPrefix/check_sel.png'),
              selected: false),
          data: "4"),
      DialogListItem<ChoiceItem, String>(
          ChoiceItem(
              imgWidth: 22,
              imgHeight: 22,
              text: Selected.all("星期五"),
              image: Selected.normal(
                  normal: '$imagePathPrefix/check_nor.png',
                  active: '$imagePathPrefix/check_sel.png'),
              selected: false),
          data: "5"),
      DialogListItem<ChoiceItem, String>(
          ChoiceItem(
              imgWidth: 22,
              imgHeight: 22,
              text: Selected.all("星期六"),
              image: Selected.normal(
                  normal: '$imagePathPrefix/check_nor.png',
                  active: '$imagePathPrefix/check_sel.png'),
              selected: false),
          data: "6"),
    ];

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
                          actionDividerBuilder: (context, type) {
                            return Container(
                              color: Colors.purple,
                              height:
                                  type == DividerType.horizontal ? 1.0 : null,
                              width: type == DividerType.vertical ? 1.0 : null,
                            );
                          },
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
                          titleAlign: TextAlign.center,
                          datas: [
                            DialogListItem<TextItem, String>(
                                TextItem(text: "高一(1)班"),
                                data: "1"),
                            DialogListItem<TextItem, String>(
                                TextItem(text: "高一(2)班"),
                                data: "2"),
                            DialogListItem<TextItem, String>(
                                TextItem(text: "高一(3)班"),
                                data: "3"),
                          ],
                          itemAlignment: Alignment.centerLeft,
                          // hasNegative: false,
                          // hasPositive: false,
                          itemClickListener: (data, position, context) {
                            print('data: $data, position: $position');
                            Navigator.of(context).pop();
                          },
                          dividerColor: Colors.yellow,
                          itemDividerBuilder: (context, index) {
                            return Container(
                              color: Colors.red,
                              height: 1.0,
                            );
                          },
                          actionDividerBuilder: (context, type) {
                            return Container(
                              color: Colors.purple,
                              height:
                                  type == DividerType.horizontal ? 1.0 : null,
                              width: type == DividerType.vertical ? 1.0 : null,
                            );
                          },
                        );
                      });
                },
                child: Text("List Dialog")),
            FlatButton(
              onPressed: () {
                showDHDialog(
                    entryAnimation: EntryAnimation.slideBottom,
                    context: context,
                    builder: (context) {
                      return DHChoiceDialog(
                        titleText: "重复",
                        itemAlignment: Alignment.centerLeft,
                        datas: weeks,
                        multiChose: false,
                      );
                    });
              },
              child: Text("单选"),
            ),
            FlatButton(
              onPressed: () {
                showDHDialog(
                    entryAnimation: EntryAnimation.slideBottom,
                    context: context,
                    builder: (context) {
                      return DHChoiceDialog(
                        titleText: "重复",
                        itemAlignment: Alignment.centerLeft,
                        datas: weeks,
                        multiChose: true,
                      );
                    });
              },
              child: Text("多选对话框"),
            ),
            FlatButton(
              onPressed: () {
                showDHDialog(
                    entryAnimation: EntryAnimation.slideBottom,
                    context: context,
                    builder: (context) {
                      TextEditingController editController;
                      var getter = (controller)=> editController = controller;

                      return DHInputDialog(
                        titleText: "用户名",
                        filled: true,
                        style: TextStyle(color: Colors.red, fontSize: 15),
                        borderStyle: InputBorderStyle.outline,
                        controllerGetter: getter,
                        keyboardType: TextInputType.number,
                        hintText: "请输入用户名",
                        hintStyle: TextStyle(color: Colors.yellow),
                        suffixOnTap: (){
                          editController.text = "";
                        },
                        suffix: Text("删"),
                        positiveTap: (result){
                          print('result: $result');
                          Navigator.pop(context);
                        },
                        negativeTap: (result){
                          print('result: $result');
                          Navigator.pop(context);
                        },
                      );
                    });
              },
              child: Text("InputDialog"),
            )
          ],
        ),
      ),
    );
  }
}

const String imagePathPrefix = "assets/images";
