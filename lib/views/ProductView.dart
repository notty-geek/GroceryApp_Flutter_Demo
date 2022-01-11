import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceryapptesting/bloc/CartBloc.dart';
import 'package:groceryapptesting/global/global_widgets.dart';
import 'package:groceryapptesting/models/GroceryOrder.dart';
import 'package:groceryapptesting/models/GroceryProduct.dart';
import 'package:groceryapptesting/repositories/ProductsRepository.dart';
import 'package:groceryapptesting/views/Home.dart';

class ProductView extends StatefulWidget {
  final Product product;
  final bool isAdminLogin;
  List<Product> all_products;

  ProductView({Key key, this.product, this.isAdminLogin = false, this.all_products})
      : super(key: key);

  @override
  _ProductView createState() => new _ProductView();
}

class _ProductView extends State<ProductView> {
  final CartBloc _cartBloc = new CartBloc();
  int _quantity = 1;

  TextEditingController costController, aboutController;

  bool isEditing = false;
  var dropDownVal;
  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  void initState() {
    costController = TextEditingController(
        text: "\$${(widget.product.price).toStringAsFixed(2)}");
    aboutController = TextEditingController(text: widget.product.about);
    dropDownVal = (widget.product.canBeDelivered) ? 'Yes' : 'No';

    print("ProductView");
    print(widget.isAdminLogin);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: new AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black)),
        body: new SafeArea(
            child: new Column(children: <Widget>[
              new Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: MediaQuery.of(context).size.height * 0.73,
                  child: new SingleChildScrollView(
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Center(
                                child: new StreamBuilder(
                                    initialData: null,
                                    stream: _cartBloc.observableLastOrder,
                                    builder: (context, AsyncSnapshot<Order> snapshot) {
                                      String tag = snapshot.data == null
                                          ? "tagHero${widget.product.id}"
                                          : "tagHeroOrder${snapshot.data.id+1}";
                                      return new Hero(
                                          tag: tag,
                                          child: new Image.asset(
                                              widget.product.urlToImage,
                                              fit: BoxFit.cover,
                                              height:
                                              MediaQuery.of(context).size.height *
                                                  0.4));
                                    })),
                            new Container(
                              margin: EdgeInsets.only(top: 20),
                              child: new Text(widget.product.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      color: Colors.black)),
                            ),
                            new Container(
                              margin: EdgeInsets.only(top: 10),
                              child: new Text("${widget.product.weight}g",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.grey)),
                            ),
                            new Container(
                                margin: EdgeInsets.only(top: 20),
                                child: new Row(
                                    mainAxisAlignment: (!widget.isAdminLogin)
                                        ? MainAxisAlignment.spaceBetween
                                        : MainAxisAlignment.start,
                                    children: <Widget>[
                                      (!widget.isAdminLogin)
                                          ? new Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border:
                                            Border.all(color: Colors.grey),
                                            borderRadius:
                                            BorderRadius.circular(50)),
                                        child: new Row(children: <Widget>[
                                          new InkWell(
                                            child: new Icon(
                                              Icons.remove,
                                              size: 15,
                                            ),
                                            onTap: _decrement,
                                          ),
                                          new Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: new Text(
                                                  _quantity.toString(),
                                                  style:
                                                  TextStyle(fontSize: 20))),
                                          new InkWell(
                                            child: new Icon(
                                              Icons.add,
                                              size: 15,
                                            ),
                                            onTap: _increment,
                                          ),
                                        ]),
                                      )
                                          : const SizedBox(),
                                    ])),
                            (!isEditing)
                                ? Padding(
                                  padding: const EdgeInsets.only(top: 15.0,left: 10.0),
                                  child: new Text(
                                  "\$${(widget.product.price * _quantity).toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                      color: Colors.black)),
                                )
                                : _getEditWidget(
                                controller: costController,
                                title: 'Cost',
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                onChanged: (val) {
                                  if (costController.text.length <= 1) {
                                    costController.text = '\$';
                                    costController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: costController.text.length));
                                  }
                                }),
                            (!isEditing)
                                ? new Container(
                                margin: EdgeInsets.only(top: 40, bottom: 40),
                                child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text("About the product:",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      new Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: new Text(widget.product.about,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18)))
                                    ]))
                                : Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: _getEditWidget(
                                  controller: aboutController,
                                  title: 'About',
                                )),
                            if(!isEditing && widget.isAdminLogin)
                              _getTextWidget('Can be delivered ?', dropDownVal),
                            if (isEditing) _getDropDown()
                          ]))),
              new Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 30.0,
                    spreadRadius: 5.0,
                    offset: Offset(
                      0.0,
                      -20.0,
                    ),
                  )
                ]),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.1,
                child: (!widget.isAdminLogin)
                    ? new CommonAppButton(
                  onTap: () {
                    _cartBloc.addOrderToCart(widget.product, _quantity);
                    Navigator.of(context).pop();
                  },
                  buttonText: "Add to cart",
                )
                    : CommonAppButton(
                  buttonText: (!isEditing) ? 'Edit' : 'Save',
                  onTap: () async {
                    (!isEditing) ? onEditClicked() : onSaveClicked();
                  },
                ),
              )
            ])));
  }

  onEditClicked() {
    setState(() {
      isEditing = true;
    });
  }

  onSaveClicked() async {
    _getLoader();
    String msg = '';
    if (costController.text.length <= 1)
      msg = 'Cost Field cannot be empty';
    else if (double.tryParse(costController.text.substring(1)) == null)
      msg = 'Invalid input in cost field';
    else if (aboutController.text.isEmpty) msg = 'About field cannot be empty.';

    if (msg != '') {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(msg),
            actions: [
              CupertinoDialogAction(
                  child: ElevatedButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ))
            ],
          ));
      return;
    }


     widget.all_products.firstWhere((element) {
      if (element.title == widget.product.title) {
        element.price = double.parse(costController.text.substring(1));
        element.about = aboutController.text;
        element.canBeDelivered = (dropDownVal == 'Yes') ? true : false;
        return true;
      }
      return false;
    });


    var result = await ProductsRepository().update_data(widget.product);
    print(result);
    Future.delayed(Duration(seconds: 4), () {
      // Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(isAdminLogin: widget.isAdminLogin,)));


    });
    setState(() {
      isEditing = false;
    });



  }

  Widget _getEditWidget(
      {String title,
        var keyboardType,
        @required TextEditingController controller,
        Function onChanged}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
          TextField(
            keyboardType: keyboardType ?? TextInputType.text,
            onChanged: onChanged,
            controller: controller,
          )
        ],
      ),
    );
  }

  Widget _getTextWidget(String title, String data)
  {
    return Container(
      width: double.infinity,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
          SizedBox(height: 15,),
          Text(
            data,
            style: TextStyle(
                fontWeight: FontWeight.normal, fontSize: 18, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget _getDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Can be delivered?',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
          DropdownButton(
            items: <DropdownMenuItem>[
              DropdownMenuItem(
                child: Text('Yes'),
                value: 'Yes',
              ),
              DropdownMenuItem(
                child: Text('No'),
                value: 'No',
              )
            ],
            onChanged: (val) {
              setState(() {
                dropDownVal = val;
              });
            },
            isExpanded: true,
            value: dropDownVal,
          ),
        ],
      ),
    );
  }

  Widget _getLoader() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 15.0,
            ),
          );
        },
        barrierDismissible: false);
  }
}
