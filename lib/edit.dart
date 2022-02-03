import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/main.dart';

class Edit extends StatefulWidget {
  List list;
  int index;
  Edit({required this.index, required this.list});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _shortdescController = TextEditingController();
  TextEditingController _descall = TextEditingController();
  TextEditingController _image = TextEditingController();
  CollectionReference _ilhamCollection =
      FirebaseFirestore.instance.collection('posts');

  @override
  void initState() {
    _titleController =
        new TextEditingController(text: widget.list[widget.index]["title"]);
    _shortdescController =
        new TextEditingController(text: widget.list[widget.index]["title"]);
    _descall =
        new TextEditingController(text: widget.list[widget.index]["title"]);
    _image =
        new TextEditingController(text: widget.list[widget.index]["title"]);
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async {
    final String? vartitle = _titleController.text;
    final String? varshortdesc = _shortdescController.text;
    final String? vardesc = _descall.text;
    final String? varimage = _image.text;

    await _ilhamCollection.doc(documentSnapshot!.id).update({
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
          title: new Text("Edit Artikel"),
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
                    onPressed: () => update(widget.list[widget.index])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
