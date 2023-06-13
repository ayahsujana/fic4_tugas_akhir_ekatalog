import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_pagination_bloc/get_pagination_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product_wishlist/product_cubit_cubit.dart';
import 'package:fic4_flutter_auth_bloc/presentation/widget/add_product_widget.dart';
import 'package:fic4_flutter_auth_bloc/presentation/widget/logout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'all_products_page.dart';
import 'wishlist_products_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    context.read<GetPaginationProductBloc>().add(GetProductWithPagination());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
                height: 50,
                width: 50,
                image: AssetImage('assets/logo/logo.jpg')),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'My Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(MdiIcons.cartHeart),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_box)),
          IconButton(
              onPressed: () => LogoutFunction().logoutNow(context),
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          TabBar(controller: tabController, tabs: const [
            Tab(
              text: 'Latest Products',
            ),
            Tab(
              text: 'Wishlist Products',
            )
          ]),
          Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: const [AllProducts(), WistlistProduct()]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddNewProduct().addNewProduct(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
