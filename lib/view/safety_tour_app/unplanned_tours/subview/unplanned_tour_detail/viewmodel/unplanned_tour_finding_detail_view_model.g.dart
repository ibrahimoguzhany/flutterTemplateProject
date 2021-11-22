// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unplanned_tour_finding_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FindingDetailViewModel on _FindingDetailViewModelBase, Store {
  final _$filesAtom = Atom(name: '_FindingDetailViewModelBase.files');

  @override
  List<File> get files {
    _$filesAtom.reportRead();
    return super.files;
  }

  @override
  set files(List<File> value) {
    _$filesAtom.reportWrite(value, super.files, () {
      super.files = value;
    });
  }

  final _$fileAtom = Atom(name: '_FindingDetailViewModelBase.file');

  @override
  File get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(File value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
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
  Future<void> uploadFindingFiles(List<File> files, int findingId, int tourId) {
    return _$uploadFindingFilesAsyncAction
        .run(() => super.uploadFindingFiles(files, findingId, tourId));
  }

  final _$deleteFindingFileAsyncAction =
      AsyncAction('_FindingDetailViewModelBase.deleteFindingFile');

  @override
  Future<bool> deleteFindingFile(int findingId, String fileName) {
    return _$deleteFindingFileAsyncAction
        .run(() => super.deleteFindingFile(findingId, fileName));
  }

  final _$pickImageAsyncAction =
      AsyncAction('_FindingDetailViewModelBase.pickImage');

  @override
  Future<File?> pickImage(ImageSource imageSource) {
    return _$pickImageAsyncAction.run(() => super.pickImage(imageSource));
  }

  @override
  String toString() {
    return '''
files: ${files},
file: ${file},
findingFiles: ${findingFiles}
    ''';
  }
}
