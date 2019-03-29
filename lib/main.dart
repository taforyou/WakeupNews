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
    //_news = new List<Article>();
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
          Text('Hey'),
          Text('Hey'),
          Text('Hey'),
        ],
      ),
    );
  }
}

// class NewsWidget extends StatelessWidget {

//   final Article _news;

//   NewsWidget(this._news);

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ListTile(
//       title: Text(_news.title),
//     );
//   }

// }

class NewsWidget extends StatelessWidget {

  final Article _news;

  NewsWidget(this._news);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
                  elevation: 1.7,
                      child: new Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Column(
                            children: [
                              new Row(
                                children: <Widget>[
                                  new Padding(
                                    padding: new EdgeInsets.only(left: 4.0),
                                    child: new Text(
                                      '5 Days ago',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.all(5.0),
                                    child: new Text(
                                      'BBC News',
                                      style: new TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              new Row(
                                children: [
                                  new Expanded(
                                    child: new GestureDetector(
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          new Padding(
                                            padding: new EdgeInsets.only(
                                                left: 4.0,
                                                right: 8.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: new Text(
                                              _news.title,
                                              style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          new Padding(
                                            padding: new EdgeInsets.only(
                                                left: 4.0,
                                                right: 4.0,
                                                bottom: 4.0),
                                            child: new Text(
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eu facilisis sed odio morbi quis commodo odio aenean sed.',
                                              style: new TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),                                
                                    ),
                                  ),
                                  new Column(
                                    children: <Widget>[
                                      new Padding(
                                        padding: new EdgeInsets.only(top: 8.0),
                                        child: new SizedBox(
                                          height: 100.0,
                                          width: 100.0,
                                          child: new Image.network(
                                            'https://via.placeholder.com/150',
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

