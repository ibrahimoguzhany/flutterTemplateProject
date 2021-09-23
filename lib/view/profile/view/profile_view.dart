import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/constants/navigation/navigation_constants.dart';
import 'package:fluttermvvmtemplate/core/init/navigation/navigation_service.dart';
import 'package:provider/provider.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/init/auth/authentication_provider.dart';
import '../../_product/_widgets/big_little_text_widget.dart';
import '../model/app_user._model.dart';
import '../service/profile_service.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  AppUser? user;

  ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    ProfileService.instance!
        .getUserById(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .then((value) {
      widget.user = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      viewModel: ProfileViewModel(),
      onModelReady: (ProfileViewModel model) async {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, ProfileViewModel viewModel) =>
          Scaffold(
        appBar: AppBar(
          title: Text("Profil Bilgilerim"),
          actions: [
            IconButton(
              onPressed: () async {
                NavigationService.instance
                    .navigateToPage(NavigationConstants.CHANGE_PASSWORD_VIEW);
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLittleTextWidget("Adı"),
              SizedBox(height: 5),
              buildBiggerDataTextWidget(widget.user?.name),
              buildLittleTextWidget("Soyadı"),
              SizedBox(height: 5),
              buildBiggerDataTextWidget(widget.user?.surname),
              buildLittleTextWidget("E-mail"),
              SizedBox(height: 5),
              buildBiggerDataTextWidget(widget.user?.email),
              buildLittleTextWidget("Şifre"),
              SizedBox(height: 5),
              buildBiggerDataTextWidget(widget.user?.password.toString()),
              SizedBox(
                height: 50,
              ),
              Center(
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    Provider.of<AuthenticationProvider>(context, listen: false)
                        .signOut(context);
                  },
                  label: Text("Çıkış Yap"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
