import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:economic/db/brand.dart';
import 'package:economic/db/category.dart';
import 'package:economic/db/dbproduct.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool feature = false;
  bool sale = false;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  Color pinkPurple = Colors.pink[900];

  CategoryServices _categoryServices = CategoryServices();
  BrandServices _brandServices = BrandServices();
  ProductServices _productServices = ProductServices();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  List<String> selectedSizes = <String>[];
  File _image1;

  bool isLoading = false;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryServices.getCategories();
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory = categories[0].data['category'];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandServices.getBrands();
    setState(() {
      brands = data;
      brandDropDown = getBrandsDropDown();
      _currentBrand = brands[0].data['brand'];
    });
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data['category']),
                value: categories[i].data['category']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data['brand']),
                value: brands[i].data['brand']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.1,
        leading: IconButton(
          icon:Icon(Icons.close),
          color: black,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Add Product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              onPressed: () {
                                selectImage();
                              },
                              borderSide: BorderSide(
                                  color: grey.withOpacity(0.5), width: 2.5),
                              child: _image1 == null
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 50.0, 14.0, 50.0),
                                      child: new Icon(
                                        Icons.add,
                                        color: grey,
                                      ),
                                    )
                                  : displayImage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter the product name within 10 characters',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: "Product name"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the product name';
                          } else if (value.length > 10) {
                            return 'Product name cant have more then 10 letters';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: detailController,
                        decoration: InputDecoration(hintText: "Product deatail"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the product detail';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sale : ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                        CustomSwitch(
                          activeColor: pinkPurple,
                          value: sale,
                          onChanged: (value) {
                            setState(() {
                              sale = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Display Product : ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                        CustomSwitch(
                          activeColor: pinkPurple,
                          value: feature,
                          onChanged: (value) {
                            setState(() {
                              feature = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Category',
                            style: TextStyle(color: red),
                          ),
                        ),
                        DropdownButton(
                          items: categoriesDropDown,
                          onChanged: changeSelectedCategory,
                          value: _currentCategory,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Brand',
                            style: TextStyle(color: red),
                          ),
                        ),
                        DropdownButton(
                          items: brandDropDown,
                          onChanged: changeSelectedBrand,
                          value: _currentBrand,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(hintText: "Quantity"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the quantity';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(hintText: "Price"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the price';
                          }
                          return null;
                        },
                      ),
                    ),
                    Text('Available Sizes'),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: selectedSizes.contains('XS'),
                          onChanged: (value) => changeSelectedSize('XS'),
                        ),
                        Text('XS'),
                        Checkbox(
                          value: selectedSizes.contains('S'),
                          onChanged: (value) => changeSelectedSize('S'),
                        ),
                        Text('S'),
                        Checkbox(
                          value: selectedSizes.contains('M'),
                          onChanged: (value) => changeSelectedSize('M'),
                        ),
                        Text('M'),
                        Checkbox(
                          value: selectedSizes.contains('L'),
                          onChanged: (value) => changeSelectedSize('L'),
                        ),
                        Text('L'),
                        Checkbox(
                          value: selectedSizes.contains('XL'),
                          onChanged: (value) => changeSelectedSize('XL'),
                        ),
                        Text('XL'),
                        Checkbox(
                          value: selectedSizes.contains('XXL'),
                          onChanged: (value) => changeSelectedSize('XXL'),
                        ),
                        Text('XXL'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: selectedSizes.contains('28'),
                          onChanged: (value) => changeSelectedSize('28'),
                        ),
                        Text('28'),
                        Checkbox(
                          value: selectedSizes.contains('30'),
                          onChanged: (value) => changeSelectedSize('30'),
                        ),
                        Text('30'),
                        Checkbox(
                          value: selectedSizes.contains('32'),
                          onChanged: (value) => changeSelectedSize('32'),
                        ),
                        Text('32'),
                        Checkbox(
                          value: selectedSizes.contains('34'),
                          onChanged: (value) => changeSelectedSize('34'),
                        ),
                        Text('34'),
                        Checkbox(
                          value: selectedSizes.contains('36'),
                          onChanged: (value) => changeSelectedSize('36'),
                        ),
                        Text('36'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: selectedSizes.contains('38'),
                          onChanged: (value) => changeSelectedSize('38'),
                        ),
                        Text('38'),
                        Checkbox(
                          value: selectedSizes.contains('40'),
                          onChanged: (value) => changeSelectedSize('40'),
                        ),
                        Text('40'),
                        Checkbox(
                          value: selectedSizes.contains('42'),
                          onChanged: (value) => changeSelectedSize('42'),
                        ),
                        Text('42'),
                        Checkbox(
                          value: selectedSizes.contains('48'),
                          onChanged: (value) => changeSelectedSize('48'),
                        ),
                        Text('48'),
                        Checkbox(
                          value: selectedSizes.contains('50'),
                          onChanged: (value) => changeSelectedSize('50'),
                        ),
                        Text('50'),
                      ],
                    ),
                    FlatButton(
                      color: red,
                      textColor: white,
                      onPressed: () {
                        validateAndUpload();
                      },
                      child: Text('Add prodcut'),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentBrand = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  Future selectImage() async {
    var tempImg = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image1 = tempImg;
    });
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;
          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_image1);
          task1.onComplete.then((snapshot1) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            _productServices.uploadProduct(
                productName: productNameController.text,
                brandName: _currentBrand,
                details: detailController.text,
                category: _currentCategory,
                quantity: int.parse(quantityController.text),
                size: selectedSizes,
                picture: imageUrl1,
                feature: feature,
                sale: sale,
                price: double.parse(priceController.text));
            _formKey.currentState.reset();

            setState(() => isLoading = false);
            Fluttertoast.showToast(msg: 'Product added');
            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);
          Fluttertoast.showToast(msg: 'Select atleast one size');
        }
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'Images cannot be null');
      }
    } else {
      Fluttertoast.showToast(msg: 'Data entry in not valid,refresh the page');
    }
  }

  Widget displayImage() {
    return Column(
      children: <Widget>[
        Image.file(
          _image1,
          fit: BoxFit.fill,
          width: double.infinity,
//          height: 200,
        ),
      ],
    );
  }
}
