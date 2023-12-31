// ignore_for_file: avoid_unnecessary_containers

part of '../pages.dart';

class DetailArticle extends StatefulWidget {
  const DetailArticle({super.key});

  @override
  State<DetailArticle> createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticle> {
  @override
  Widget build(BuildContext context) {
    Widget title = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Judul",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
    Widget content = Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text("Deskripsi",
            style: Theme.of(context).textTheme.bodyLarge,
            softWrap: true,
            textAlign: TextAlign.justify),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Judul",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {},
            child: const Icon(
              CupertinoIcons.arrow_left,
              color: Color(0xFF001F29),
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset('asset/images/pencuci.png',
                  width: 600, fit: BoxFit.cover),
            ),
            title,
            content,
          ],
        ));
  }
}
