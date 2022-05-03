
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

FormData _$FormDataFromJson(Map<String, dynamic> json) {
  return FormData(
    Login: json['Login'] as String?,
    Senha: json['Senha'] as String?,
  );
}

Map<String, dynamic> _$FormDataToJson(FormData instance) => <String, dynamic>{
  'Login': instance.Login,
  'Senha': instance.Senha,
};

@JsonSerializable()
class FormData {
  String? Login;
  String? Senha;

  FormData({
    this.Login,
    this.Senha,
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Client? httpClient;
  final String title;

  const MyHomePage({
    required this.title,
    this.httpClient,
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FormData formData = FormData();
  // String? nome;
  // String? senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Autenticação'),
      ),
      body: Form(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...[
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Seu nome de usuário',
                      labelText: 'Nome',
                    ),
                    onChanged: (value) {
                      //nome = value;
                      formData.Login = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      // senha = value;
                      formData.Senha = value;
                    },
                  ),
                  TextButton(
                    child: const Text('Sign in'),
                    onPressed: () async {

                      final httpsUri = Uri(
                          scheme: 'https',
                          host: '10.0.2.2',
                          port: 44357,
                          path: 'user/authenticate');

                      // Use a JSON encoded string to send
                      var client = Client();
                      var result = await client.post(
                          httpsUri,
                          //body: {'Login': 'elmo', 'Senha': 'elmo1233'});//,
                          body: json.encode(formData.toJson()),
                          headers: {'content-type': 'application/json'});//,
                          //encoding: Encoding.getByName("utf-8"));

                      if (result.statusCode == 200) {
                        _showDialog('Successfully signed in.');
                      } else if (result.statusCode == 401) {
                        _showDialog('Unable to sign in.');
                      } else {
                        _showDialog('Something went wrong. Please try again.');
                      }

                      // String basicAuth =
                      //     'Basic ' + base64Encode(utf8.encode('$nome:$senha'));
                      // print(basicAuth);

                      // Response r = await get('https://api.somewhere.io',
                      //     headers: <String, String>{'authorization': basicAuth});
                      // print(r.statusCode);
                      // print(r.body);

                      // Future<Response> callAPI(param) async {
                      //   await dio.post('/api/test',
                      //       data: {'param': param},
                      //       options: Options(headers: <String, String>{'authorization': auth}));
                      // }

                    },
                  ),
                ].expand(
                      (widget) => [
                    widget,
                    const SizedBox(
                      height: 24,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
