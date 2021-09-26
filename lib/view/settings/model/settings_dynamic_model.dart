class SettingsDynamicModel {
  final String? url;
  final String title;

  SettingsDynamicModel(this.title, {this.url});

  factory SettingsDynamicModel.fake() {
    return SettingsDynamicModel("Oğuzhan",
        url: "https://github.com/ibrahimoguzhany");
  }

  factory SettingsDynamicModel.fakeNull() {
    return SettingsDynamicModel("Oğuzhan");
  }
}
