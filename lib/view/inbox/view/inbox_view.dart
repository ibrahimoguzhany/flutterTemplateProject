import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class InboxView extends StatelessWidget {
  const InboxView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9EEDF),
      appBar: AppBar(
        backgroundColor: Color(0xffF9EEDF),
        elevation: 0,
      ),
      body: Column(
        children: [
          Spacer(flex: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 84),
            child: Hero(
              tag: "socarLogo",
              child: Image.asset('assets/image/800pxlogo_of_socar1.png'),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 20,
            child: SingleChildScrollView(
                child: Container(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: 100,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xffFF6333),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      child: Slidable(
                        actionPane: SlidableScrollActionPane(),
                        actions: [
                          IconSlideAction(
                              caption: "Red",
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                print("Red");
                              }),
                          IconSlideAction(
                              caption: "Onay",
                              color: Colors.green,
                              icon: Icons.approval_outlined,
                              onTap: () {
                                print("onay");
                              }),
                          IconSlideAction(
                              caption: "Vazgeç",
                              color: Colors.grey[300],
                              icon: Icons.cancel_outlined,
                              onTap: () {
                                print("vazgec");
                              }),
                        ],
                        actionExtentRatio: 1 / 4,
                        child: ListTile(
                          leading: Text("ESBP"),
                          title: Text(
                            "STAD Terminal A By Pass Süresi ESD Yazılım Aracılığı İle By-pass",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),
          ),
          Expanded(
            child: Container(
              color: Color(0xffF9EEDF),
            ),
            flex: 4,
          )
        ],
      ),
    );
  }
}
