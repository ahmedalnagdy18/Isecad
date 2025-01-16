// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `AR`
  String get dropdown1 {
    return Intl.message(
      'AR',
      name: 'dropdown1',
      desc: '',
      args: [],
    );
  }

  /// `EN`
  String get dropdown2 {
    return Intl.message(
      'EN',
      name: 'dropdown2',
      desc: '',
      args: [],
    );
  }

  /// `All Products`
  String get allProducts {
    return Intl.message(
      'All Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Search Products`
  String get searchProducts {
    return Intl.message(
      'Search Products',
      name: 'searchProducts',
      desc: '',
      args: [],
    );
  }

  /// `Product added:`
  String get productAdded {
    return Intl.message(
      'Product added:',
      name: 'productAdded',
      desc: '',
      args: [],
    );
  }

  /// `Product updated:`
  String get productUpdated {
    return Intl.message(
      'Product updated:',
      name: 'productUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Product deleted successfully.`
  String get productDeletedSuccessfully {
    return Intl.message(
      'Product deleted successfully.',
      name: 'productDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No products available.`
  String get noProductsAvailable {
    return Intl.message(
      'No products available.',
      name: 'noProductsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields correctly!`
  String get pleaseFillAllFieldsCorrectly {
    return Intl.message(
      'Please fill all fields correctly!',
      name: 'pleaseFillAllFieldsCorrectly',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get invoice {
    return Intl.message(
      'Invoice',
      name: 'invoice',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Details`
  String get invoiceDetails {
    return Intl.message(
      'Invoice Details',
      name: 'invoiceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Select quantity`
  String get selectQuantity {
    return Intl.message(
      'Select quantity',
      name: 'selectQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Price per Unit`
  String get pricePerUnit {
    return Intl.message(
      'Price per Unit',
      name: 'pricePerUnit',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message(
      'Total Price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Return to Products`
  String get returnToProducts {
    return Intl.message(
      'Return to Products',
      name: 'returnToProducts',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message(
      'Add Product',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product ID`
  String get productID {
    return Intl.message(
      'Product ID',
      name: 'productID',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get productPrice {
    return Intl.message(
      'Product Price',
      name: 'productPrice',
      desc: '',
      args: [],
    );
  }

  /// `Product Quantity`
  String get productQuantity {
    return Intl.message(
      'Product Quantity',
      name: 'productQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Generate Today's Report`
  String get generate_todays_report {
    return Intl.message(
      'Generate Today\'s Report',
      name: 'generate_todays_report',
      desc: '',
      args: [],
    );
  }

  /// `Generate Report for a Specific Date`
  String get generate_specific_date_report {
    return Intl.message(
      'Generate Report for a Specific Date',
      name: 'generate_specific_date_report',
      desc: '',
      args: [],
    );
  }

  /// `Generate All Sales Report`
  String get generate_all_sales_report {
    return Intl.message(
      'Generate All Sales Report',
      name: 'generate_all_sales_report',
      desc: '',
      args: [],
    );
  }

  /// `Sales Report`
  String get sales_report {
    return Intl.message(
      'Sales Report',
      name: 'sales_report',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
