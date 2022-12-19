import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfume_recsys/query2_perfumefinder.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:provider/provider.dart';

class BrandFinder extends StatefulWidget {
  const BrandFinder({Key? key}) : super(key: key);

  @override
  State<BrandFinder> createState() => _BrandFinderState();
}

class _BrandFinderState extends State<BrandFinder> {
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
          height: 1.0,
          width: 500.0,
          color: const Color(0xffb588cc),
        ),
        TextField(
          keyboardType: TextInputType.text,
          onChanged: (text) {
            setState(() {
              context.read<SearchData>().setBrandData(text);
            });
          },
          decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Icon(Icons.search))),
        ),
        Container(
          height: 1.0,
          width: 500.0,
          color: const Color(0xffb588cc),
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
              "Please Click your Perfume's Brand!",
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
            .collection("brand")
            .where("fields.name",
                isGreaterThanOrEqualTo: context.watch<SearchData>().brandData)
            .orderBy("fields.name")
            .limit(100)
            .snapshots(),
        builder: (context, snapshot) {
          if (context.watch<SearchData>().brandData == "") {
            return _information();
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs.toList();
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                //return Text(docs[index]["fields.name"]);
                return _buildListItem(context, docs[index]);
              });
        });
  }
}

Widget _information() {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Row(
        children: const [
          SizedBox(
            width: 30,
          ),
          Text(
            "Please Search and \nFind your Perfume's Brand",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        height: 3.0,
        width: 500.0,
        color: const Color(0xffb588cc),
      ),
      Image.asset("img/brands.png"),
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
            "* Be careful! This index is case sensitive.\n* For example: gucci(x) Gucci(o)",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildListItem(BuildContext context, document) {
  var question = document.data();
  var a = int.parse(document.id) % 267; //document id 얻는 법!!!!

  return Padding(
    padding: const EdgeInsets.all(2),
    child: InkWell(
      onTap: () {
        context.read<SearchData>().setBrandID(document.id);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PerfumeFinder()));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: Image.asset("img/rd/random ($a).jpg"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 300,
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
/*
void _flutterDialog(BuildContext context, name) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Text("$name"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Will you select this perfume brand?",
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PerfumeFinder()));
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
} */
