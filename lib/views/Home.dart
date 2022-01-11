import 'package:flutter/material.dart';
import 'package:groceryapptesting/bloc/CartBloc.dart';
import 'package:groceryapptesting/components/CartManager.dart';
import 'package:groceryapptesting/components/CategoryDropMenu.dart';

import '../../../../../Downloads/groceryapptesting1/lib/views/auth_service.dart';
import '../../../../../Downloads/groceryapptesting1/lib/main.dart';

class MyHomePage extends StatefulWidget {
  final bool isAdminLogin;
  const MyHomePage({Key key, this.isAdminLogin = false}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showCart = false;
  CartBloc _cartBloc;

  ScrollController _scrollController = new ScrollController();

  @override
  initState() {
    super.initState();

    _scrollController = new ScrollController();
    _cartBloc = new CartBloc();

    _cartBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: new Stack(children: <Widget>[
          new CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                new SliverToBoxAdapter(
                    child: new CategoryDropMenu(
                  isAdminLogin: widget.isAdminLogin,
                )),
                new SliverToBoxAdapter(child: new CartManager()),
              ]),
          new Align(
              alignment: Alignment.bottomRight,
              child: new Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10),
                  child: (!widget.isAdminLogin)
                      ? FloatingActionButton(
                          onPressed: () {
                            if (_showCart)
                              _scrollController.animateTo(
                                  _scrollController.position.minScrollExtent,
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(seconds: 2));
                            else
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(seconds: 2));

                            setState(() {
                              _showCart = !_showCart;
                            });
                          },
                          backgroundColor: Colors.amber,
                          child: new Icon(
                              _showCart ? Icons.close : Icons.shopping_cart))
                      : const SizedBox())),
          new Align(
              alignment: Alignment.bottomRight,
              child: new Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10),
                  child: (widget.isAdminLogin)
                      ? MaterialButton(
                          onPressed: () {
                            AuthService().signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          color: Colors.amber,
                          child: new Icon(_showCart
                              ? Icons.close
                              : IconData(0xe3b3, fontFamily: 'MaterialIcons')))
                      : const SizedBox()))
        ]));
  }

  @override
  void dispose() {
    _cartBloc.dispose();
    super.dispose();
  }
}
