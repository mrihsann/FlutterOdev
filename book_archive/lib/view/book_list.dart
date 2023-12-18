import 'package:book_archive/firebase_service/service.dart';
import 'package:flutter/material.dart';
import 'add_book_page.dart';

class BookList extends StatefulWidget {
  final String title;
  final List<String> subtitle;
  final String docID;
  BookList({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.docID,
  });

  @override
  State<BookList> createState() => _KitapCardState();
}

class _KitapCardState extends State<BookList> {
  final Service service=Service();

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3), // İstediğiniz padding değerini ayarlayabilirsiniz
    child: Card(
      child: ListTile(
        title: Text(widget.title),
        subtitle: Text(widget.subtitle.join(', ')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addBook(docID: widget.docID)),
                );
              },
              child: const Icon(Icons.edit),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Silmek istediğinize emin misiniz?'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Evet'),
                          onPressed: () {
                            // Silme işlemi
                            service.deleteBook(widget.docID);
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Hayır'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    ));
  }
}