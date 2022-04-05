import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Sidebar extends StatelessWidget {
  String name = " ";
  Sidebar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          
            child: Center(
              child: Column(
                  children: [
                    const CircleAvatar(backgroundColor: Colors.black87,radius: 50),
                    const SizedBox(height: 2,),
                    Text("Hoşgeldin $name",style: const TextStyle(fontSize: 24),)
                    
                  ],
              ),
            ),),

        ListTile(
          title: const Text('Support Us'),
          onTap: () {
            Navigator.pushNamed(context, "/support");
          },
        ),
        ListTile(
          title: const Text('About Us'),
          onTap: () {
            Navigator.pushNamed(context, "/about");
            

          },
        ),
      ],
    ));
  }
}
