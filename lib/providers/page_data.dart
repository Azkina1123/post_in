part of "providers.dart";

class PageData extends ChangeNotifier {
  int mainIndex = 0;

  void changeMainPage(int index) {
    mainIndex = index;
    notifyListeners();
  }

  int homeTabIndex = 0;
  void changeHomeTab(int index) {
    homeTabIndex = index;
    notifyListeners();
  }

  int followTabIndex = 0;
  void changeFollowTab(int index) {
    followTabIndex = index;
    notifyListeners();
  }

  void refreshPage() {
    notifyListeners();
  }

  void resetIndexPage() {
    mainIndex = 0;
    homeTabIndex = 0;
    followTabIndex = 0;
  }

  String keywordCari = "";
  void cari(String keyword) {
    keywordCari = keyword;
  }

  // focus tambah komentar ketika buka post page
  bool _komentarFocused = false;
  bool get komentarFocused => _komentarFocused;

  void changeKomentarFocus(bool value) {
    _komentarFocused = value;
    notifyListeners();
  }

  // snackbar hapus komentar
  bool _onSnackBar = false;
  bool get onSnackBar => _onSnackBar;

  void openSnackBar() {
    _onSnackBar = true;
  }

  void closeSnackBar() {
    _onSnackBar = false;
  }
}
