import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => TransactionState();
}

class TransactionState extends State<Transaction> {
  late ScrollController controller;
  List<String> items = List.generate(100, (index) => 'Hello $index');

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      child: ListView.builder(
          controller: controller,
          itemCount: items.length,
          itemBuilder: (BuildContext context, index) {
            return Text(items[index]);
          }),
    ));
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        items.addAll(List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }
}
