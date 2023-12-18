import 'package:cloud_firestore/cloud_firestore.dart';

class Service{
  final CollectionReference books=
      FirebaseFirestore.instance.collection("books");

  //creat
  Future<void> addBook(String kitapAdi, String yayinEvi, String yazarlar, String kategori, String sayfaSayisi, String basimYili, bool yayinlanacakmi) {
    return books.add({
      'kitap_adi':kitapAdi,
      'yayin_evi':yayinEvi,
      'yazarlar':yazarlar,
      'kategori':kategori,
      'sayfa_sayisi':sayfaSayisi,
      'basim_yili':basimYili,
      'yayinlanacakmi':yayinlanacakmi,
      'timestap':Timestamp.now()
    });
  }

  //read books
  Stream<QuerySnapshot> getBooksStream(){
    final booksStream=
    books.orderBy('timestap').snapshots();
    return booksStream;
  }

  Stream<DocumentSnapshot> getBookStream(String docID) {
    // Belirli bir dokümanın değişikliklerini dinleyen bir Stream döndür
    return FirebaseFirestore.instance.collection('books').doc(docID).snapshots();
  }


  //update
  Future<void> updateBook(String docID,String kitapAdi, String yayinEvi, String yazarlar, String kategori, String sayfaSayisi, String basimYili, bool yayinlanacakmi){
    return books.doc(docID).update({
      'kitap_adi':kitapAdi,
      'yayin_evi':yayinEvi,
      'yazarlar':yazarlar,
      'kategori':kategori,
      'sayfa_sayisi':sayfaSayisi,
      'basim_yili':basimYili,
      'yayinlanacakmi':yayinlanacakmi,
      'timestap':Timestamp.now()
    });
  }

  //delete
  Future<void> deleteBook(String docID){
    return books.doc(docID).delete();
  }


}