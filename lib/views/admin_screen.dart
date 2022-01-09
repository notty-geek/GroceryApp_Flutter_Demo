import 'package:flutter/material.dart';
import 'Home.dart';
class AdminPage extends StatelessWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin'), centerTitle: true,),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: CircleAvatar(backgroundColor: Colors.blue,),),
            ListTile(title: Text('Edit Products'), onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(isAdminLogin: true,)));
            })
          ],
        ),
      ),
    );
  }
}
