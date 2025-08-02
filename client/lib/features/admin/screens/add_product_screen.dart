import 'dart:io';
import 'package:client/common/widgets/custom_button.dart';
import 'package:client/common/widgets/custom_textfield.dart';
import 'package:client/common/widgets/loader.dart';

import 'package:client/constants/global_variables.dart';
import 'package:client/constants/utils.dart';
import 'package:client/features/admin/services/admin_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminService adminService = AdminService();

  final String guaranteedImageUrl =
      'https://res.cloudinary.com/dgismriuc/image/upload/v1754140696/photo_2025-08-02_18-47-53_cmrdjc.jpg';

  String category = 'Mobiles';
  final _addProductFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isImageSelected = false;

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && _isImageSelected) {
      adminService.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        imageUrl: guaranteedImageUrl,
        onStart: () => setState(() => _isLoading = true),
        onFinish: () => setState(() => _isLoading = false),
      );
    } else if (!_isImageSelected) {
      showSnackBar(context, 'Please select an image.');
    }
  }

  void selectImages() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _isImageSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _isImageSelected
                        ? SizedBox(
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.network(
                                guaranteedImageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Select Product Images',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: productNameController,
                      hintText: 'Product Name',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: 'Description',
                      maxLines: 7,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: priceController,
                      hintText: 'Price',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: quantityController,
                      hintText: 'Quantity',
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            category = newVal!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Sell',
                      onTap: sellProduct,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Loader(),
            ),
        ],
      ),
    );
  }
}