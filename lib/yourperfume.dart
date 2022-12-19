import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:perfume_recsys/querypage.dart';
import 'package:perfume_recsys/recommendation.dart';
import 'package:provider/provider.dart';

class YourPerfume extends StatefulWidget {
  const YourPerfume({Key? key}) : super(key: key);

  @override
  State<YourPerfume> createState() => _YourPerfumeState();
}

class _YourPerfumeState extends State<YourPerfume> {
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
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xBBFFFFFF),
        body: SingleChildScrollView(
          //많은 내용을 스크롤로 관리하기 위해 사용한 위젯
          child: StreamBuilder(
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
                final baseNote = perfumeData!["fields"]["base_notes"];
                final brand = perfumeData["fields"]["brand"].toString();
                final category = perfumeData["fields"]["categories"];
                final gender = perfumeData["fields"]["gender"];
                final heartNote = perfumeData["fields"]["heart_notes"];
                final launchDate =
                    perfumeData["fields"]["launch_date"].toString();
                final name = perfumeData["fields"]["name"].toString();
                final price = perfumeData["fields"]["price"];
                final season = perfumeData["fields"]["seasons"];
                final thumbnail = perfumeData["fields"]["thumbnail"].toString();
                final topNote = perfumeData["fields"]["top_notes"];
                const title2 = 30.0;
                const subtitleSize = 25.0;
                const smallLetter = 23.0;

                return Column(
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
                          const Text(
                            " Information",
                            style: TextStyle(
                                color: Color(0xFF772377),
                                fontSize: title2,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0x66FFFFFF),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black, width: 1.5)),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Price: ",
                                        style: TextStyle(
                                            fontSize: subtitleSize,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "  $price\$",
                                        style: const TextStyle(
                                            fontSize: smallLetter),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Gender: ",
                                        style: TextStyle(
                                            fontSize: subtitleSize,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      if (gender == 0)
                                        const Text(
                                          "  Female",
                                          style:
                                              TextStyle(fontSize: smallLetter),
                                        )
                                      else
                                        const Text(
                                          "  Male",
                                          style:
                                              TextStyle(fontSize: smallLetter),
                                        ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Category: ",
                                        style: TextStyle(
                                            fontSize: subtitleSize,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      if (category.toString() == "[]")
                                        const Text(
                                          "  not exists",
                                          style:
                                              TextStyle(fontSize: smallLetter),
                                        )
                                      else
                                        for (var index in category)
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("category")
                                                  .doc(index.toString())
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }
                                                return Text(
                                                  "  ${snapshot.data!["fields"]["name"]}",
                                                  style: const TextStyle(
                                                      fontSize: smallLetter),
                                                );
                                              }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Season: ",
                                        style: TextStyle(
                                            fontSize: subtitleSize,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      if (season.toString() == "[]")
                                        const Text(
                                          "  not exists",
                                          style:
                                              TextStyle(fontSize: smallLetter),
                                        )
                                      else
                                        for (var index in season)
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("season")
                                                  .doc(index.toString())
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }
                                                return Text(
                                                  "  ${snapshot.data!["fields"]["name"]} ",
                                                  style: const TextStyle(
                                                      fontSize: smallLetter),
                                                );
                                              }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 3.0,
                        width: 500.0,
                        color: const Color(0xffb588cc),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "  Perfume Scent Notes",
                          style: TextStyle(
                              color: Color(0xFF772377),
                              fontSize: title2,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0x66FFFFFF),
                            image: const DecorationImage(
                              image: AssetImage("img/purple_triangle.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Colors.black, width: 1.5)),
                        child: Column(
                          children: [
                            Row(
                              children: [Container()],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Top notes",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (topNote.toString() == "[]")
                              const Text(
                                "no data",
                                style: TextStyle(fontSize: 19),
                              )
                            else
                              for (var index in topNote)
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("notes")
                                        .doc(index.toString())
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      return Text(
                                        "${snapshot.data!["fields"]["name"]} ${snapshot.data!["fields"]["kor_name"]}",
                                        style: const TextStyle(fontSize: 19),
                                      );
                                    }),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Heart notes",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (heartNote.toString() == "[]")
                              const Text(
                                "no data",
                                style: TextStyle(fontSize: 19),
                              )
                            else
                              for (var index in heartNote)
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("notes")
                                        .doc(index.toString())
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      return Text(
                                        "${snapshot.data!["fields"]["name"]} ${snapshot.data!["fields"]["kor_name"]}",
                                        style: const TextStyle(fontSize: 19),
                                      );
                                    }),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Base notes",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (baseNote.toString() == "[]")
                              const Text(
                                "no data",
                                style: TextStyle(fontSize: 19),
                              )
                            else
                              for (var index in baseNote)
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("notes")
                                        .doc(index.toString())
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      return Text(
                                        "${snapshot.data!["fields"]["name"]} ${snapshot.data!["fields"]["kor_name"]}",
                                        style: const TextStyle(fontSize: 19),
                                      );
                                    }),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 3.0,
                        width: 500.0,
                        color: const Color(0xffb588cc),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Do you like it?",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    const Text(
                      "If so, please tap the button below",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 20,),
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
                                  builder: (context) => const Recommendation()));
                        },
                        child: const SizedBox(
                            height: 50,
                            width: 100,
                            child: Center(
                              child: Text(
                                "I Like It!",
                                style: TextStyle(fontSize: 25),
                              ),
                            ))),
                    const SizedBox(height: 50,),
                  ],
                );
              }),
        ),
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
