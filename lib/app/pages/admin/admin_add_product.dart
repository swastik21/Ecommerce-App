// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

final addImageProvider = StateProvider<XFile?>((_) => null);

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  final titleTextEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomInputFieldFb1(
                inputController: titleTextEditingController,
                hintText: 'Product Name',
                labelText: 'Product Name',
              ),
              CustomInputFieldFb1(
                inputController: descriptionEditingController,
                hintText: 'Product Description',
                labelText: 'Product Description',
              ),
              CustomInputFieldFb1(
                inputController: priceEditingController,
                hintText: 'Price',
                labelText: 'Price',
              ),
              Consumer(
                builder: ((context, watch, child) {
                  final image = ref.watch(addImageProvider);
                  return image == null
                      ? const Text("No image selected")
                      : Image.file(
                          File(image.path),
                          height: 200,
                        );
                }),
              ),
              ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    ref.watch(addImageProvider.state).state = image;
                  }
                },
                child: const Text("Upload Image"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => _addProduct(),
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addProduct() async {
    final storage = ref.read(databaseProvider);
    final imageFile = ref.read(addImageProvider.state).state;
    final fileStorage = ref.read(storageProvider);
    if (storage == null || imageFile == null || fileStorage == null) {
      print("Error: storage, fileStorage or imageFile is null");
      return;
    }
    final imageUrl = await fileStorage.uploadFile(imageFile.path);
    await storage.addProduct(Product(
      name: titleTextEditingController.text,
      description: descriptionEditingController.text,
      price: double.parse(priceEditingController.text),
      imageUrl: imageUrl,
    ));
    openIconSnackBar(
        context,
        "Product added successfully",
        const Icon(
          Icons.check,
          color: Colors.white,
        ),
        Colors.green);
    Navigator.pop(context);
  }
}

class CustomInputFieldFb1 extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;
  final String labelText;

  const CustomInputFieldFb1(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      this.primaryColor = Colors.indigo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}
