import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('shopping_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Future<void> _createItem(Map<String,dynamic> newItem)async{
    await _shoppingBox.add(newItem);
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _showForm(BuildContext ctx, int? itemKey) async {
    showModalBottomSheet(context: ctx,elevation: 5,isScrollControlled: true,builder: (_)=>Container(padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom,top: 15,left: 15,right: 15),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(controller: _nameController,decoration: const InputDecoration(
          hintText: 'Name'
        )),
        const SizedBox(height: 10,),
        TextField(controller: _quantityController,keyboardType: TextInputType.number,decoration: const InputDecoration(hintText: 'Quantity'),),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: ()async{
          _createItem({"name":_nameController.text,"quantity":_quantityController.text});

          _nameController.text='';
          _quantityController.text='';

          Navigator.of(context).pop();
        }, child: Text("Create New"))
      ],),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(onPressed: ()=> _showForm(context, null),child: const Icon(Icons.add),),
    );
  }
}
