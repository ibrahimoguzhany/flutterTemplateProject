import 'package:esd_mobil/core/constants/navigation/navigation_constants.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

class ConfirmationInboxView extends StatelessWidget {
  const ConfirmationInboxView({Key? key}) : super(key: key);

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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 84),
            child: Hero(
              tag: "socarLogo",
              child: Image.asset('assets/image/800pxlogo_of_socar1.png'),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 20,
            child: SingleChildScrollView(
                child: Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(8),
                itemCount: 100,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              color: Colors.blue,
                              size: 32,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Onayla',
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 32,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Reddet',
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: direction == DismissDirection.endToStart
                            ? (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Reddet"),
                                  content: const Text(
                                      "Reddetmek istediğinize emin misiniz?"),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("Evet")),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Hayır"),
                                    ),
                                  ],
                                );
                              }
                            : (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Onayla"),
                                  content: const Text(
                                      "Onaylamak istediğinize emin misiniz?"),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("Evet")),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Hayır"),
                                    ),
                                  ],
                                );
                              },
                      );
                    },
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.startToEnd) {
                        print("Onaylandı");
                      } else {
                        print('Reddedildi');
                      }
                    },
                    key: Key(index.toString()),
                    child: Card(
                      color: Color(0xffFF6333).withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 8.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        child: ListTile(
                          onTap: () async {
                            await NavigationService.instance.navigateToPage(
                                NavigationConstants.CONFIRMATION_DETAIL_VIEW);
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
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
          SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {
                      NavigationService.instance
                          .navigateToPage(NavigationConstants.INBOX_VIEW);
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 42,
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Color(0xffF9EEDF),
                              foregroundColor: Colors.black,
                              child: Text("2"),
                            )
                          ],
                        ),
                        Text(
                          "Inbox",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {
                      NavigationService.instance
                          .navigateToPage(NavigationConstants.INBOX_VIEW);
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Icon(
                              Icons.notifications_none_outlined,
                              size: 42,
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Color(0xffF9EEDF),
                              foregroundColor: Colors.black,
                              child: Text("9"),
                            )
                          ],
                        ),
                        Text(
                          "Notifications",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          size: 42,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              )
            ],
          ),
          Spacer(flex: 1)
        ],
      ),
    );
  }
}


// actionPane: SlidableScrollActionPane(),
//                         actions: [
//                           IconSlideAction(
//                               caption: "Red",
//                               color: Colors.red,
//                               icon: Icons.delete,
//                               onTap: () {
//                                 print("Red");
//                               }),
//                           IconSlideAction(
//                               caption: "Onay",
//                               color: Colors.green,
//                               icon: Icons.approval_outlined,
//                               onTap: () {
//                                 print("onay");
//                               }),
//                           IconSlideAction(
//                               caption: "Vazgeç",
//                               color: Colors.grey[300],
//                               icon: Icons.cancel_outlined,
//                               onTap: () {
//                                 print("vazgec");
//                               }),
//                         ],
//                         actionExtentRatio: 1 / 4,