class AppLink {
  static const String server = 'https://amineamine.com/amine_store';

  //==================Products===========================

  static const String addProduct = '$server/items/add.php';
  static const String viewProduct = '$server/items/view.php';
  static const String deleteProduct = '$server/items/delete.php';
  static const String editProduct = '$server/items/edit.php';
  static const String maxProductId = '$server/items/max_id.php';
  static const String editCountNumber = '$server/items/edit_number.php';

  //==================images===========================
  static const String imagestatic = 'https://amineamine.com/amine_store/upload';
  static const String addImages = '$server/items/add_images.php';
  static const String viewImages = '$server/items/view_images.php';
  static const String imageitems = '$imagestatic/items';

//==================sales===========================
  static const String addSales = '$server/sales/add.php';
  static const String viewSales = '$server/sales/view.php';
  static const String deleteSales = '$server/sales/delete.php';

  //==================expenses===========================
  static const String addExpenses = '$server/expenses/add.php';
  static const String viewExpenses = '$server/expenses/view.php';
  static const String deleteExpenses = '$server/expenses/delete.php';

  // ======================== Auth ===========================//

  static const String signIn = '$server/auth/signin.php';
  static const String getUsersDetails = '$server/auth/getuserdata.php';

}
