import 'package:continuous_scroll/viewmodels/home_viewmodel.dart';
import 'package:continuous_scroll/widgets/creation_aware_list_item.dart';
import 'package:continuous_scroll/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider<HomeViewModel>(
        builder: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(
          builder: (context, model, child) => ListView.builder(
              itemCount: model.items.length,
              itemBuilder: (context, index) => CreationAwareListItem(
                    itemCreated: () {
                      SchedulerBinding.instance.addPostFrameCallback(
                          (_) => model.handleItemCreated(index));
                    },
                    child: ListItem(
                      title: model.items[index],
                    ),
                  )),
        ),
      ),
    );
  }
}
