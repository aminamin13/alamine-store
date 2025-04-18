import 'package:al_amine_store/features/auth/presentation/pages/login/login_page.dart';
import 'package:al_amine_store/features/expenese/presentation/expenese_add_page.dart';
import 'package:al_amine_store/features/expenese/presentation/expenses_page.dart';
import 'package:al_amine_store/features/home/controller/home_controller.dart';
import 'package:al_amine_store/features/home/presentation/home_page.dart';
import 'package:al_amine_store/features/price_list/presentation/pages/edit_product_detail_page.dart';
import 'package:al_amine_store/features/price_list/presentation/pages/price_list_page.dart';
import 'package:al_amine_store/features/price_list/presentation/pages/product_detail_page.dart';
import 'package:al_amine_store/features/products/presentation/pages/add_a_product_page.dart';
 import 'package:al_amine_store/features/sales/presentation/sales_page.dart';
import 'package:al_amine_store/features/splash/presentation/splash_page.dart';
import 'package:al_amine_store/features/tables/presentation/expenses_table.dart';
import 'package:al_amine_store/features/tables/presentation/sales_table.dart';
import 'package:al_amine_store/features/tables/presentation/tables_page.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/middleware/mymiddleware.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: AppRoute.splashPage,
    page: () => const SplashPage(),
    middlewares: [MyMiddleWare()],
  ),
  GetPage(
    name: AppRoute.loginPage,
    page: () => const LoginPage(),
  ),
  GetPage(
    name: AppRoute.addAProductPage,
    page: () => const AddAProductPage(),
  ),
  GetPage(
    name: AppRoute.priceListPage,
    page: () => const PriceListPage(),
  ),
  GetPage(
    name: AppRoute.homePage,
    page: () {
      return const HomePage();
    },
    binding: BindingsBuilder(() {
      Get.lazyPut<HomeController>(() => HomeControllerImpl());
    }),
  ),
  GetPage(
      name: AppRoute.editProductDetails,
      page: () => const EditProductDetailPage()),
  GetPage(name: AppRoute.productDetails, page: () => const ProductDetailPage()),
  GetPage(name: AppRoute.sales, page: () => const SalesPage()),
  GetPage(name: AppRoute.expenese, page: () => const ExpensesPage()),
  GetPage(name: AppRoute.addExpenese, page: () => const ExpeneseAddPage()),
   GetPage(name: AppRoute.salesTablePage, page: () => const SalesTable()),
  GetPage(name: AppRoute.tablesPage, page: () => const TablesPage()),
  GetPage(name: AppRoute.expeneseTablePage, page: () => const ExpensesTable()),
];
