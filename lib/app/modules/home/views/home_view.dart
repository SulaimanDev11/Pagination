import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  var isTrue = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: controller.names == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: controller.names!
                        .map((e) => ListTile(title: Text(e)))
                        .toList(),
                  ),
          ),
          ElevatedButton(
            // onPressed: loadNames,
            onPressed: () {
              controller.fetchNameDocuments();
            },
            child: Text('Load More'),
          ),
        ],
      ),
    );
  }

  void loadNames() {}
}
