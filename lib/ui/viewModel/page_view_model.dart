import 'package:flutter/material.dart';

class PageViewModel {
  PageViewModel(this._pageController);

  final PageController _pageController;
  int page = 0;

  void setPage(int page) {
    if (this.page == page) return;
    this.page = page;
    _pageController.jumpToPage(this.page);
  }
}
