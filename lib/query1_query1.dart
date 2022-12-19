import 'package:flutter/material.dart';
import 'package:perfume_recsys/query1_query2_city.dart';
import 'package:perfume_recsys/query1_query2_flower.dart';
import 'package:perfume_recsys/query1_query2_forest.dart';
import 'package:perfume_recsys/query1_query2_fruit.dart';
import 'package:perfume_recsys/query1_query2_sweet.dart';

class FirstQuery extends StatefulWidget {
  const FirstQuery({Key? key}) : super(key: key);

  @override
  State<FirstQuery> createState() => _FirstQueryState();
}

class _FirstQueryState extends State<FirstQuery> {
  var size = 100.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('img/bg.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xAAFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Choose a scent that makes you feel happy or comfortable just by thinking about it.",
              style: TextStyle(fontSize: 25),),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Fruit(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(children: [
                    Image.asset(
                      "img/fruit.jpg",
                      height: size,
                      width: size,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10,),
                    const Expanded(
                      child: Text("A fresh sweet smell of fruit",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                    ),
                  ]),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Flower(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(children: [
                    Image.asset(
                      "img/flower.jpg",
                      height: size,
                      width: size,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10,),
                    const Expanded(
                      child: Text("A fluttering scent of flowers",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                    ),
                  ]),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Sweet(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(children: [
                    Image.asset(
                      "img/sweet.jpg",
                      height: size,
                      width: size,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10,),
                    const Expanded(
                      child: Text("Sweet scent with a soft atmosphere",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                    ),
                  ]),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Forest(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(children: [
                    Image.asset(
                      "img/forest.jpg",
                      height: size,
                      width: size,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10,),
                    const Expanded(
                      child: Text("A refreshing smell of grass, wood",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                    ),
                  ]),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const City(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(children: [
                    Image.asset(
                      "img/city.jpg",
                      height: size,
                      width: size,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10,),
                    const Expanded(
                      child: Text("The scent of a calm and mature city",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
