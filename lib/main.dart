import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './user_model.dart';
import 'dart:io';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                  onPressed: () async {
                    await makeRequest(
                        email: 'lordolumide@lord4.lord',
                        username: 'lordolfdmide4',
                        password: '12345678',
                        password2: '12345678');
                  },
                  child: const Text('Post Request')),
            ],
          ),
        ),
      ),
    );
  }
}

Future<User> makeRequest({
  required String email,
  required String username,
  required String password,
  required String password2,
}) async {
  BaseOptions options = BaseOptions(
    baseUrl: 'https://flirtbox.gtsresource.com',
    contentType: Headers.formUrlEncodedContentType,
  );
  final Dio dio = Dio(options);

  Response? response;
  Map<String, String> requestBody = {
    'email': email,
    'username': username,
    'password': password,
    'password2': password2
  };
  try {
    response = await dio.post(
      '/signup_person',
      data: requestBody,
    );
    print('Request completed');
  } on DioError catch (e) {
    if (e.response != null) {
      print('kmfovrnf');
      print(e.response!.data);
      print('=====');
      print(e.error);
      print('=====');
      print(e.response!.headers);
      print('=====');
      print(e.response!.requestOptions);
    } else {
      print('vinro');
      // Something happened in setting up or sending the request that triggered an Error
      print(e.requestOptions);
      print(e.message);
    }
    if (e.error is SocketException) {
      throw Exception(
        'Check your internet and try again',
      );
    } else if (e.response != null) {
      throw Exception('Error occurred');
    } else {
      print(e);
      print(e.stackTrace);
      print(e.message);
      rethrow;
    }
  } catch (e) {
    print('Network Helper catching error: $e');
    throw Exception(e);
  }

  print('Here');
  if (response.statusCode == 201) {
    final Map<String, dynamic> responseMap = response.data;

    print('Here22');
    return User.fromJson(responseMap);
  } else {
    print('Response : ${response.data}');
    throw Exception(response.data.toString());
  }
}
