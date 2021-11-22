import 'package:flutter/material.dart';
import '../../../../core/components/button/title_text_button.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key, required this.onComplete}) : super(key: key);

  final Function(FacebookModel? data, {String? errorMessage}) onComplete;

  @override
  Widget build(BuildContext context) {
    return TitleTextButton(
      onPressed: () {
        final isLenghSixCharacter = "SADSADSA".length == 6;
        if (isLenghSixCharacter) {
          this.onComplete(FacebookModel("Asdas", "dasdsa"));
        } else {
          this.onComplete(null, errorMessage: "Facebook user not found");
        }
      },
      text: "Facebook login",
    );
  }
}

class FacebookModel {
  final String token;
  final mail;

  FacebookModel(this.token, this.mail);
}
