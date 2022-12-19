import 'package:flutter/material.dart';
import 'package:perfume_recsys/query1_query3.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:provider/provider.dart';

class City extends StatefulWidget {
  const City({Key? key}) : super(key: key);

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  var size = 150.0;
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Please choose an image that is closer to your favorite scent.",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  context.read<SearchData>().setCategory("10");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Season(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(children: [
                      Image.asset(
                        "img/leather.jpg",
                        height: size,
                        width: size,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text("A raw Musk, Amber and Animalic Things",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300)),
                      ),
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  context.read<SearchData>().setCategory("12");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Season(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(children: [
                      Image.asset(
                        "img/jewelry.jpeg",
                        height: size,
                        width: size,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text("Natural and Synthetic Materials",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300)),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
