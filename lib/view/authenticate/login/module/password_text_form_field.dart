part of '../view/login_view.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    Key? key,
    required this.context,
    required this.viewModel,
  }) : super(key: key);

  final BuildContext context;
  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
          controller: viewModel.passwordController,
          obscureText: viewModel.isLockOpen,
          validator: (value) =>
              value!.isNotEmpty ? null : "Bu alan gereklidir.",
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(10),
            helperText: ' ',
            prefixIcon: buildContainerPasswordField(context, Icons.password),
            suffixIcon: Observer(builder: (_) {
              return InkWell(
                child: buildContainerPasswordField(context,
                    viewModel.isLockOpen ? Icons.lock : Icons.lock_open_sharp),
                onTap: () {
                  viewModel.isLockStateChange();
                },
              );
            }),
            labelText: "Şifre",
            labelStyle: context.textTheme.subtitle1,
          ));
    });
  }
}
