import 'package:flutter/material.dart';
import 'my_color.dart';
import 'detail_screen.dart';

class LocalScreen extends StatefulWidget {
  @override
  _LocalScreenState createState() => _LocalScreenState();
}

class _LocalScreenState extends State<LocalScreen> {
  List<String> imagePaths = [
    'asset/img/bombom.jpg',
    'asset/img/dridri.jpg',
    'asset/img/drinking.jpg',
    'asset/img/ddrink.jpg',
    'asset/img/boom.jpg',
    'asset/img/boomenu.jpg',
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: my_color.whiteone,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: PageView.builder(
        itemCount: imagePaths.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePaths[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        Text(
                          '봄봄',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: my_color.whiteone,
                          ),
                        ),
                        Text(
                          '주소: 대구시, 계명대동문',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: my_color.whiteone,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < imagePaths.length; i++)
                              if (i < 4)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      imagePaths[(i + currentPage) % imagePaths.length],
                                      width: 62.0,
                                      height: 62.0,
                                    ),
                                  ),
                                ),
                            if (imagePaths.length > 4)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    width: 62.0,
                                    height: 62.0,
                                    color: Colors.grey,
                                    child: Center(
                                      child: Text(
                                        '+${imagePaths.length - 4}',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: my_color.whiteone,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            _openDetailScreen();
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              size: 32.0,
                              color: my_color.whiteone,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _openDetailScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(),
      ),
    );
  }
}