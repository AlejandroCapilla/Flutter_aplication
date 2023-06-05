import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/deezer_model.dart';
import 'package:flutter_demo/network/api_deezer.dart';
import 'package:flutter_demo/widgets/item_deezer.dart';

class DeezerScreen extends StatefulWidget {
  const DeezerScreen({super.key});

  @override
  State<DeezerScreen> createState() => _DeezerScreenState();
}

class _DeezerScreenState extends State<DeezerScreen> {
  ValueNotifier<String> search = ValueNotifier('ghost');
  TextEditingController txtSearch = TextEditingController();
  ApiDeezer? apiDeezer;

  @override
  void initState() {
    super.initState();
    apiDeezer = ApiDeezer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: search,
                    builder: (context, value, child) {
                      return FutureBuilder(
                        future: apiDeezer!.getAllDeezer(value),
                        builder: (context,
                            AsyncSnapshot<List<DeezerModel>?> snapshot) {
                          return GridView.builder(
                              padding: const EdgeInsets.all(15),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 0.8,
                                      mainAxisExtent: 80),
                              itemBuilder: (context, index) {
                                if (snapshot.hasData) {
                                  return ItemDeezer(
                                      deezerModel: snapshot.data![index]);
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Algo salio mal'),
                                  );
                                } else {
                                  return const Center(
                                    child: Text('No se encontraron resultados'),
                                  );
                                }
                              },
                              itemCount: snapshot.data != null
                                  ? snapshot.data!.length
                                  : 0);
                        },
                      );
                    })),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AnimSearchBar(
                  rtl: true,
                  width: 400,
                  textController: txtSearch,
                  onSuffixTap: () {
                    setState(() {
                      txtSearch.clear();
                    });
                  },
                  onSubmitted: (text) {
                    search.value = text.trim();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
