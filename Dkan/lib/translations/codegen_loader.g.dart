// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "hi_text": "مرحباً مرةً أخرى",
  "login_message": "سجل دخولك لترى احدث العروض في دكان",
  "login": "تسجيل الدخول",
  "register": "التسجيل",
  "register_message": "سجل الآن للدخول إلى تطبيق دكان",
  "categories": "التصنيفات",
  "products": "المنتجات",
  "favorites": "المفضلة",
  "home": "الصفحة الرئيسية",
  "settings": "الإعدادات",
  "update_profile": "حدث معلومات حسابك",
  "lang": "اللُّغة",
  "info": "معلوماتك",
  "logout": "تسجيل الخروج",
  "overview": "نظرة عامة",
  "order_message": "يستغرق الطلب 3 أيام",
  "offer_details": "تفاصيل العرض",
  "offer_details_message_1": "استمتع بإرجاع مجاني مع هذا العرض",
  "offer_details_message_2": "سنة واحدة كفالة",
  "profile": "الملف الشخصي",
  "lang_message": "اختر اللغة",
  "name": "الاسم",
  "password": "كلمة المرور",
  "phone": "رقم الهاتف",
  "email": "البريد الإلكتروني"
};
static const Map<String,dynamic> en = {
  "hi_text": "Hello Again!",
  "login_message": "login to see the latest offers in dkan",
  "login": "LOGIN",
  "register": "REGISTER",
  "register_message": "register now to enter Dkan app",
  "categories": "Categories",
  "products": "Products",
  "favorites": "Favorites",
  "home": "Home",
  "settings": "settings",
  "update_profile": "update your profile",
  "lang": "language",
  "info": "your info",
  "logout": "logout",
  "overview": "Overview",
  "order_message": "order takes 3 days",
  "offer_details": "offer details",
  "offer_details_message_1": "enjoy free returns with this offer",
  "offer_details_message_2": "1 year warranty",
  "profile": "Profile",
  "lang_message": "Choose the language",
  "name": "name",
  "password": "password",
  "phone": "phone number",
  "email": "email"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
