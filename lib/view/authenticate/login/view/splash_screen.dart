import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:esd_mobil/view/home/view/home_view.dart';
import 'package:esd_mobil/view/inbox/view/inbox_view.dart';
import 'package:flutter/material.dart';

import 'login_via_azure_view.dart';
import 'login_view.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Hero(
              tag: "socarLogo",
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 1000),
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return LoginViaAzureView();
                      },
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return Align(
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Image.asset(
                  'assets/image/800pxlogo_of_socar1.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          // Text(
          //   'Emniyet Turu Uygulaması',
          //   textAlign: TextAlign.left,
          //   style: TextStyle(
          //     color: Color.fromRGBO(0, 0, 0, 1),
          //     fontFamily: 'Source Sans Pro',
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //     // height: 0.4,
          //   ),
          // ),
        ],
      ),
      animationDuration: Duration(milliseconds: 1800),
      curve: Curves.easeIn,
      nextScreen: HomeView(),
      splashTransition: SplashTransition.scaleTransition,
      splashIconSize: MediaQuery.of(context).size.width,
      centered: true,
      duration: 5,
    );
  }
}
