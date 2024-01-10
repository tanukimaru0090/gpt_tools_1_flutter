import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPT回答用プロンプト生成ツール',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.grey,
          onPrimary: Colors.white,
          secondary: Colors.blue,
          onSecondary: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
          background: Colors.white,
          onBackground: Colors.black,
          error: Colors.red,
          onError: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GPT回答用プロンプトを生成します'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _questionPrompt = "";
  String _optionPrompt = "";
  double _value = 0;

  List<Widget> _widgets = [];
// コピーボタンが押された時の処理をする関数
  void _onCopy() {}
  void _onGenerate() {}
  void _onDeleteWidget() {
    setState(() {
      try {
        if (_widgets.isNotEmpty) {
          _widgets.removeLast();
        }
      } catch (e) {
        print(e);
      }
    });
  }

  // リストにウィジェットを追加する関数
  void _onAddWidget() {
    setState(() {
      // Rowウィジェットを作成
      Widget row = SizedBox(
        width: 200.0,
        child: Row(
          children: <Widget>[
            // 入力フォーム
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: '', // ラベル
                  border: OutlineInputBorder(), // 枠線
                ),
              ),
            ),
          ],
        ),
      );

      // リストに追加
      _widgets.add(row);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          // スクロールできるようにする
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // 幅を最大にする

            children: <Widget>[
              SizedBox(
                width: 200.0,
                child: TextFormField(
                  onChanged: (input) {
                    setState(() {
                      _questionPrompt = input; // 値を更新
                    });
                  },
                  maxLength: 1000,
                  maxLines: 15,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "問題を入力してください",
                    labelText: "問題",
                    contentPadding: EdgeInsets.all(10.0), // 余白を10ピクセルに変更
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  child: Text('選択肢を追加'),
                  onPressed: _onAddWidget,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple, // 背景色
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  child: Text('選択肢を削除'),
                  onPressed: _onDeleteWidget,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple, // 背景色
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _widgets.length, // リストの要素数
                  itemBuilder: (context, index) {
                    // リストの各要素に対応するウィジェットを返す
                    return _widgets[index];
                  },
                ),
              ),
              SizedBox(
                width: 200.0,
                child: TextFormField(
                  onChanged: (input) {
                    setState(() {
                      _optionPrompt = input; // 値を更新
                    });
                  },
                  maxLength: 1000,
                  maxLines: 15,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "追加のプロンプトを入力してください",
                    labelText: "追加のプロンプト",
                    contentPadding: EdgeInsets.zero, // 余白をなくす
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  child: Text("生成"),
                  onPressed: _onGenerate,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple, // 背景色
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onCopy,
        tooltip: 'Copy!',
        child: const Icon(Icons.copy),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
