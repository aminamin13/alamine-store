import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en': {
          "1": "AL Amine Store",
          "2": "Welcome to AL Amine Store App",
          "3": "Email",
          "4": "Password",
          "5": "Forgot Password?",
          "6": "Login",
          //home Page
          "7": "Welcome Back Dear",
          "8": "Search",
          "9": "Main Menu",
          "10": "Add a Product",
          "11": "Price List",
          "12": "Sales",
          "13": "Expenses",
          "14": "Tables",
          "144": "Sales Table",
          "145": "Expenses Table",
          "15": "Logout",
          // add a product page
          "16": "Add a Product",
          "17": "Car Type",
          "18": "Item Year",
          "19": "Item Color",
          "20": "Item Name",
          "21": "Item Location",
          "22": "Item Price",
          "23": "Item Sell Price",
          "99": "Count",
          "100": "1,2...",
          "24": "Notes",
          "25": "Add Images",
          "26": "Add Product",
          "27": "Failed to load data",
          "28": "Nissan, Toyota, etc.",
          "29": "2001, 2002, 2003",
          "30": "Red, Blue, etc",
          "31": "Left Door, Right Door, etc",
          "32": "Write your notes here",

          //Validations
          "33": " is required.",
          "34": "Success",
          "35": "Product Added",
          "36": "Error",
          "37": "Failed to add product",
          "38": "An error occurred",
          "39": "No Images Selected",
          "40": "Warning",
          "41": "Failed to pick images",

          // price list page
          "42": "No products available",
          "43": "Sold",
          "44": "Available",
          "45": "Price",
          "46": "Sell Price",
          "47": "Total Items added",
          // product details page
          "48": "Product Details",
          "49": "Item Name: ",
          "50": "Item Year: ",
          "51": "Car Type: ",
          "52": "Item Location: ",
          "53": "Item Color: ",
          "54": "Item Price: ",
          "101": "Item Count: ",

          "55": "Item Sell Price: ",
          "56": "Notes: ",
          "57": "Customer Details",
          "58": "Please Enter the customer details in the form below",
          "59": "Customer Name",
          "60": "Mahdi Amine, etc",
          "61": "Item Price",
          "62": "Cancel",
          "63": "Save",
          "64": "Sell Product",
          "65": "Edit Product",
          "66": "Delete Product",
          "67": "Are you sure you want to delete this product?",
          "68": "Delete",

          //edit product page
          "69": "Edit Product",

          //sales page

          "70": "No sales available in ",
          "71": "Sold to ",
          "72": "Sold on ",
          "73": "Sell Price: ",
          "74": "Profit: ",
          //expenses

          "75": "No expenses available in ",
          "76": "Paid on ",
          "77": "Expense amount: ",
          "78": "Add an Expense",
          "79": "Expense Name",
          "80": "Salary, Electricity, etc",
          "81": "Expense Amount",
          "82": "Expense Location",
          "83": "Notes",
          "84": "Write your notes here",
          "85": "Add Expense",

          //login controller

          "86": "The username or password is not correct",

          //expense controller

          "87": "Expense Added",
          "88": "Failed to add expense",
          "89": "An error occurred",
          "90": "Expense Deleted",

          // edit product controller

          "91": "Product Updated",
          "92": "Failed to update product",

          //product detail controller
          "93": "Product Sold Successfully",
          "94": "Failed to sell product",
          "95": "An error occurred",
          "96": "Failed to delete product",
          "97": "An error occurred while deleting",

          //sales controller
          "98": "Deleted Successfully",
        },
        'ar': {
          "1": "كسر الامين",
          "2": "مرحبا بك في تطبيق كسر الامين",
          "3": "البريد الالكتروني",
          "4": "كلمة المرور",
          "5": "نسيت كلمة المرور؟",
          "6": "تسجيل الدخول",
          //home Page
          "7": "مرحبا بعودتك",
          "8": "بحث",
          "9": "القائمة الرئيسية",
          "10": "اضافة منتج",
          "11": "قائمة الاسعار",
          "12": "المبيعات",
          "13": "المصروفات",
          "14": "جداول",
          "144": "جدول المبيعات",
          "145": "جدول المصروفات",
          "15": "تسجيل الخروج",
          // add a product page
          "16": "اضافة منتج",
          "17": "نوع السيارة",
          "18": "سنة المنتج",
          "19": "لون المنتج",
          "20": "اسم المنتج",
          "21": "موقع المنتج",
          "22": "سعر المنتج",
          "23": "سعر بيع المنتج",
          "24": "ملاحظات",
          "99": "العدد",
          "100": "١،٢",
          "25": "اضافة صور",
          "26": "اضافة المنتج",
          "27": "فشل تحميل البيانات",
          "28": "نيسان, تويوتا...",
          "29": "٢٠٠١، ٢٠٠٢، ٢٠٠٣",
          "30": "احمر, ازرق...",
          "31": "باب يسار, باب يمين...",
          "32": "اكتب ملاحظاتك هنا",

          //Validations
          "33": " مطلوب.",
          "34": "نجاح",
          "35": "تم اضافة المنتج",
          "36": "خطأ",
          "37": "فشل اضافة المنتج",
          "38": "حدث خطأ",
          "39": "لم يتم اختيار صور",
          "40": "تحذير",
          "41": "فشل في اختيار الصور",

          // price list page
          "42": "لا يوجد منتجات متاحة",
          "43": "مباع",
          "44": "متوفر",
          "45": "سعر",
          "46": "سعر بيع",
          "47": "عدد العناصر المضافة",

          // product details page
          "48": "تفاصيل المنتج",
          "49": "اسم المنتج: ",
          "50": "سنة المنتج: ",
          "51": "نوع السيارة: ",
          "52": "موقع المنتج: ",
          "53": "لون المنتج: ",
          "54": "سعر المنتج: ",
          "101": "عدد القطعة: ",
          "55": "سعر بيع المنتج: ",
          "56": "ملاحظات: ",
          "57": "تفاصيل العميل",
          "58": "الرجاء إدخال تفاصيل العميل في النموذج أدناه",
          "59": "اسم العميل",
          "60": "مهدي أمين، إلخ",
          "61": "سعر القطعة",
          "62": "إلغاء",
          "63": "حفظ",
          "64": "بيع المنتج",
          "65": "تعديل المنتج",
          "66": "حذف المنتج",
          "67": "هل أنت متأكد أنك تريد حذف هذا المنتج؟",
          "68": "حذف",
          // edit product page
          "69": "تعديل المنتج",
          // sales page

          "70": "لا توجد مبيعات متوفرة في ",
          "71": "تم البيع لـ",
          "72": "تم البيع في ",
          "73": "سعر البيع ",
          "74": "الربح: ",
          "75": "لا يوجد مصاريف متاحة",
          "76": "تم الدفع في",
          "77": "قيمة الدفعة",
          "78": 'إضافة مصاريف',
          "79": 'اسم المصروف',
          "80": "الراتب، الكهرباء، إلخ",
          "81": 'قيمة المصروف',
          "82": "مكان المصروف",
          "83": "الملاحظات",
          "84": "اكتب ملاحظاتك هنا",
          "85": "إضافة المصروف",

          // login page
          "86": "اسم المستخدم أو كلمة المرور غير صحيحة",

          "87": " تم إضافة المصروف",
          "88": "فشل في إضافة المصروف",
          "89": "حدث خطأ",
          "90": "تم حذف المصروف",

          "91": "تم تحديث المنتج",
          "92": "فشل تحديث المنتج",

          "93": "تم بيع المنتج بنجاح",
          "94": "فشل في بيع المنتج",
          "95": "حدث خطأ",
          "96": "فشل في حذف المنتج",
          "97": "حدث خطأ أثناء الحذف",

          "98": "تم الحذف بنجاح",
        },
      };
}
