import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Change Language'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome to Railrelax',style: TextStyle(fontSize: 20),),
          SizedBox(height: 12,),
          Text('Railrelax - Enhancing train travel comfort',style: TextStyle(fontSize: 20),),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){}, child: Text('English')),
              ElevatedButton(onPressed: (){}, child: Text('Hindi')),
              ElevatedButton(onPressed: (){}, child: Text('Marathi')),
            ],
          )
        ],
      ),
    );
  }
}
