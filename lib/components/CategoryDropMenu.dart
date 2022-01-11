import 'package:flutter/material.dart';
import 'package:groceryapptesting/models/GroceryProduct.dart';
import 'package:groceryapptesting/repositories/ProductsRepository.dart';

import 'MinimalCart.dart';
import 'ProductWidget.dart';

class CategoryDropMenu extends StatefulWidget {
  final bool isAdminLogin;

  const CategoryDropMenu({Key key, this.isAdminLogin = false})
      : super(key: key);

  @override
  _CategoryDropMenu createState() => new _CategoryDropMenu();
}

class _CategoryDropMenu extends State<CategoryDropMenu> {
  String dropdownValue = "Fruits";
  String sortdropdownValue = "Price High to Low";
  List<Product> _products = [];
  getFetchData(filter_type, value) async {
    dynamic result = await ProductsRepository().get_data(filter_type, value);
    if (result == null) {
      print("List is null");
    } else {
      setState(() {
        // print(widget.dropValue);
        _products = result;
      });
    }
  }

  void initState() {
    print(widget.isAdminLogin);

    super.initState();
    getFetchData("category", dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    double _gridSize =
        MediaQuery.of(context).size.height * 0.88; //88% of screen
    double childAspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 1.0);


    return new Column(children: <Widget>[
      new Container(
          height: _gridSize,
          decoration: BoxDecoration(
              color: const Color(0xFFeeeeee),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(_gridSize / 10),
                  bottomRight: Radius.circular(_gridSize / 10))),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: new Column(children: <Widget>[
            new Container(
                margin: EdgeInsets.only(top: 40),
                child: new Column(children: <Widget>[
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DropdownButtonHideUnderline(
                            child: new DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              getFetchData("category", dropdownValue);
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GridShop(dropValue: dropdownValue,)));
                            });
                          },
                          items: <String>[
                            'Fruits',
                            'Vegetables',
                            'Sauce',
                            'Rice',
                            'Flours',
                            'Dairy Products'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            );
                          }).toList(),
                        )),
                        new DropdownButtonHideUnderline(
                            child: new DropdownButton<String>(
                          value: sortdropdownValue,
                          icon: new Icon(Icons.filter_list),
                          onChanged: (String newValue) {
                            setState(() {
                              sortdropdownValue = newValue;
                              getFetchData("price", sortdropdownValue);
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GridShop(dropValue: dropdownValue,)));
                            });
                          },
                          items: <String>[
                            'Price High to Low',
                            'Price Low to High'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            );
                          }).toList(),
                        )),
                      ]),
                  new Container(
                      height: _gridSize - 88,
                      margin: EdgeInsets.only(top: 0),
                      child: new PhysicalModel(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(_gridSize / 10 - 10),
                              bottomRight:
                                  Radius.circular(_gridSize / 10 - 10)),
                          clipBehavior: Clip.antiAlias,
                          child: new GridView.builder(
                              itemCount: _products.length,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: childAspectRatio),
                              itemBuilder: (BuildContext context, int index) {
                                return new Padding(
                                    padding: EdgeInsets.only(
                                        top: index % 2 == 0 ? 20 : 0,
                                        right: index % 2 == 0 ? 5 : 0,
                                        left: index % 2 == 1 ? 5 : 0,
                                        bottom: index % 2 == 1 ? 20 : 0),
                                    child: ProductWidget(
                                        all_products: _products,
                                        product: _products[index],
                                        isAdminLogin: widget.isAdminLogin));
                              })))
                ]))
          ])),
      new MinimalCart(_gridSize, widget.isAdminLogin)
    ]);
  }
}
