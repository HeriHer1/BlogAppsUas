import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:uas_flutter/home_page.dart';
import 'package:uas_flutter/add.dart';
import 'package:uas_flutter/edit.dart';
import 'package:uas_flutter/login.dart';
import 'package:uas_flutter/view.dart';
import 'package:uas_flutter/nav-drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_final_fields
  CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('posts');
  Future<void> _deleteProduct(String productId) async {
    await _newsCollection.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Artikel Blog Berhasil Dihapus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('CRUD Flutter'),
        actions: <Widget>[
          MaterialButton(
            textColor: Colors.white,
            onPressed: () {
              Login.statusLogin = 0;
              Navigator.of(context).pushReplacementNamed(Login.tag);
            },
          )
        ],
      ),
      drawer: DrawerWidget(),
      endDrawer: DrawerWidget(),
      body: StreamBuilder(
        stream: _newsCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new View(
                                list: streamSnapshot.data!.docs,
                                index: index))),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['title']),
                        subtitle: Text(documentSnapshot['short_desc']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Edit(
                                            list: streamSnapshot.data!.docs,
                                            index: index,
                                          )),
                                ),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      _deleteProduct(documentSnapshot.id),
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Add())),
        child: Icon(Icons.add),
      ),
    );
  }
}
