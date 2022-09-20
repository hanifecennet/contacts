import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contacts/models/contacts_model.dart';
import 'screens/edit_page.dart';
import 'screens/home_page.dart';

class Api 
{ 
  //static late Box box;
  //rehberi getiren servis
  static Future<List<RehberModel>> rehberGetir() async 
  {
    var uri = Uri.parse("http://192.168.1.100/contact/contact.php");
    
    var data = [];
    try 
    {
      final response = await http.get(uri); //adrese baglanma
      if (response.statusCode == 200) 
      {
        print(data);
        data = json.decode(response.body); //

        print("islem basarılı");
      } 
      else 
      {
        print("api hatası");
      }
    } 
    catch (err) 
    {
      print(err);
      //return data;
    }
    return data.map((data) => RehberModel.fromJson(data)).toList();
    
  }

  
  //Ekle
 static addData( data, int index)
  {
    http.post(
      Uri.parse('http://192.168.1.100/contact/add.php'),body: //php sayfasi ile baglanti kurar
      {
        'name' : data[index].name,
        'username' : data[index].username,
        'email' : data[index].email,
        'phone' : data[index].phone,
      }
    );
  }


  //guncelleme
  static updateData(data, int index) async //asek
  {
    http.post(Uri.parse('http://192.168.1.100/contact/edit.php'),body: 
      {
        'id' : data[index].id,
        'name' : data[index].name,
        'username' : data[index].username,
        'email' : data[index].email,
        'phone' : data[index].phone,
        
      }
    );
  }

  //silme
  static deleteData( String id  ) async
  {
    http.post(Uri.parse('http://192.168.1.100/contact/delete.php'),body: 
    {
      'id' : id, //id numarasina gore kisiyi silme islemi
    }
    );
  }                                
}