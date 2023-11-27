import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaceRegistration extends StatefulWidget {
  @override
  _PlaceRegistrationPageState createState() => _PlaceRegistrationPageState();
}

class _PlaceRegistrationPageState extends State<PlaceRegistration> {
  final _formKey = GlobalKey<FormState>();
  double _latitude = 0.0; // 위도
  double _longitude = 0.0; // 경도

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('장소 등록'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: '위도'),
              keyboardType: TextInputType.number, // 숫자만 입력 가능하도록 설정
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '위도를 입력하세요';
                }
                return null;
              },
              onSaved: (value) {
                _latitude = double.parse(value!);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '경도'),
              keyboardType: TextInputType.number, // 숫자만 입력 가능하도록 설정
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '경도를 입력하세요';
                }
                return null;
              },
              onSaved: (value) {
                _longitude = double.parse(value!);
              },
            ),
            ElevatedButton(
              child: Text('등록하기'),
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // JSON 데이터 생성
      var jsonData = _createJsonData();

      // 백엔드로 데이터 전송
      await _sendDataToBackend(jsonData);
    }
  }

  Map<String, dynamic> _createJsonData() {
    return {
      'latitude': _latitude,
      'longitude': _longitude,
    };
  }

  Future<void> _sendDataToBackend(Map<String, dynamic> jsonData) async {
    var response = await http.post(
      Uri.parse('https://ae63-203-230-231-145.ngrok-free.app/user/location/register'), // 백엔드 URL을 여기에 입력하세요.
      headers: {"Content-Type": "application/json"},
      body: json.encode(jsonData),
    );

    if (response.statusCode == 200) {
      // 성공적으로 전송됨
      print('Data sent successfully');
    } else {
      // 오류 발생
      print('Failed to send data');
    }
  }
}
