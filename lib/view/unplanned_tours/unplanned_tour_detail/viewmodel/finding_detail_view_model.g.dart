// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finding_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FindingDetailViewModel on _FindingDetailViewModelBase, Store {
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

  @override
  String toString() {
    return '''
findingFiles: ${findingFiles}
    ''';
  }
}
