class ConfirmationModel {
  String? formCreator;
  String? company;
  String? unit;
  String? safetySystemStatement;
  String? bypassReason;
  String? safetySystemType;
  String? tripParameterTagNo;
  String? safetySystemSubType;
  String? estimatedBypassTime;
  String? peopleWhoBypass;
  String? appName;

  ConfirmationModel(
      {this.formCreator,
      this.company,
      this.unit,
      this.safetySystemStatement,
      this.bypassReason,
      this.safetySystemType,
      this.tripParameterTagNo,
      this.safetySystemSubType,
      this.estimatedBypassTime,
      this.peopleWhoBypass,
      this.appName});

  ConfirmationModel.fromJson(Map<String, dynamic> json) {
    formCreator = json['formCreator'];
    company = json['company'];
    unit = json['unit'];
    safetySystemStatement = json['safetySystemStatement'];
    bypassReason = json['bypassReason'];
    safetySystemType = json['safetySystemType'];
    tripParameterTagNo = json['tripParameterTagNo'];
    safetySystemSubType = json['safetySystemSubType'];
    estimatedBypassTime = json['estimatedBypassTime'];
    peopleWhoBypass = json['peopleWhoBypass'];
    appName = json['appName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formCreator'] = this.formCreator;
    data['company'] = this.company;
    data['unit'] = this.unit;
    data['safetySystemStatement'] = this.safetySystemStatement;
    data['bypassReason'] = this.bypassReason;
    data['safetySystemType'] = this.safetySystemType;
    data['tripParameterTagNo'] = this.tripParameterTagNo;
    data['safetySystemSubType'] = this.safetySystemSubType;
    data['estimatedBypassTime'] = this.estimatedBypassTime;
    data['peopleWhoBypass'] = this.peopleWhoBypass;
    data['appName'] = this.appName;
    return data;
  }
}

class ConfirmationList {
  static List<ConfirmationModel> _confirmationList = [
    ConfirmationModel(
      bypassReason: 'Bypass Reason 1',
      safetySystemSubType: 'Safety System Sub Type 1',
      company: 'Company 1',
      estimatedBypassTime: 'Estimated Bypass Time 1',
      formCreator: 'Form Creator 1',
      safetySystemType: 'Safety System Type 1',
      safetySystemStatement: 'Safety System Statement 1',
      unit: 'Unit 1',
      tripParameterTagNo: 'Trip Parameter Tag No 1',
      peopleWhoBypass: 'People Who Bypass 1',
      appName: 'App Name 1',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 2',
      safetySystemSubType: 'Safety System Sub Type 2',
      company: 'Company 2',
      estimatedBypassTime: 'Estimated Bypass Time 2',
      formCreator: 'Form Creator 2',
      safetySystemType: 'Safety System Type 2',
      safetySystemStatement: 'Safety System Statement 2',
      unit: 'Unit 2',
      tripParameterTagNo: 'Trip Parameter Tag No 2',
      peopleWhoBypass: 'People Who Bypass 2',
      appName: 'App Name 2',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 3',
      safetySystemSubType: 'Safety System Sub Type 3',
      company: 'Company 3',
      estimatedBypassTime: 'Estimated Bypass Time 3',
      formCreator: 'Form Creator 3',
      safetySystemType: 'Safety System Type 3',
      safetySystemStatement: 'Safety System Statement 3',
      unit: 'Unit 3',
      tripParameterTagNo: 'Trip Parameter Tag No 3',
      peopleWhoBypass: 'People Who Bypass 3',
      appName: 'App Name 3',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 4',
      safetySystemSubType: 'Safety System Sub Type 4',
      company: 'Company 4',
      estimatedBypassTime: 'Estimated Bypass Time 4',
      formCreator: 'Form Creator 4',
      safetySystemType: 'Safety System Type 4',
      safetySystemStatement: 'Safety System Statement 4',
      unit: 'Unit 4',
      tripParameterTagNo: 'Trip Parameter Tag No 4',
      peopleWhoBypass: 'People Who Bypass 4',
      appName: 'App Name 4',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 5',
      safetySystemSubType: 'Safety System Sub Type 5',
      company: 'Company 5',
      estimatedBypassTime: 'Estimated Bypass Time 5',
      formCreator: 'Form Creator 5',
      safetySystemType: 'Safety System Type 5',
      safetySystemStatement: 'Safety System Statement 5',
      unit: 'Unit 5',
      tripParameterTagNo: 'Trip Parameter Tag No 5',
      peopleWhoBypass: 'People Who Bypass 5',
      appName: 'App Name 5',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 6',
      safetySystemSubType: 'Safety System Sub Type 6',
      company: 'Company 6',
      estimatedBypassTime: 'Estimated Bypass Time 6',
      formCreator: 'Form Creator 6',
      safetySystemType: 'Safety System Type 6',
      safetySystemStatement: 'Safety System Statement 6',
      unit: 'Unit 6',
      tripParameterTagNo: 'Trip Parameter Tag No 6',
      peopleWhoBypass: 'People Who Bypass 6',
      appName: 'App Name 6',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 7',
      safetySystemSubType: 'Safety System Sub Type 7',
      company: 'Company 7',
      estimatedBypassTime: 'Estimated Bypass Time 7',
      formCreator: 'Form Creator 7',
      safetySystemType: 'Safety System Type 7',
      safetySystemStatement: 'Safety System Statement 7',
      unit: 'Unit 7',
      tripParameterTagNo: 'Trip Parameter Tag No 7',
      peopleWhoBypass: 'People Who Bypass 7',
      appName: 'App Name 7',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 8',
      safetySystemSubType: 'Safety System Sub Type 8',
      company: 'Company 8',
      estimatedBypassTime: 'Estimated Bypass Time 8',
      formCreator: 'Form Creator 8',
      safetySystemType: 'Safety System Type 8',
      safetySystemStatement: 'Safety System Statement 8',
      unit: 'Unit 8',
      tripParameterTagNo: 'Trip Parameter Tag No 8',
      peopleWhoBypass: 'People Who Bypass 8',
      appName: 'App Name 8',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 9',
      safetySystemSubType: 'Safety System Sub Type 9',
      company: 'Company 9',
      estimatedBypassTime: 'Estimated Bypass Time 9',
      formCreator: 'Form Creator 9',
      safetySystemType: 'Safety System Type 9',
      safetySystemStatement: 'Safety System Statement 9',
      unit: 'Unit 9',
      tripParameterTagNo: 'Trip Parameter Tag No 9',
      peopleWhoBypass: 'People Who Bypass 9',
      appName: 'App Name 9',
    ),
    ConfirmationModel(
      bypassReason: 'Bypass Reason 10',
      safetySystemSubType: 'Safety System Sub Type 10',
      company: 'Company 10',
      estimatedBypassTime: 'Estimated Bypass Time 10',
      formCreator: 'Form Creator 10',
      safetySystemType: 'Safety System Type 10',
      safetySystemStatement: 'Safety System Statement 10',
      unit: 'Unit 10',
      tripParameterTagNo: 'Trip Parameter Tag No 10',
      peopleWhoBypass: 'People Who Bypass 10',
      appName: 'App Name 10',
    ),
  ];

  static List<ConfirmationModel> get confirmationList => _confirmationList;
}
