import 'package:book_archive/firebase_service/service.dart';
import 'package:flutter/material.dart';


class addBook extends StatefulWidget {

  final String docID; // docID parametresi eklendi

  addBook({required this.docID});

  @override
  _addBookState createState() => _addBookState();
}

class _addBookState  extends State<addBook> {

  final Service service=Service();

  var book = TextEditingController();
  var publisher = TextEditingController();
  var writer = TextEditingController();
  var category = "";
  var number_of_pages = TextEditingController();
  var year_of_publication = TextEditingController();
  var yayinlansinmi = false;
  var varmi=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Arşive Kitap Ekle",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Butona tıklandığında Navigator ile yeni sayfaya yönlendirme
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: book,
                  decoration: const InputDecoration(
                    hintText: "Kitap Adı",
                      hintStyle: TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: publisher,
                  decoration: const InputDecoration(
                    hintText: "Yayın Evi",
                      hintStyle: TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: writer,
                  decoration: const InputDecoration(
                    hintText: "Yazarlar",
                      hintStyle: TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: DropdownButtonFormField<String>(
                  value: category.isNotEmpty ? category : null, // Varsayılan değeri null yapınca 'Kategori' gözükmez
                  onChanged: (newValue) {
                    setState(() {
                      category = newValue!;
                    });
                  },
                  items: <String>[
                    'Roman',
                    'Tarih',
                    'Edebiyat',
                    'Şiir',
                    'Ansiklopedi',
                    'Diğer'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: 'Kategori', // Hint metni burada eklenmiştir
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: number_of_pages,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Sayfa Sayısı",
                      hintStyle: TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: year_of_publication,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Basım Yılı",
                      hintStyle: TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Listede yayınlanacak mı?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Checkbox(
                      value: yayinlansinmi,
                      onChanged: (value) {
                        setState(() {
                          yayinlansinmi = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      service.addBook(book.text, publisher.text, writer.text, category, number_of_pages.text, year_of_publication.text, yayinlansinmi);

                      book.clear();
                      number_of_pages.clear();
                      publisher.clear();
                      writer.clear();
                      year_of_publication.clear();
                      setState(() {
                        category = ''; // Kategori içini boşalt
                      });
                    },
                    child: const Text("Kaydet"),
                  ),
                ),
              ),
            ],

          ),
      ),
    );
  }
}