// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unplanned_tour_finding_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FindingDetailViewModel on _FindingDetailViewModelBase, Store {
  final _$filesAtom = Atom(name: '_FindingDetailViewModelBase.files');

  @override
  List<FindingFile> get files {
    _$filesAtom.reportRead();
    return super.files;
  }

  @override
  set files(List<FindingFile> value) {
    _$filesAtom.reportWrite(value, super.files, () {
      super.files = value;
    });
  }

  final _$findingFilesAtom =
      Atom(name: '_FindingDetailViewModelBase.findingFiles');

  @override
  List<FindingFile>? get findingFiles {
    _$findingFilesAtom.reportRead();
    return super.findingFiles;
  }

  @override
  set findingFiles(List<FindingFile>? value) {
    _$findingFilesAtom.reportWrite(value, super.findingFiles, () {
      super.findingFiles = value;
    });
  }

  final _$getFindingFilesAsyncAction =
      AsyncAction('_FindingDetailViewModelBase.getFindingFiles');

  @override
  Future<List<FindingFile>?> getFindingFiles(int findingId) {
    return _$getFindingFilesAsyncAction
        .run(() => super.getFindingFiles(findingId));
  }

  final _$uploadFindingFilesAsyncAction =
      AsyncAction('_FindingDetailViewModelBase.uploadFindingFiles');

  @override
  Future<void> uploadFindingFiles(int findingId) {
    return _$uploadFindingFilesAsyncAction
        .run(() => super.uploadFindingFiles(findingId));
  }

  final _$pickImageAsyncAction =
      AsyncAction('_FindingDetailViewModelBase.pickImage');

  @override
  Future<File?> pickImage(ImageSource imageSource) {
    return _$pickImageAsyncAction.run(() => super.pickImage(imageSource));
  }

  final _$_FindingDetailViewModelBaseActionController =
      ActionController(name: '_FindingDetailViewModelBase');

  @override
  void addFindingFiles(FindingFile file) {
    final _$actionInfo = _$_FindingDetailViewModelBaseActionController
        .startAction(name: '_FindingDetailViewModelBase.addFindingFiles');
    try {
      return super.addFindingFiles(file);
    } finally {
      _$_FindingDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFindingFiles() {
    final _$actionInfo = _$_FindingDetailViewModelBaseActionController
        .startAction(name: '_FindingDetailViewModelBase.clearFindingFiles');
    try {
      return super.clearFindingFiles();
    } finally {
      _$_FindingDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
files: ${files},
findingFiles: ${findingFiles}
    ''';
  }
}
