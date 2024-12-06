import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    categories.add(CategoryModel(
        name: 'Canai Bread',
        iconPath: 'assets/icons/canai-bread.svg',
        boxColor: const Color.fromARGB(255, 210, 255, 7)));

    categories.add(CategoryModel(
        name: 'H-Pancake',
        iconPath: 'assets/icons/honey-pancakes.svg',
        boxColor: const Color.fromARGB(255, 67, 242, 9)));
    categories.add(CategoryModel(
        name: 'Pie',
        iconPath: 'assets/icons/pie.svg',
        boxColor: const Color.fromARGB(255, 235, 29, 146)));
    categories.add(CategoryModel(
        name: 'Cake',
        iconPath: 'assets/icons/pancakes.svg',
        boxColor: const Color.fromARGB(213, 215, 96, 11)));

    return categories;
  }
}
