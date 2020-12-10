import 'package:compound/viewmodels/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Post_view extends StatelessWidget {
  String path;
  Post_view(this.path);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
        viewModelBuilder: () => PostViewModel(),
        builder: (context, model, child) => Stack(
              children: [
                GestureDetector(
                  onVerticalDragUpdate: (dragUpdateDetails) {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Image.network(
                      path,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ));
  }
}
