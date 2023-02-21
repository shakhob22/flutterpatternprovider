
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterpatternprovider/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../model/post_model.dart';
import '../service/http_service.dart';
import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    viewModel.apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setState"),
      ),
      body: ChangeNotifierProvider (
        create: (context) => viewModel,
        child: Consumer<HomeViewModel> (
          builder: (context, value, child) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: viewModel.items.length,
                  itemBuilder: (context, index) {
                    return itemOfPost(viewModel.items[index]);
                  },
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      startActionPane: ActionPane (
        motion: const ScrollMotion(),
        dismissible: Dismissible(onDismissed: (direction) {}, key: const Key(""), child: const SizedBox(),),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Update",
          ),

        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              viewModel.apiPostDelete(post);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title!.toUpperCase(), style: const TextStyle()),
            const SizedBox(height: 5,),
            Text(post.body!, style: const TextStyle(color: Colors.black54),)
          ],
        ),
      ),
    );
  }

}
