import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfume_recsys/evaluation_result.dart';
import 'package:perfume_recsys/perfumedetail.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:provider/provider.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({Key? key}) : super(key: key);

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  List<bool> switchButton = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  final nameText = TextEditingController();
  var userName = "";
  var num = 11;
  @override
  Widget build(BuildContext context) {
    final perfumeID = context.watch<SearchData>().perfumeData;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('img/bg.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xBBFFFFFF),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('perfumes')
                .doc(perfumeID)
                .snapshots(), //question document snapshot 얻어옴
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              //변수 선언부
              final perfumeData = snapshot.data!.data();
              final brand = perfumeData!["fields"]["brand"].toString();
              final gender = perfumeData["fields"]["gender"];
              final launchDate =
                  perfumeData["fields"]["launch_date"].toString();
              final name = perfumeData["fields"]["name"].toString();
              final thumbnail = perfumeData["fields"]["thumbnail"].toString();
              const title2 = 30.0;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: FadeInImage.assetNetwork(
                        placeholder: "img/loading.gif",
                        image: thumbnail,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                          return FadeInImage.assetNetwork(
                            placeholder: "img/loading.gif",
                            image: "https://basenotes.com/img/product/",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 5.0,
                            width: 500.0,
                            color: const Color(0xffb588cc),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            " $name",
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("brand")
                                  .doc(brand)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return Text(
                                  "  Made by ${snapshot.data!["fields"]["name"]} ${_splitDate(launchDate)}",
                                  style: const TextStyle(fontSize: 23),
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 3.0,
                            width: 500.0,
                            color: const Color(0xffb588cc),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "   Recommendation List",
                      style: TextStyle(
                          color: Color(0xFF772377),
                          fontSize: title2,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      "    Please rate the result by using switch buttons below.",
                      style: TextStyle(
                          color: Color(0xFF772377),
                          fontWeight: FontWeight.w500),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("perfumes")
                            .where("fields.gender", isEqualTo: gender)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          var list = snapshot.data!.docs.toList();
                          list.removeWhere((perfumes) =>
                              perfumes.data()["fields"]["thumbnail"] ==
                              "http://www.basenotes.net/photos/300noimage.png");
                          list.removeWhere((perfumes) =>
                              perfumes.data()["fields"]["name"] == name);
                          List<double> scoreList = List.generate(
                              list.length, (int i) => 0.0); //점수들이 들어간다.
                          List<double> maxScoreList = List.generate(
                              num, (int i) => 0.0); //상위 점수들이 들어간다.
                          List<int> maxScoreIndexNumberList =
                              List.generate(num, (int i) => i); //인덱스 넘버가 들어간다.
                          List<bool> evaluation =
                              List.generate(num, (int i) => true);
                          var minIndex = 0;
                          for (var i = 0; i < list.length; i++) {
                            var score =
                                _calculate(context, perfumeData, list[i]);
                            scoreList[i] =
                                score; //최대값 출력하는 i index 5개 뽑아서 디스플레이하면 끝임!
                            for (var j = 0; j < num; j++) {
                              if (maxScoreList[j] < maxScoreList[minIndex]) {
                                minIndex = j; //제일 작은 점수를 찾는 것
                              }
                            }
                            if (maxScoreList[minIndex] < scoreList[i]) {
                              maxScoreList[minIndex] = scoreList[i];
                              maxScoreIndexNumberList[minIndex] = i;
                            }
                          }
                          for (var i = 0; i < num; i++) {
                            var max = i;
                            for (var j = i; j < num; j++) {
                              if (maxScoreList[max] < maxScoreList[j]) {
                                max = j;
                              }
                            }
                            var a = maxScoreList[i];
                            var b = maxScoreIndexNumberList[i];
                            maxScoreList[i] = maxScoreList[max];
                            maxScoreIndexNumberList[i] =
                                maxScoreIndexNumberList[max];
                            maxScoreList[max] = a;
                            maxScoreIndexNumberList[max] = b;
                          }
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: num - 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5,
                                          color: const Color(0xFF772377)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "#${index + 1}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 25),
                                            ),
                                            Switch(
                                              value: switchButton[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  switchButton[index] = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        _buildListItem(
                                            context,
                                            list[
                                                maxScoreIndexNumberList[index]],
                                            maxScoreList[index],
                                            index,
                                            evaluation[index]),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 5.0,
                      width: 500.0,
                      color: const Color(0xffb588cc),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "   Upload your Evaluation",
                      style: TextStyle(
                          color: Color(0xFF772377),
                          fontSize: title2,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2.0,
                      width: 500.0,
                      color: const Color(0xffb588cc),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.5, color: const Color(0xFF772377)),
                        ),
                        child: TextFormField(
                          controller: nameText,
                          decoration: const InputDecoration(
                            labelText: '  Please input your name here.',
                          ),
                          onChanged: (value) {
                            userName = value;
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                            //Mean Average Precision @ K 실행
                            onPressed: () async {
                              var score = 0.0;
                              var sum = 0.0;
                              for (int i = 0; i < num - 1; i++) {
                                sum = 0;
                                for (int j = 0; j <= i; j++) {
                                  if (switchButton[j] == true) {
                                    sum++;
                                  }
                                }
                                score += sum / (i + 1);
                              }
                              score /= num - 1;
                              if (userName.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection("evaluation")
                                    .add({
                                  'name': userName,
                                  'time': Timestamp.now(),
                                  'score': score * 100,
                                });
                              }
                              if (!mounted) return;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EvaluationResult(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffb588cc)),
                            child: const Text(
                              "Upload",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

String _splitDate(String dateInformation) {
  if (dateInformation != "null") {
    var list = dateInformation.split('-');
    return "in ${list[0]}";
  }
  return "";
}

double _calculate(BuildContext context, perfume, list) {
  var score = 0.0;
  var a = perfume; // a[""][""] 이렇게 사용 가능. 기준 향수 데이터
  var b = list.data(); // b[""][""] 이렇게 사용 가능. 비교 향수 데이터

  const paramSeason = 4;
  const paramCategory = 12;
  const paramNoteHit = 30;
  const paramNoteSideHit = 15;

  // season 비교 및 점수 부여
  var seasonScore = 0;
  var entireLength =
      sqrt(a["fields"]["seasons"].length) * sqrt(b["fields"]["seasons"].length);
  for (var season in a["fields"]["seasons"]) {
    if (b["fields"]["seasons"].contains(season)) {
      seasonScore++;
    }
  }
  if (entireLength != 0) {
    score = paramSeason * seasonScore / (entireLength);
  } //season: 0~1로 코사인 유사도 측정
  else {
    score = 0.1;
  }

  // category 비교 및 점수 부여
  var categoryScore = 0;
  entireLength = sqrt(a["fields"]["categories"].length) *
      sqrt(b["fields"]["categories"].length); //|A| * |B| 계산
  for (var category in a["fields"]["categories"]) {
    if (b["fields"]["categories"].contains(category)) {
      categoryScore++;
    }
  }
  if (entireLength != 0) {
    score += paramCategory * categoryScore / entireLength; //paramCategory는 가중치
  } //category: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  } //data가 없는 경우, 기본점수 0.1 부여

//////////////////////////////////////////////////////////////////////////////////

  // baseNote끼리 비교 및 점수 부여
  var baseNoteScore1 = 0;
  entireLength = sqrt(a["fields"]["base_notes"].length) *
      sqrt(b["fields"]["base_notes"].length);
  for (var baseNote in a["fields"]["base_notes"]) {
    if (b["fields"]["base_notes"].contains(baseNote)) {
      baseNoteScore1++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteHit * baseNoteScore1 / (entireLength);
  } //baseNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

  // heartNote끼리 비교 및 점수 부여
  var heartNoteScore1 = 0;
  entireLength = sqrt(a["fields"]["heart_notes"].length) *
      sqrt(b["fields"]["heart_notes"].length);
  for (var heartNote in a["fields"]["heart_notes"]) {
    if (b["fields"]["heart_notes"].contains(heartNote)) {
      heartNoteScore1++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteHit * heartNoteScore1 / (entireLength);
  } //heartNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

  // topNote끼리 비교 및 점수 부여
  var topNoteScore1 = 0;
  entireLength = sqrt(a["fields"]["top_notes"].length) *
      sqrt(b["fields"]["top_notes"].length);
  for (var topNote in a["fields"]["top_notes"]) {
    if (b["fields"]["top_notes"].contains(topNote)) {
      topNoteScore1++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteHit * topNoteScore1 / (entireLength);
  } //topNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

  //////////////////////////////////////////////////////////////////////////////

  // baseNote끼리 비교 및 점수 부여
  var baseNoteScore2 = 0;
  entireLength = sqrt(a["fields"]["base_notes"].length) *
      sqrt(b["fields"]["heart_notes"].length);
  for (var baseNote in a["fields"]["base_notes"]) {
    if (b["fields"]["heart_notes"].contains(baseNote)) {
      baseNoteScore2++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteSideHit * baseNoteScore2 / (entireLength);
  } //baseNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

  // heartNote끼리 비교 및 점수 부여
  var heartNoteScore2 = 0;
  entireLength = sqrt(a["fields"]["heart_notes"].length) *
      sqrt(b["fields"]["top_notes"].length);
  for (var heartNote in a["fields"]["heart_notes"]) {
    if (b["fields"]["top_notes"].contains(heartNote)) {
      heartNoteScore2++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteSideHit * heartNoteScore2 / (entireLength);
  } //heartNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

  // topNote끼리 비교 및 점수 부여
  var topNoteScore2 = 0;
  entireLength = sqrt(a["fields"]["top_notes"].length) *
      sqrt(b["fields"]["base_notes"].length);
  for (var topNote in a["fields"]["top_notes"]) {
    if (b["fields"]["base_notes"].contains(topNote)) {
      topNoteScore2++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteSideHit * topNoteScore2 / (entireLength);
  } //topNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

//////////////////////////////////////////////////////////////////////////////////

  // baseNote끼리 비교 및 점수 부여
  var baseNoteScore3 = 0;
  entireLength = sqrt(a["fields"]["base_notes"].length) *
      sqrt(b["fields"]["top_notes"].length);
  for (var baseNote in a["fields"]["base_notes"]) {
    if (b["fields"]["top_notes"].contains(baseNote)) {
      baseNoteScore3++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteSideHit * baseNoteScore3 / (entireLength);
  } //baseNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

  // heartNote끼리 비교 및 점수 부여
  var heartNoteScore3 = 0;
  entireLength = sqrt(a["fields"]["heart_notes"].length) *
      sqrt(b["fields"]["base_notes"].length);
  for (var heartNote in a["fields"]["heart_notes"]) {
    if (b["fields"]["base_notes"].contains(heartNote)) {
      heartNoteScore3++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteSideHit * heartNoteScore3 / (entireLength);
  } //heartNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

  // topNote끼리 비교 및 점수 부여
  var topNoteScore3 = 0;
  entireLength = sqrt(a["fields"]["top_notes"].length) *
      sqrt(b["fields"]["heart_notes"].length);
  for (var topNote in a["fields"]["top_notes"]) {
    if (b["fields"]["heart_notes"].contains(topNote)) {
      topNoteScore3++;
    }
  }
  if (entireLength != 0) {
    score += paramNoteSideHit * topNoteScore3 / (entireLength);
  } //topNote: 0~1로 코사인 유사도 측정
  else {
    score += 0.1;
  }

  return score;
}

Widget _buildListItem(BuildContext context, document, score, rank, evaluation) {
  var question = document.data();
  return Padding(
    padding: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () {
        context.read<SearchData>().setPerfumeDetail(document.id);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PerfumeDetail(),
            ));
      },
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: FadeInImage.assetNetwork(
              placeholder: "img/loading.gif",
              image: question['fields']['thumbnail'],
              fit: BoxFit.cover,
              imageErrorBuilder: (context, url, error) =>
                  FadeInImage.assetNetwork(
                placeholder: "img/loading.gif",
                image: "https://basenotes.com/img/product/",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question['fields']['name'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
                Text("Score: ${score.toStringAsFixed(3)}"),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}
