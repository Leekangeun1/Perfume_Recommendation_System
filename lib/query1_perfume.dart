import 'package:flutter/material.dart';
import 'package:perfume_recsys/query1_query1.dart';

class PerfumeQuery extends StatefulWidget {
  const PerfumeQuery({Key? key}) : super(key: key);

  @override
  State<PerfumeQuery> createState() => _PerfumeQueryState();
}

class _PerfumeQueryState extends State<PerfumeQuery> {
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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: const BoxDecoration(color: Color(0xAAFFFFFF)),
                child: const Center(
                  child: Text("Let's do a simple \nPerfume taste test. \nAre you ready?",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffb588cc),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FirstQuery()));
                  },
                  child: const SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(fontSize: 25),
                        ),
                      ))),
              SizedBox(height: 30,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffb588cc),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          "No",
                          style: TextStyle(fontSize: 25),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
