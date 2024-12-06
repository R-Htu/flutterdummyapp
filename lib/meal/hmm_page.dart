import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_app/meal/category_model.dart';
import 'package:page_app/meal/popular_model.dart';
import 'package:page_app/meal/diet_model.dart';

class HmmPage extends StatelessWidget {
  HmmPage({super.key});

  List<CategoryModel> categoriesNew = [];
  List<DietModel> dietsNew = [];
  List<PopularDietsModel> popularDietsNew = [];

  void _getInitialInfo() {
    categoriesNew = CategoryModel.getCategories();
    dietsNew = DietModel.getDiets();
    popularDietsNew = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 223, 227),
        title: const Text(
          'Dummy App',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xffFFFFFF)),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          // Background Image with Opacity
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/flowers.jpeg'), // Change this to your image path
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.9), // Adjust opacity here
            ),
          ),

          // Your existing UI (This will be stacked on top of the background)
          ListView(
            children: [
              _searchField(),
              const SizedBox(
                height: 40,
              ),
              _categoriesSection(),
              const SizedBox(
                height: 40,
              ),
              _dietSection(),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    itemCount: popularDietsNew.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 25,
                    ),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: popularDietsNew[index].boxIsSelected
                                ? const Color.fromARGB(255, 40, 30, 30)
                                : const Color.fromARGB(255, 69, 31, 31),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: popularDietsNew[index].boxIsSelected
                                ? [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 182, 86, 100)
                                            .withOpacity(0.5),
                                        offset: const Offset(0, 10),
                                        blurRadius: 40,
                                        spreadRadius: 0)
                                  ]
                                : [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 12, 241, 188)
                                            .withOpacity(0.5),
                                        offset: const Offset(0, 10),
                                        blurRadius: 40,
                                        spreadRadius: 0)
                                  ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              popularDietsNew[index].iconPath,
                              width: 65,
                              height: 65,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  popularDietsNew[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${popularDietsNew[index].level} | ${popularDietsNew[index].duration} | ${popularDietsNew[index].calorie}',
                                  style: const TextStyle(
                                      color: Color(0xff7B6F72),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/icons/button.svg',
                                width: 30,
                                height: 30,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recommendation\nfor Diet',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                    color: dietsNew[index].boxColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      dietsNew[index].iconPath,
                      height: 100,
                      width: 100,
                    ),
                    /*   SizedBox(
      height: 100, // Specify the height
      width: 100,  // Specify the width
      child: SvgPicture.asset(dietsNew[index].iconPath),
    ), */
                    Column(
                      children: [
                        Text(
                          dietsNew[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          '${dietsNew[index].level} | ${dietsNew[index].duration} | ${dietsNew[index].calorie}',
                          style: const TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      width: 130,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            dietsNew[index].viewIsSelected
                                ? const Color(0xff9DCEFF)
                                : Colors.transparent,
                            dietsNew[index].viewIsSelected
                                ? const Color(0xff92A3FD)
                                : Colors.transparent
                          ]),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          'View',
                          style: TextStyle(
                              color: dietsNew[index].viewIsSelected
                                  ? Colors.white
                                  : const Color(0xffC58BF2),
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemCount: dietsNew.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        )
      ],
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
            height: 160,
            child: ListView.separated(
              itemCount: categoriesNew.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (context, index) => const SizedBox(
                width: 50,
              ),
              itemBuilder: (context, index) {
                return Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: categoriesNew[index].boxColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              SvgPicture.asset(categoriesNew[index].iconPath),
                        ),
                      ),
                      Text(
                        categoriesNew[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14),
                      )
                    ],
                  ),
                );
              },
            ))
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color.fromARGB(255, 79, 126, 88).withOpacity(0.5),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 255, 255, 240),
            filled: true,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search Pancake',
            hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/icons/Search.svg'),
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Color.fromARGB(255, 154, 72, 72),
                      indent: 10,
                      endIndent: 10,
                      thickness: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              //borderRadius: BorderRadius.circular(15)
            )),
      ),
    );
  }
}
