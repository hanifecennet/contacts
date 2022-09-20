import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class YeniKayit extends StatefulWidget 
{
  final List? list;
  final int index;
  const YeniKayit({this.list, this.index=0}); //non null hatasini onlemek icin 0 verildi

  @override
  State<YeniKayit> createState() => _YeniKayitState();
}

class _YeniKayitState extends State<YeniKayit> 
{
  TextEditingController? name = TextEditingController();
  TextEditingController? username = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? phone = TextEditingController();

  addData()
  {
    http.post(
      Uri.parse('http://192.168.1.100/contact/add.php'),body: //php sayfasi ile baglanti kurar
      {
        'name' : name?.text,
        'username' : username?.text,
        'email' : email?.text,
        'phone' : phone?.text,
      }
    );
  }

@override
void initState() 
{ //tum veriler baslatilir kayit alinir
  super.initState();
}

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(title: Text('Kişi Ekle'),),
      body: ListView(
        children: <Widget> [
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: name, style: TextStyle(fontSize: 25),
              decoration: 
              InputDecoration(
                labelText: 'Adı',
                labelStyle: TextStyle(fontSize: 23),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: username, style: TextStyle(fontSize: 25),
              decoration: 
              InputDecoration(
                labelText: 'Kullanıcı Adı',
                labelStyle: TextStyle(fontSize: 23),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: email, style: TextStyle(fontSize: 25),
              decoration: 
              InputDecoration(
                labelText: 'E-mail Adresi',
                labelStyle: TextStyle(fontSize: 23),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: phone, style: TextStyle(fontSize: 25),
              
              decoration: 
              InputDecoration(
                labelText: 'Telefon Numarası',
                labelStyle: TextStyle(fontSize: 23),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 130.0, left: 130.0, top: 40.0),
            child: ButtonTheme(
              
              minWidth: 90,
              height: 60,
              child: RaisedButton(
              
               shape: RoundedRectangleBorder(
                
                  borderRadius: BorderRadius.circular(40)),
                onPressed: ()    
                {
                  setState(() 
                  {
                    addData();
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),); //kayit alindiktan sonra rehber sayfasina gider
                },
                color: Colors.orange[700],
                child: Text('KAYDET', style: TextStyle(color: Colors.white, fontSize: 26),
                ),
               // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}