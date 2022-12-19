import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:perfume_recsys/yourperfume.dart';
import 'package:provider/provider.dart';

class PerfumeFinder extends StatefulWidget {
  const PerfumeFinder({Key? key}) : super(key: key);

  @override
  State<PerfumeFinder> createState() => _PerfumeFinderState();
}

class _PerfumeFinderState extends State<PerfumeFinder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('img/bg.png'), // 배경 이미지
        ),
      ),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0x88FFFFFF),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String searchingText = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 3.0,
          width: 500.0,
          color: const Color(0xffb588cc),
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("brand")
                .doc(context.read<SearchData>().brandID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  const Text(
                    "Please Find your perfume here:",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    snapshot.data!["fields"]["name"],
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
        const SizedBox(
          height: 20,
        ),
        const Expanded(child: SizedBox(child: BuildBody())),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 500,
          color: const Color(0x77b588cc),
          child: const Center(
            child: Text(
              "Please Click your Perfume!",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildBody extends StatefulWidget {
  const BuildBody({Key? key}) : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("perfumes")
            .where("fields.brand",
                isEqualTo: int.parse(context.watch<SearchData>().brandID))
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs.toList();
          if (docs.isEmpty) {
            return _information();
          }
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return _buildListItem(context, docs[index]);
              });
        });
  }
}

Widget _information() {
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  );
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
                  imageErrorBuilder: (context, url, error) => FadeInImage.assetNetwork(
                    placeholder: "img/loading.gif",
                    image: "https://basenotes.com/img/product/",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 250,
                child: Text(question['fields']['name'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    ),
  );
}
