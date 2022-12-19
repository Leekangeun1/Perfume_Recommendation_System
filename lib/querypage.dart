import 'package:flutter/material.dart';
import 'package:perfume_recsys/query1_perfume.dart';
import 'package:perfume_recsys/query2_brandfinder.dart';

class QueryPage extends StatefulWidget {
  const QueryPage({Key? key}) : super(key: key);

  @override
  State<QueryPage> createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
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
        backgroundColor: const Color(0x88FFFFFF),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              const Padding(
                padding: EdgeInsets.all(40.0),
                child: Expanded(
                  child: Text("I want to know your perfume taste!",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
                ),
              ),
              Container(
                height: 3.0,
                width: 500.0,
                color: const Color(0xffb588cc),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PerfumeQuery(),
                      ));
                },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Image.asset(
                        "img/dontknow.jpg",
                        height: 150,
                      ),
                      const Expanded(
                        child: Text("I don't know \nmy taste!",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
                      ),
                    ]),
                  ),
                ),
              ),
              Container(
                height: 3.0,
                width: 500.0,
                color: const Color(0xffb588cc),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 3.0,
                width: 500.0,
                color: const Color(0xffb588cc),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BrandFinder(),
                      ));
                },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Image.asset(
                        "img/yes.jpg",
                        height: 150,
                      ),
                      const Expanded(
                        child: Text(
                          "Okay, let me \ntell you what!",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Container(
                height: 3.0,
                width: 500.0,
                color: const Color(0xffb588cc),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
