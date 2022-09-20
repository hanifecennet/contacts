import 'package:contacts/screens/edit_page.dart';
import 'package:contacts/screens/home_page.dart';
import 'package:contacts/models/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'delete_page.dart';
import 'edit_page.dart';

class DetayPage extends StatefulWidget 
{
  const DetayPage({Key? key, required this.kisi}) : super(key: key);
  final RehberModel kisi; 
  
  @override
  State<DetayPage> createState() => _DetayPageState();
}

class _DetayPageState extends State<DetayPage> {
  int currentIndex = 0;
  final screens = [
    
    //HomePage(),
    //DeletePage(),
    //EditPage(),
    //HomePage(),
  ];
 /* static const List<Widget> _widgetOptions = <Widget>[

    HomePage(),
    /*Text(
      'Index 0: Ara',
      //style: optionStyle,
      
    ),
    
    Text(
      'Index 1: Düzenle',
      //style: optionStyle,
    ),
    Text(
      'Index 2: Sil',
      //style: optionStyle,
    ),*/
  ];*/

   void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
 //buraya bak 
  @override
  
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kisi.name!),
        centerTitle: true,
      ),
      //body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 50,
        selectedFontSize: 25,
        unselectedFontSize: 20,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call,),
            label: 'Ara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit, ),
            label: 'Düzenle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete,),
            label:  'Sil',
          ),
        ],
        //currentIndex: _currentIndex,
        
        /*onTap: (value) {
          // Respond to item press.
          setState(() => currentIndex = value);
        },*/
      ),
    
      //row
      //Row(children: [IconButton(onPressed: onPressed, icon: icon)],),
     /* floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed:()
        {
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>KayitGuncelle()),);
        
          //navigator sayfalar arasi gecis, context-widgetın agac uzerindekii adresini bildirir, bana rout ver
          //debugPrint('floating butona tıklandi');
        }, 
      ),*/
      body: Center(
        
          
        child: Container( 
          alignment: Alignment.topLeft,
        child: Column( //mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
            
            Container(
              width: 250,
              height: 250,
              //alignment: Alignment.,

              //child: Text("Container",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white),),
              decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/tik.jpeg'),
                fit: BoxFit.contain,
              ),
              shape: BoxShape.circle,
            ),
      ),
           // _widgetOptions.elementAt(_currentIndex),
            Text("Adı:  "+widget.kisi.name!, style: TextStyle(fontSize: 25), ),
            SizedBox(height: 20,),
            Text("Telefon Numarası:  "+widget.kisi.phone!, style: TextStyle(fontSize: 25),),
            SizedBox(height: 20,),
            Text("E-mail Adresi:  "+widget.kisi.email!, style: TextStyle(fontSize: 25), ),
            SizedBox(height: 20,),
            ButtonTheme(
              minWidth: 140,
              height: 60,
              child: RaisedButton(
                color: Colors.orange[800],
                textColor: Colors.white,

              
              
                
                onPressed: () //arama islemi
              {
                final Uri launchUri = Uri(
                  
                  scheme: 'tel',
                 // path: (kisi.phone),
                );
                launchUrl(launchUri);
              }
              ),
            )
          ]
        ),
      ),
      ),
    );
  }
}
ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
   // colorScheme: _shrineColorScheme,
    textTheme: _buildShrineTextTheme(base.textTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 34,
          color: Colors.green,
          //letterSpacing: defaultLetterSpacing,
        ),
        button: base.button?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 34,
          color: Colors.green,
          //letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
       // displayColor: shrineBrown900,
        //bodyColor: shrineBrown900,
      );
}
/*
void changePage(int index)
{
  setState((){

  }
  
  );
}

Widget viewPage(int seciliSayfa)
{
  if(seciliSayfa == 0){
    return HomePage();
  }
  /*else if(seciliSayfa == 1){
    return ();
  }*/
}*/
/*void call()
{
  
   onPressed: () //arama islemi
              {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: (kisi.phone),
                );
                launchUrl(launchUri);
              }
}*/