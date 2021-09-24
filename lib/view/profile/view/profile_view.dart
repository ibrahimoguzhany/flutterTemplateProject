import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/auth/authentication_provider.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../_product/_widgets/big_little_text_widget.dart';
import '../model/app_user._model.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late String currentUserId;
  @override
  void initState() {
    super.initState();
    currentUserId = Provider.of<AuthenticationProvider>(context, listen: false)
        .firebaseAuth
        .currentUser!
        .uid;
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
        body: FutureBuilder(
            future: viewModel.getUserById(currentUserId),
            builder: (BuildContext context, AsyncSnapshot<AppUser> snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLittleTextWidget("Adı"),
                      buildBiggerDataTextWidget(snapshot.data!.name),
                      buildLittleTextWidget("Soyadı"),
                      buildBiggerDataTextWidget(snapshot.data!.surname),
                      buildLittleTextWidget("E-mail"),
                      buildBiggerDataTextWidget(snapshot.data!.email),
                      buildLittleTextWidget("Şifre"),
                      buildPasswordField(viewModel, snapshot),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            Provider.of<AuthenticationProvider>(context,
                                    listen: false)
                                .signOut(context);
                          },
                          label: Text("Çıkış Yap"),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget buildPasswordField(
          ProfileViewModel viewModel, AsyncSnapshot<AppUser> snapshot) =>
      Observer(builder: (_) {
        return TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: InkWell(
                  onTap: viewModel.isLockOpenChange,
                  child: Icon(
                      viewModel.isLockOpen ? Icons.lock : Icons.lock_open))),
          initialValue: snapshot.data!.password.toString(),
          obscureText: viewModel.isLockOpen,
          readOnly: true,
        );
      });
}
