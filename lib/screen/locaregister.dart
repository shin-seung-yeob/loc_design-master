import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlaceRegistrationPage extends StatefulWidget {
  @override
  _PlaceRegistrationPageState createState() => _PlaceRegistrationPageState();
}

class _PlaceRegistrationPageState extends State<PlaceRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _placeName = '';
  String _placeCategory = '';
  String _placeAddress = '';
  File? _image; // 선택된 이미지 파일을 저장할 변수

  final ImagePicker _picker = ImagePicker();

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
            if (_image != null)
              Image.file(_image!), // 선택된 이미지 표시
            ElevatedButton(
              child: Text('사진 선택하기'),
              onPressed: _pickImage,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '장소 이름'),
              onSaved: (value) => _placeName = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '장소 카테고리'),
              onSaved: (value) => _placeCategory = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '장소 주소'),
              onSaved: (value) => _placeAddress = value!,
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

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // JSON 데이터 생성
      var jsonData = await _createJsonData();

      // 백엔드로 데이터 전송
      await _sendDataToBackend(jsonData);
    }
  }

  Future<Map<String, dynamic>> _createJsonData() async {
    String base64Image = '';
    if (_image != null) {
      List<int> imageBytes = await _image!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    return {
      'placeName': _placeName,
      'placeCategory': _placeCategory,
      'placeAddress': _placeAddress,
      'image': base64Image
    };
  }

  Future<void> _sendDataToBackend(Map<String, dynamic> jsonData) async {
    var response = await http.post(
      Uri.parse(' https://ae63-203-230-231-145.ngrok-free.app/location/search/findLocation/1'), // 백엔드 URL을 여기에 입력하세요.
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
