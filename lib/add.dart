import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/main.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _shortdescController = TextEditingController();
  TextEditingController _descall = TextEditingController();
  TextEditingController _image = TextEditingController();
  CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> add([DocumentSnapshot? documentSnapshot]) async {
    final String? vartitle = _titleController.text;
    final String? varshortdesc = _shortdescController.text;
    final String? vardesc = _descall.text;
    final String? varimage = _image.text;

    await _newsCollection.add({
      "title": vartitle,
      "short_desc": varshortdesc,
      "desc": vardesc,
      "img": varimage
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  (new Color(0xFF4CAF50)),
                  new Color(0xFF2E7D32),
                ])),
          ),
          title: new Text("Tambah Artikel"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: "title"),
                ),
                TextField(
                  controller: _shortdescController,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(labelText: "short_desc"),
                ),
                TextField(
                  controller: _descall,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(labelText: "desc"),
                ),
                TextField(
                  controller: _image,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: "Img Url"),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    child: new Text("tambah data"),
                    color: Colors.blueAccent,
                    onPressed: () => add()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
