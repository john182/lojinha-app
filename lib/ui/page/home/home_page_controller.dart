import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/section_model.dart';
import 'package:loja_virtual/service/home_service.dart';

class HomePageController extends ChangeNotifier {
  List<SectionModel> sections = [];

  HomePageController() {
    _loadSections();
  }

  final HomeService _service = locator<HomeService>();

  Future<void> _loadSections() async {
    final querySnap = await _service.loadAll();

    sections =
        querySnap.docs.map((doc) => SectionModel.fromDocument(doc)).toList();

    notifyListeners();
  }
}
