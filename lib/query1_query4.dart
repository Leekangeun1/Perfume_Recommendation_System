import 'package:flutter/material.dart';
import 'package:perfume_recsys/query1_query3.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:perfume_recsys/query1_query5_result.dart';
import 'package:provider/provider.dart';

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
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
                  "Please tell me your sex.",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  context.read<SearchData>().setSex("1");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Result(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(children: [
                      Image.asset(
                        "img/male.png",
                        height: size,
                        width: size,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text("  Male",
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
                  context.read<SearchData>().setSex("0");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Result(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(children: [
                      Image.asset(
                        "img/female.png",
                        height: size,
                        width: size,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text("  Female",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w300)),
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
