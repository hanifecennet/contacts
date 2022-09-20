import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contacts/screens/delete_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:contacts/main.dart';
import '../models/contacts_model.dart';
import '../services.dart';
import 'home_page.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:contacts/models/contacts_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditPage extends StatefulWidget 
{
 final List? list;
 final int index;
  
 const EditPage({this.list,required this.index});
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> 
{
  File? image; //_image
  final _picker = ImagePicker(); //picker
  bool showSpinner = false;
  bool refreshPage = false;

  TextEditingController? name = TextEditingController();
  TextEditingController? username = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? phone = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  
  //TextEditingController? image = TextEditingController();

  //fotograf cekme islemi
  /*Future choiceImage()async{
    var pickedImage = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
  }*/
/*
  Future uploadImage()async{
    final uri = Uri.parse("http://172.16.45.204/contact/edit.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = nameController!.text;
    var pic = await http.MultipartFile.fromPath("image", image!.path);
    request.files.add(pic);
    var response = await request.send();
    
    if(response.statusCode == 200)
    {
      print('fotograf yuklendi');
      updateData();
    }
    else{
      print('fotograf yuklenemedi');
    }
  }*/

  updateData()async
  {
    http.post(Uri.parse('http://192.168.1.100/contact/edit.php'), body: 
      {
        'id' : widget.list?[widget.index].id,
        'name' : name?.text,
        'username' : username?.text,
        'email' : email?.text,
        'phone' : phone?.text,
        'image': image!.path,
        
      }
    );
  }

  @override
  void initState() 
  { //tum veriler baslatilir kayit alinir
    super.initState();
      name?.text= widget.list?[widget.index].name; //soru isaretleri non null hatasindan dolayi
      username?.text = widget.list?[widget.index].username;
      email?.text = widget.list?[widget.index].email;
      phone?.text = widget.list?[widget.index].phone;
      print(widget.list?[widget.index].image); //bu kisim 
  }

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);

    if(pickedFile!= null)
    {
      image = File(pickedFile.path);
      setState(() {
        //fileName = "";
        //filePath = "";
        //icerikController.text = filePath.toString();
        
      });
      updateData();
      print('fotograf secilmedi');
    }
    else
    {
      print('fotograf secilemedi');
    }
      
  }

  Future<void> uploadImage () async
  {
    setState(() {
      showSpinner = true;
    });
    
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('http://192.168.1.100/contact/edit.php');

    var request = new http.MultipartRequest('POST', uri);

    request.fields['title'] = "Static title";

    // var multiport = new http.MultipartFile(
    //  'image', 
    //  stream,
    //  length
    //  );
    
     request.fields["name"]= widget.list?[widget.index].name;
     request.fields["username"]= widget.list?[widget.index].username;
     request.fields["phone"]= widget.list?[widget.index].phone;
     request.fields["email"]= widget.list?[widget.index].email;
     request.fields["id"]= widget.list?[widget.index].id;
     request.files.add(await http.MultipartFile.fromPath('image', image!.path));
     
     var response = await request.send();

    print(response.stream.toString());
     if(response.statusCode == 200)
     {
      
      setState(() {
      showSpinner = false;
      //uploadImage();
      //updateData();
      });
      print('fotograf yuklendi');
      print('nbnb $image');
     }
     else
     {
        print('hata');
        setState(() {
        showSpinner = true;
        });
        
        
     }
  }
  
   /* PickedFile? pickImage; 
    String fileName = '', filePath = '';*/

  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kişi Bilgileri',
          style: TextStyle(
            fontSize: 25
          ),
        ),
      ),
      body: ListView(
        children: <Widget> [
          //SizedBox(height: 30),
          Column( 
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        print('tiklandi');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.QUESTION,
                            headerAnimationLoop: false,
                            animType: AnimType.BOTTOMSLIDE,
                            buttonsTextStyle: const TextStyle(color: Colors.black),
                            showCloseIcon: true,
                            btnCancelText: "Kamera",
                            btnCancelIcon: Icons.camera,
                            btnOkText: "Galeri",
                            btnOkIcon: CupertinoIcons.photo_fill,
                            btnCancelOnPress: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              //await getImage(ImageSource.camera);
                              await getImage();
                            },
                            btnOkOnPress: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await getImage();
                              //choiceImage(); //secilen fotografi ekrana getirir
                              uploadImage();
                              updateData();
                              
                             },
                          ).show();
                          refreshPage = !refreshPage;
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFffffff), width: 4)),
                            child: Padding(
                              padding: const EdgeInsets.only(left:117, bottom:10),
                              child: CircleAvatar(
                                //backgroundImage: const AssetImage('assets/tik.jpeg'),
                                //backgroundImage: const Image.file (image),
                                //backgroundImage: CachedNetworkImageProvider(Image.file(image!).toString(),),
                                child: widget.list?[widget.index].image == null ? Center(child: Text('Fotograf sec'),) : Container(
                                  child: Center(
                                    child: Image.network("http://192.168.1.100/contact/uploads/${widget.list?[widget.index].image}") ,
                                    /*child: Image.file(
                                      File(image!.path).absolute,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),*/
                                  ),
                                ),
                                
                                radius: MediaQuery.of(context).size.width / 7.5,
                                
                              ),
                            ),
                          ),
                          
                          Positioned( //edit buton
                            bottom: 0,
                            right: 6,
                            child: Container(
                              // child: image == null ? const Text('no') : Image.file(image!),
                              
                              height: 40,
                              width: 40,
                              decoration:
                                BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 4, color: Colors.white), color: Colors.blue),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              )

            /*Stack(
              alignment: Alignment.bottomRight,
              children: [
              Container(
                height: 125, width: 125, 
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/tik.jpeg'
                  ),
                ),
              ),
              Container(
                height: 15,
                width: 15,
                child: InkWell(
                  onTap: () {},
                  child: IconButton(
                    onPressed: () {  
                      
                          print('object');
                      
                          
                     },
                    icon: Icon(Icons.photo),
                    color: Colors.purple,
                  ),
                ),
              ),
                ],)*/
              ]
          ),
          
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: name, style: TextStyle(fontSize: 23),
              decoration: InputDecoration(
                labelText: 'Adı', 
                labelStyle: TextStyle(
                  fontSize: 28
                ), 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: username, style: TextStyle(fontSize: 23),
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı', 
                labelStyle: TextStyle(
                  fontSize: 28
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: email, style: TextStyle(fontSize: 23),
              decoration: InputDecoration(
                labelText: 'E-mail Adresi', 
                labelStyle: TextStyle(
                  fontSize: 28
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: phone, style: TextStyle(fontSize: 23),
              decoration: InputDecoration(
                labelText: 'Telefon Numarası', 
                labelStyle: TextStyle(
                  fontSize: 28
                ),
              ),
            ),
          ),
          /*Container(width:20,height: 20,
            child: Padding(
              padding: EdgeInsets.only(right: 250, left:50),
              
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
                shadowColor: Colors.deepOrange,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(10, 20), //////// HERE
                
              ),
                onPressed: ()
                {
                  setState(() {
                    updateData();
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);
                },
                //color: Colors.blue,
                child: Text('Güncelle' ,style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),

          Container(width:60,height: 60,
            child: Padding(
              padding: EdgeInsets.only(right: 50, left:250),
              
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
                shadowColor: Colors.deepOrange,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(10, 20), //////// HERE
                
              ),
                onPressed: ()
                {
                  setState(() {
                    updateData();
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);
                },
                //color: Colors.blue,
                child: Text('Güncelle' ,style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          )*/
          Row(
            children:[
              Column(
                children: [ 
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: InkWell(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius:  BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: Colors.orange,
                        ),
                        width: 150.0,
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Column(
                          children: [
                             Text("GÜNCELLE",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                          ]
                        ),
                      ),
                      onTap: ()
                      {
                        uploadImage();
                        updateData();
                        //refreshPage = !refreshPage;
                        setState(() {
                          
                          refreshPage = !refreshPage;
                          
                        
                        });
                        
                        //updateData();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);
                        
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0
                    ),
                    child: InkWell(
                      child: Container(
                        width: 150.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: Colors.orange,
                        ),
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Column(
                          children: [
                             Text("SİL",
                             style: TextStyle(
                              fontSize: 20, 
                              color:Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){ 
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Uyarı',
                          desc: 'Kişiyi silmek istediğinize emin misiniz?',descTextStyle: TextStyle(fontSize: 25 ),
                          btnCancelOnPress: () async 
                          {

                          },
                          btnCancelText: 'İptal', 
                          btnOkOnPress: () async
                          {
                            Api.deleteData(widget.list?[widget.index].id );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);
                          },
                          btnOkText: 'Sil', buttonsTextStyle: TextStyle(fontSize: 25), 
                        )..show();
                          /*setState(() {
                          /*http.post(Uri.parse('http://172.16.45.76/contact/delete.php'),body: {
                          'id' : data[index].id, //id numarasina gore kisiyi silme islemi
                          });*/
                          //Api.deleteData(data, int index);
                          });*/
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);
                        debugPrint('sile tiklandi');
                      },
                    ),
                  ),
                ],
              ),//column
            ],
          ),//row
        ],//widget
      ),//listview
    );//scaffold
    return Container();
  }
}
