import 'dart:convert';
import 'package:contacts/screens/edit_page.dart';
import 'package:contacts/models/contacts_model.dart';
import 'package:contacts/screens/sms_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services.dart';
import 'new_person_page.dart';
import 'detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget 
{
  //const HomePage({Key? key, required this.kisi}) : super(key: key);
  //final RehberModel kisi;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  bool refreshPage = false;
  
  @override
  Widget build(BuildContext context) 
  {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('REHBER'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 40),
        onPressed:()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => YeniKayit(),),); //kayit butonuna tiklama
          //navigator sayfalar arasi gecis, context-widgetın agac uzerindekii adresini bildirir, bana rout ver
          debugPrint('floating butona tıklandi');
        }, 
      ),

      body: FutureBuilder(
        
        future: Api.rehberGetir(),
        
        builder: (BuildContext context, AsyncSnapshot snapshot)
        {
          if(snapshot.hasData)
          {
            List<RehberModel> data =snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                
                  itemBuilder: (BuildContext context, int index)
                  {
                    List list = snapshot.data;
                    
                    return ListTile(
                      title: Text(data[index].name!,style: TextStyle(fontSize: 20),),
                      subtitle:Text(data[index].phone!, style: TextStyle(fontSize: 20),), 
                      
                      leading: GestureDetector(
                        child: IconButton(
                          icon: const Icon(Icons.call,size: 25,),
                          onPressed: () //arama islemi
                          {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: (data[index].phone),
                            );
                            launchUrl(launchUri);
                          }
                        ),
                          /*onTap: ()
                          { //tiklandiginde guncelleme sayfasina gider 
                            Navigator.push(context, new MaterialPageRoute(builder: (context) => EditPage(list: list, index: index,),),);
                              debugPrint('duzenleye tiklandi');
                          },*/
                          
                      ),
                      
                      onTap: (){
                         //refreshPage = !refreshPage;
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => EditPage(list: list, index: index,),),);
                        // Navigator.push(context, new MaterialPageRoute(builder: (context) => DetayPage( kisi: data[index],),),);
                       setState(() {
                         //refreshPage = !refreshPage;
                       }); 
                      },
                      trailing: GestureDetector(
                        child: Icon(
                          Icons.message, size: 25,
                        ),
                        onTap: (){
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => MyApp(),),);
                            debugPrint('mesaja tiklandi');
                        },
                      ),
                            /*trailing: GestureDetector(
                              child: Icon(
                                Icons.delete
                              ),
                              onTap: (){
                                setState(() {
                                  http.post(Uri.parse('http://172.16.45.76/contact/delete.php'),body: {
                                  'id' : data[index].id, //id numarasina gore kisiyi silme islemi
                                  });
                                });
                                debugPrint('sile tiklandi');
                              },
                            ),*/
                    );
                  }
              );
          }
          else
          {
            return Container();
          }
        }
      ),
    );
  }
}





