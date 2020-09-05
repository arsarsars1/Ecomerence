import 'package:economic/admin/add_product.dart';
import 'package:economic/db/brand.dart';
import 'package:economic/db/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectPage = Page.dashboard;
  MaterialColor active = Colors.red;
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  MaterialColor nonActive = Colors.grey;
  BrandServices _brandServices = BrandServices();
  CategoryServices _categoryServices = CategoryServices();
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color:
                            _selectPage == Page.dashboard ? active : nonActive,
                      ),
                      label: Text("Dashboard"))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectPage == Page.manage ? active : nonActive,
                      ),
                      label: Text("Manage"))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.attach_money,
                    size: 30.0,
                    color: Colors.green,
                  ),
                  label: Text(
                    '12,000',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green),
                  )),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.people_outline),
                            label: Text("User")),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0, color: active),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text("Categories")),
                        subtitle: Text(
                          '23',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0, color: active),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.track_changes),
                            label: Text("Products")),
                        subtitle: Text(
                          '120',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0, color: active),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.track_changes),
                            label: Text("Sold")),
                        subtitle: Text(
                          '12',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0, color: active),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.shopping_cart),
                            label: Text("Orders")),
                        subtitle: Text(
                          '5',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0, color: active),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.close),
                            label: Text("Return")),
                        subtitle: Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60.0, color: active),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Product"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Products list"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Add category"),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Category list"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Add brand"),
              onTap: () {
                _brandAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text("Brand list"),
              onTap: () {},
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Category cannot be empty';
            }
            return null;
          },
          controller: categoryController,
          decoration: InputDecoration(hintText: "add Category"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (categoryController.text != null) {
              _categoryServices.createCategory(categoryController.text);
            }
            FormState formState = _categoryFormKey.currentState;
            formState.reset();
            Fluttertoast.showToast(msg: 'category created');
            Navigator.pop(context);
          },
          child: Text('ADD'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Brand cannot be empty';
            }
            return null;
          },
          controller: brandController,
          decoration: InputDecoration(hintText: "Add brand"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (brandController.text != null) {
              _brandServices.createBrand(brandController.text);
            }
            FormState formState = _brandFormKey.currentState;
            formState.reset();
            Fluttertoast.showToast(msg: 'brand created');
            Navigator.pop(context);
          },
          child: Text('ADD'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
