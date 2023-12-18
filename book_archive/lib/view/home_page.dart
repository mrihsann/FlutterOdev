import 'package:book_archive/firebase_service/service.dart';
import 'package:book_archive/view/book_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_book_page.dart';

class HomePage extends StatelessWidget {
  final Service service=Service();
  final List<String> bookList = [
    'Roman',
    'Tarih',
    'Edebiyat',
    'Şiir',
    'Ansiklopedi',
    'Diğer',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İhsan Arslan Kütüphane Yönetimi'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Burger menu butonuna basıldığında yapılacak işlemler buraya yazılabilir.
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Butona tıklandığında Navigator ile yeni sayfaya yönlendirme
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addBook(docID: '',)),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.getBooksStream(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List bookList=snapshot.data!.docs;

            return ListView.builder(
                itemCount: bookList.length,
                itemBuilder: (context,index){
                  DocumentSnapshot document=bookList[index];
                  String docID=document.id;

                  Map<String,dynamic> data =
                      document.data() as Map<String,dynamic>;
                  String kitapAdi=data['kitap_adi']?? 'Bilgi Yok';
                  String yazar=data['yazarlar']?? 'Bilgi Yok';
                  String sayfaSayisi=data['sayfa_sayisi']?? 'Bilgi Yok';

                  return BookList(
                      title: kitapAdi,
                      subtitle: [yazar,sayfaSayisi],
                      docID: docID
                  );
                });
          }
          else{
            return const Text("Kitap Yok...");
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Kitaplar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Satın Al',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}