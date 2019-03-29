import 'package:flutter/material.dart';
import 'news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Wakeup News'),
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
  List<Article> _news = <Article>[];
  List<String> _newsTemp = <String>[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newsTemp = List.generate(10, (i) => 'Restaurant $i');
    listenForNews();
  }

  listenForNews() async {
    //_news =  new List<Article>();
    var stream = await getPlaces();
    stream.listen((news) => setState(() => _news.add(news)));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // คือถ้าไม่ได้กำหนด List View ให้ดี เหมือนต้องใส่ Expanded ไว้ก่อนเพื่อป้องกันมัน Scale แปลกๆ
          Expanded(
              child: ListView(
                //children: _newsTemp.map((news) => Text(news)).toList(),
                children: _news.map((news) => NewsWidget(news)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {

  final Article _news;

  NewsWidget(this._news);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
                  elevation: 1.7,
                      child:  Padding(
                          padding:  EdgeInsets.all(10.0),
                          child:  Column(
                            children: [
                               Row(
                                children: <Widget>[
                                   Padding(
                                    padding:  EdgeInsets.only(left: 4.0),
                                    child:  Text(
                                      '5 Days ago',
                                      style:  TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                   Padding(
                                    padding:  EdgeInsets.all(5.0),
                                    child:  Text(
                                      'BBC News',
                                      style:  TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                               Row(
                                children: [
                                   Expanded(
                                    child:  GestureDetector(
                                      child:  Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                           Padding(
                                            padding:  EdgeInsets.only(
                                                left: 4.0,
                                                right: 8.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child:  Text(
                                              _news.title,
                                              style:  TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                           Padding(
                                            padding:  EdgeInsets.only(
                                                left: 4.0,
                                                right: 4.0,
                                                bottom: 4.0),
                                            child:  Text(
                                              // เผื่อมันว่างจะพังเด้อ
                                              _news.description ?? ' ',
                                              maxLines: 3,
                                              style:  TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),                                
                                    ),
                                  ),
                                   Column(
                                    children: <Widget>[
                                       Padding(
                                        padding:  EdgeInsets.only(top: 8.0),
                                        child:  SizedBox(
                                          height: 100.0,
                                          width: 100.0,
                                          // เหมือนกันแยก Data พังหน่อย
                                          child:  Image.network(
                                            _news.urlToImage ?? 'https://via.placeholder.com/150',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
  }

}

