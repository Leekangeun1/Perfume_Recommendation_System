import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EvaluationResult extends StatefulWidget {
  const EvaluationResult({Key? key}) : super(key: key);

  @override
  State<EvaluationResult> createState() => _EvaluationResultState();
}

class _EvaluationResultState extends State<EvaluationResult> {
  var result = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('img/bg.png'), // 배경 이미지
        ),
      ), // 배경 이미지
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xBBFFFFFF),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("evaluation")
                        .orderBy("time")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var docs = snapshot.data!.docs.toList();
                      for(int i=0;i<docs.length;i++){
                        result += docs[i].data()["score"];
                      }
                      result /= docs.length;
                      return Column(
                        children: [
                          const SizedBox(height: 70,),
                          for (int i = 0; i < docs.length; i++)
                            Column(
                              children: [
                                Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xFF772377)
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("#${i+1}", style: const TextStyle(fontSize: 20),),
                                      Text("User Name: ${docs[i].data()["name"]}", style: const TextStyle(fontSize: 20),),
                                      Text("AP@K: ${docs[i].data()["score"].toStringAsFixed(3)}",style: const TextStyle(fontSize: 20),),
                                      Text("Time: ${printTime(docs[i].data()["time"].toDate())}",style: const TextStyle(fontSize: 20),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,)
                              ],
                            ),
                          const Text("Output of MAP@K is:",style: TextStyle(fontSize: 25),),
                          Text("${result.toStringAsFixed(2)}/100.0",style: const TextStyle(fontSize: 30),),
                          const SizedBox(height: 70,),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String printTime(DateTime time) {
  DateTime t = time;
  return "${t.year - 2000}년 ${t.month}월 ${t.day}일 ${t.hour}시 ${t.minute}분";
}