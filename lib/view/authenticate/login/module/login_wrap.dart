import 'package:esd_mobil/core/constants/image/image_constants.dart';
import 'package:esd_mobil/core/constants/navigation/navigation_constants.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';
import 'package:esd_mobil/view/authenticate/login/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginWrap extends StatelessWidget {
  const LoginWrap({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: [
                Observer(builder: (_) {
                  return Checkbox(
                    value: viewModel.rememberMeIsCheckhed,
                    onChanged: viewModel.changeIsChecked,
                  );
                }),
                Text("Beni Hatırla"),
                Spacer(
                  flex: 2,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Şifremi Unuttum",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text("Diğer Giriş Seçenekleri"),
                InkWell(
                  onTap: () {
                    NavigationService.instance.navigateToPage(
                        NavigationConstants.LOGIN_VIA_AZURE_VIEW);
                  },
                  child: Image.asset(
                    ImageConstants.instance!.toPng("microsoftLogo"),
                    width: 100,
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
