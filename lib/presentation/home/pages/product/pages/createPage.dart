// import 'dart:async';
// import 'dart:convert';
import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:justgrab_dine/application/Product/MealController.dart';
import 'package:justgrab_dine/theme/colors.dart';
import 'package:justgrab_dine/theme/sideClip.dart';

// ignore: must_be_immutable
class CreateAd extends StatefulWidget {
  CreateAd({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateAdState createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
  //V EDIT
  // final ImagePicker imagePicker = ImagePicker();
  List<File> imageFileList = [];
  bool isBtnDisabled = false;
  void selectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      if (result.files.length <= 1) {
        if (result.files.every((element) => element.size <= 3750000)) {
          setState(() {
            imageFileList = result.paths.map((path) => File(path!)).toList();
          });
        } else {
          setState(() {
          });
        }
      } else {
        setState(() {
        });
      }
    }
  }
  //V EDIT

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _loading = false;
  final _loader = SpinKitSpinningLines(
    color: gold1,
    size: 280,
  );

  // ignore: prefer_typing_uninitialized_variables
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int countBtnDisable = 0;
    final width = MediaQuery.of(context).copyWith().size.width;
    final height = MediaQuery.of(context).copyWith().size.height;
    Widget name = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      child: TextFormField(
        controller: _nameController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.title,
            color: gold1,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: gold1, fontSize: width * 0.04),
          labelText: 'Name',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Name Cannot be empty'
              : null;
        },
      ),
    );
    Widget UploadField = GestureDetector(
      onTap: () {
        selectImages();
      },
      child: Container(
        padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
        child: TextFormField(
          readOnly: true,
          enableInteractiveSelection: false,
          enabled: false,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.image,
              color: brown1,
              size: width * 0.04,
            ),
            labelStyle: TextStyle(color: brown1, fontSize: width * 0.04),
            labelText: 'Chosse Image',
          ),
        ),
      ),
    );

    Widget price = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      child: TextFormField(
        controller: _priceController,
        textInputAction: TextInputAction.next,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.amp_stories,
            color: brown1,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: brown1, fontSize: width * 0.04),
          labelText: 'Price',
          hintText: "M",
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Price Cannot be empty'
              : null;
        },
      ),
    );
    Widget description = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      child: TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.description,
            color: brown1,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: brown1, fontSize: width * 0.04),
          labelText: 'Description',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Descrition Cannot be empty'
              : null;
        },
      ),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: 'Save',
          backgroundColor: brown1,
          foregroundColor: gold1,
          onPressed: isBtnDisabled
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      if (imageFileList.isEmpty) {
                        throw Exception("Images not picked");
                      }
                      await MealController().uploadMeal(
                          price: _priceController.text.trim(),
                          image: imageFileList.first,
                          title: _nameController.text.trim(),
                          description: _descriptionController.text.trim());
                      Navigator.pop(context);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                },
          child: const Icon(Icons.done)),
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: TopRightClip1(),
            child: Container(),
          ),
          CustomPaint(
            painter: TopRightClip2(),
            child: Container(),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  imageFileList.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.1, top: height * 0.19),
                          child: SizedBox(
                            // if ()
                            width: width * 0.35,
                            height: height * 0.2,
                            // if ()
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: CarouselSlider.builder(
                                itemCount: imageFileList.length,
                                itemBuilder: (BuildContext context, int index,
                                    int pageViewIndex) {
                                  return Image.file(
                                    imageFileList[index],
                                    fit: BoxFit.cover,
                                  );
                                },
                                options: CarouselOptions(height: 300),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.1, top: height * 0.19),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            width: width * 0.35,
                            height: height * 0.2,
                            // if ()
                            child: Image.asset("assets/drink1.png"),
                          ),
                        ),
                  UploadField,
                  name,
                  description,
                  price,
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).copyWith().size.height * 0.07,
                left: MediaQuery.of(context).copyWith().size.width * 0.03,
              ),
              child: Icon(
                Icons.arrow_back,
                color: brown1,
                size: 40,
              ),
            ),
          ),
          if (_loading)
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
              child: Center(child: _loader),
            )
        ],
      ),
    );
  }
}
