import 'package:flutter/material.dart';
import 'package:food_order2/layout/cubit/cubit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_color_generator/material_color_generator.dart';
import '../../models/DataModel.dart';

MaterialColor defaultColor(context) {
  return !HomeCubit.get(context).isDark
      ? generateMaterialColor(color: HexColor('#d1cac4'))
      : Colors.grey;
}

const url = 'http://192.168.43.110:5000';
List<Map> sendCart = [];

List<CategoriesModel> categories_test = [
  CategoriesModel(
    id: 0,
    categoryName: 'sweets',
  ),
  CategoriesModel(
    id: 1,
    categoryName: 'launch',
  ),
  CategoriesModel(
    id: 2,
    categoryName: 'breakfast',
  ),
];
List<ProductModel> products_test = [
  ProductModel(
      id: 0,
      productName: 'new meal',
      price: 35000,
      description: 'alakla aljadeda',
      image: 'assets/images/الاكلة الجديدة.jpg',
      categoryId: 0,
      categoryName: 'sweets'),
  ProductModel(
      id: 5,
      productName: 'Ice kinder cake',
      price: 35000,
      description: 'Ice kinder',
      image: 'assets/images/facebook_1685806844865_7070786392646599246.jpg',
      categoryId: 0,
      categoryName: 'sweets'),
  ProductModel(
      id: 2,
      productName: 'shish',
      price: 35000,
      description: 'shish',
      image: 'assets/images/شيش.jpg',
      categoryId: 1,
      categoryName: 'launch'),
  ProductModel(
      id: 3,
      productName: 'burger',
      price: 35000,
      description: 'burger dogs meat',
      image: 'assets/images/برغر.jpg',
      categoryId: 1,
      categoryName: 'launch'),
  ProductModel(
      id: 4,
      productName: 'crispy',
      price: 35000,
      description: 'crispy fresh checken',
      image: 'assets/images/كريسبي.jpg',
      categoryId: 1,
      categoryName: 'launch'),
  ProductModel(
      id: 6,
      productName: 'egg',
      price: 45000,
      description: '',
      image: 'assets/images/images.jpeg',
      categoryId: 2,
      categoryName: 'breakfast'),
];
