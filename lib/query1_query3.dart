import 'package:flutter/material.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:perfume_recsys/query1_query4.dart';
import 'package:provider/provider.dart';

class Season extends StatefulWidget {
  const Season({Key? key}) : super(key: key);

  @override
  State<Season> createState() => _SeasonState();
}

class _SeasonState extends State<Season> {
  var size = 120.0;
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
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Please tell me the season to use perfume.",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    context.read<SearchData>().setSeason("1");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Gender(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(children: [
                        Image.asset(
                          "img/spring.jpg",
                          height: size,
                          width: size,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Text("  Spring",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w300)),
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
                    context.read<SearchData>().setSeason("2");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Gender(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(children: [
                        Image.asset(
                          "img/summer.jpg",
                          height: size,
                          width: size,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Text("  Summer",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w300)),
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
                    context.read<SearchData>().setSeason("3");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Gender(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(children: [
                        Image.asset(
                          "img/autumn.jpg",
                          height: size,
                          width: size,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Text("  Autumn",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w300)),
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
                    context.read<SearchData>().setSeason("4");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Gender(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(children: [
                        Image.asset(
                          "img/winter.jpeg",
                          height: size,
                          width: size,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Text("  Winter",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w300)),
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
