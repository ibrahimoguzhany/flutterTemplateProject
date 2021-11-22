import 'package:flutter/material.dart';

import '../../../../core/constants/image/image_constants.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9EEDF),
      body: Column(
        children: [
          Spacer(
            flex: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 84),
            child: Hero(
              tag: "socarLogo",
              child: Image.asset(
                ImageConstants.instance!.toPng("800pxlogo_of_socar1"),
              ),
            ),
          ),
          Spacer(
            flex: 6,
          ),
          Container(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xfffe7144),
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF9EEDF),
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: InkWell(
                        onTap: () async => await NavigationService.instance
                            .navigateToPageClear(
                                NavigationConstants.TOURS_HOME_VIEW),
                        child: Center(
                          child: Text(
                            "Saha Ziyaret Planlama Uygulaması",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF9EEDF),
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Center(
                        child: Text(
                          "Emniyet Sistemleri Bakım Planlama Uygulaması",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF9EEDF),
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Center(
                        child: Text(
                          "Uygulama 3",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF9EEDF),
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Center(
                        child: Text(
                          "Uygulama 4",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Spacer(
            flex: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 2,
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
                              size: 52,
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
                          "Gelen Kutusu",
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
                          .navigateToPage(NavigationConstants.SETTINGS_VIEW);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.settings_outlined, size: 52),
                        Text(
                          "Ayarlar",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              )
            ],
          ),
          Spacer(flex: 2)
        ],
      ),
    );
  }
}
