import 'package:flutter/material.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact List",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      width: 400,
                      child: ListTile(
                        title: Text('Ristu Adhikary'),
                        subtitle: Text('7063783821'),
                        trailing: Icon(Icons.arrow_forward_ios_sharp),
                        leading: Icon(Icons.account_circle),
                        style: ListTileStyle.list,
                        selected: true,
                        selectedColor: Colors.black,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 227, 227, 227),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
