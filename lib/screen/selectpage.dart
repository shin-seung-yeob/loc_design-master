import 'package:flutter/material.dart';
import 'locaregister.dart';
import 'location_screen.dart';
import 'registerpage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  String authToken = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InNldW5neWVvYnNpbkBnbWFpbC5jb20iLCJwcm92aWRlciI6Imdvb2dsZSIsIm5pY2tOYW1lIjoi7KCc65OcIiwicmFua1Njb3JlIjowLCJpYXQiOjE3MDEwOTYxODksImV4cCI6MTcwMTI3NjE4OX0.K648xvr1dKlrPBvblaMtWdjcYpgTYNmJvbcg6yUYu_w';
//자신 토큰 넣기
  // SharedPreferences에서 JWT 토큰을 불러오는 함수
  Future<void> loadJwtToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('jwt_token') ?? 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InNldW5neWVvYnNpbkBnbWFpbC5jb20iLCJwcm92aWRlciI6Imdvb2dsZSIsIm5pY2tOYW1lIjoi7KCc65OcIiwicmFua1Njb3JlIjowLCJpYXQiOjE3MDEwOTYxODksImV4cCI6MTcwMTI3NjE4OX0.K648xvr1dKlrPBvblaMtWdjcYpgTYNmJvbcg6yUYu_w'; // 자신토큰넣기
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("간편 테스트 페이지"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaceRegistrationPage()),
                );
              },
              child: Text('사진,텍스트 등록'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaceRegistration()),
                );
              },
              child: Text('위도경도 등록'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocalScreen()),
                );
              },
              child: Text('확인페이지'),
            ),
            // 백엔드와 연결하는 버튼 추가
            ElevatedButton(
              onPressed: fetchDataFromBackend,
              child: Text('백엔드 연결'),
            ),
          ],
        ),
      ),
    );
  }

  // 백엔드 API 호출 함수
  Future<void> fetchDataFromBackend() async {
    final response = await http.get(
      Uri.parse('https://ae63-203-230-231-145.ngrok-free.app/user/t1'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': authToken,
      },
    );

    if (response.statusCode == 200) {
      // 성공적으로 데이터를 받아왔을 때의 처리
      print('Data fetched successfully: ${response.body}');
    } else {
      // 데이터를 받아오는 데 실패했을 때의 처리
      print('Failed to fetch data');
    }
  }
}
