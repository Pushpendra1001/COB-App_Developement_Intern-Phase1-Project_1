import 'package:flutter/material.dart';
import 'package:listingitem/views/model/fetch.dart';
import 'package:listingitem/views/model/model.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Text(
                "Listing Items",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(CupertinoIcons.search),
                    onPressed: () {
                      fetchData(_controller.text);
                      setState(() {});
                    },
                  ),
                  hintText: "Search",
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey,
                  )),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<ApiResponse>(
                future: fetchData(_controller.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<DataItem> dataItems = snapshot.data!.data.dataItems;

                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // mainAxisSpacing: 50,
                              mainAxisExtent: 300),
                      itemCount: dataItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Image.network(
                                      dataItems[index].thumbnail,
                                      // height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    dataItems[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    const TextSpan(
                                        text: "₹",
                                        style: TextStyle(color: Colors.green)),
                                    TextSpan(
                                        text: (dataItems[index].price * 50)
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(),
                                  ])),
                                  Text(
                                    dataItems[index]
                                        .category
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ]),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
