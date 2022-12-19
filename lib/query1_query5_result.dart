import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:perfume_recsys/yourperfume.dart';
import 'package:provider/provider.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
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
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xAAFFFFFF),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("perfumes")
                  .where("fields.categories",
                      arrayContains:
                          int.parse(context.watch<SearchData>().category))
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs.toList();
                docs.removeWhere((perfumes) => !(perfumes
                    .data()["fields"]["seasons"]
                    .contains(int.parse(context.watch<SearchData>().season))));
                docs.removeWhere((perfumes) =>
                    perfumes.data()["fields"]["gender"] !=
                    int.parse(context.watch<SearchData>().sex));
                docs.removeWhere((perfumes) =>
                    perfumes.data()["fields"]["thumbnail"] ==
                    "http://www.basenotes.net/photos/300noimage.png");
                docs.sort((a, b) => b
                    .data()["fields"]["price"]
                    .compareTo(a.data()["fields"]["price"]));
                context.read<SearchData>().setNumOfPerfume(docs.length);

                if (docs.isEmpty) {
                  return Column(
                    children: [
                      Container(
                        height: 3.0,
                        width: 500.0,
                        color: const Color(0xffb588cc),
                      ),
                      Image.asset("img/perfumes.png"),
                      Container(
                        height: 3.0,
                        width: 500.0,
                        color: const Color(0xffb588cc),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "* The product is being prepared.\n* Please wait for new updates.",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("perfumes")
                            .where("fields.categories",
                                arrayContains: int.parse(
                                    context.watch<SearchData>().category))
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final docs = snapshot.data!.docs.toList();
                          docs.removeWhere((perfumes) => !(perfumes
                              .data()["fields"]["seasons"]
                              .contains(int.parse(
                                  context.watch<SearchData>().season))));
                          docs.removeWhere((perfumes) =>
                              perfumes.data()["fields"]["gender"] !=
                              int.parse(context.watch<SearchData>().sex));
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 500,
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "We prepared",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${context.watch<SearchData>().numOfPerfume}",
                                          style: const TextStyle(
                                              color: Color(0xFF772377),
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          "Perfumes for you!",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          );
                        }),
                    Expanded(
                      child: ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            return _buildListItem(context, docs[index]);
                          }),
                    ),
                  ],
                );
              }),
        ));
  }
}

Widget _buildListItem(BuildContext context, document) {
  var question = document.data();
  return Padding(
    padding: const EdgeInsets.all(2),
    child: InkWell(
      onTap: () {
        context.read<SearchData>().setPerfumeData(document.id);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const YourPerfume(),
            ));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("brand")
                      .doc(question['fields']['brand'].toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var brand = snapshot.data!["fields"]["name"];
                    return SizedBox(
                      width: 270,
                      child: Text("${question['fields']['name']} by $brand",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                    );
                  }),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    ),
  );
}
