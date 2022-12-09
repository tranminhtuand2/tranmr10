import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/admin/crudthongtin/coffee/admin_coffee.dart';
import 'package:coffemanger/admin/crudthongtin/gasdrink/admin_gasdrinks.dart';
import 'package:coffemanger/admin/crudthongtin/healthydrink/admin_healthy.dart';
import 'package:coffemanger/admin/crudthongtin/millteas/admin_milkteas.dart';
import 'package:flutter/material.dart';

class AdminCategroies extends StatelessWidget {
  final String admin;
  const AdminCategroies({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Manager Product:${admin}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.8,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 2,
          ),
          children: [
            GestureDetector(
              onTap: () {
                print("admin coffee");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => crudcoffee(title: "coffee"),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.brown,
                ),
                child: Center(child: Text("Coffee ")),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("admin healthy");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => crudhealthy(title: "healthy"),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 106, 202, 119),
                ),
                child: Center(child: Text("healthy ")),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("admin teas");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => crudmilkteas(title: "milk teas"),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                ),
                child: Center(child: Text("milk teas")),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("admin gas drinks");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => crudgasdrinks(title: "gas drinks"),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: Center(child: Text("gas drinks")),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
