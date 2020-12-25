import 'package:compound/viewmodels/preview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Preview_view extends StatelessWidget {
  String path;
  Preview_view(this.path);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ViewModelBuilder<CreatePostViewModel>.reactive(
        viewModelBuilder: () => CreatePostViewModel(),
        onModelReady: (model) => model.getImage(path),
        builder: (context, model, child) => Stack(
              children: model.busy
                  ? [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ]
                  : [
                      Container(
                        child: Image.file(
                          model.selectedImage,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonBar(
                                alignment: MainAxisAlignment.end,
                                children: [
                                  FlatButton(
                                    onPressed: () async {
                                      await model.getImage(path);
                                      model.addPost();
                                    },
                                    child: Text("Done"),
                                    color: Colors.blue,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancle"),
                                    color: Colors.red,
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
            ));
  }
}
