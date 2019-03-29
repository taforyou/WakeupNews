// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'key.dart' show key;

main() {
  getPlaces(); 
}

class Article {
    final Source source;
    final String author;
    final String title;
    final String description;
    final String url;
    final String urlToImage;
    final String publishedAt;
    final String content;

        Article.fromJson(Map jsonMap)
      : source =Source.fromJson(jsonMap['source']),
        author =jsonMap['author'],
        title =jsonMap['title'],
        description =jsonMap['description'],
        url =jsonMap['url'],
        urlToImage =jsonMap['urlToImage'],
        publishedAt =jsonMap['publishedAt'],
        content =jsonMap['content'];
    
    String toString() => 'title: $title';
}

class Source {
    final dynamic id;
    final String name;

    Source.fromJson(Map jsonMap)
      : id =jsonMap['id'],
        name =jsonMap['name'];

    //String toString() => 'id: $id';
}

Future<Stream<Article>> getPlaces() async {

  var url =
      'https://newsapi.org/v2/top-headlines?country=th&apiKey=a1cc62c2b46541ecb4726f3fefed8b2a';

  // ขั้นแรกทำเอาไว้ ลองเรียกผ่าน dart news.dart ใน command line เลย
  // http.get(url).then(
  //   (res) => print(res.body)
  // );

  // อันนี้ ใช้ Stream >> Stream ต่างจาก Future คือ Future มาทีเดียว Stream ค่อยๆ ทะยอยมา ก็อาจจะ Handle ได้ง่ายกว่า
  var client = new http.Client();
  var streamedRes = await client.send(new http.Request('get', Uri.parse(url)));

  return streamedRes.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((jsonBody) => (jsonBody as Map)['articles'])
      .map((jsonPlace) => new Article.fromJson(jsonPlace));
      // .listen((data) => print(data)) // Print ผมออกมาจาก .toString()
      // .onDone(() => client.close())
}
