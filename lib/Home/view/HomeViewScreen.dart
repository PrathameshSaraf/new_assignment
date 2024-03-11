import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../Model/product.dart';
import '../../themes/app_text.dart';
import 'HomeViewModel.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  ScrollController controller = ScrollController();

  void _showQuantityDialog(BuildContext context, Product product, ) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Quantity'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Quantity'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                int newQuantity = int.tryParse(controller.text) ?? 0;
                  product.quantity += newQuantity; // Accumulate quantity
                Navigator.of(context).pop();
                _showJsonDialog(context, product);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  void _showJsonDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Product Details'),
          content: Text(
              'Name: ${product.name}\nCost: \$${product.cost.toString()}\nQuantity: ${product.quantity}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
     onViewModelReady: (viewModel) => viewModel.init(),
    builder: (BuildContext context, viewModel, child) {
       return Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 212,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xf0ff6860),
                              Colors.white
                            ])),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                            width: 260.w,
                            height: 160.w,
                            child: Image.network("https://img.freepik.com/free-vector/shop-with-sign-we-are-open_52683-38687.jpg")),
                        AppText("Saraf",context,fontSize: 22).bodyMedium,
                        AppText("Pune, Maharashtra",context,fontWeight: FontWeight.normal).bodyMedium,
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: AppText('Filters', context,fontSize: 17,).bodyMedium),
                      5.verticalSpace,
                      SizedBox(
                        height: 32,
                        width: double.infinity,
                        child: Center(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: viewModel.category.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {

                              return GestureDetector(
                                onTap: () {



                                  if (viewModel.selectedIndex == index) {
                                    viewModel.selectedIndex = -1;
                                  } else {
                                    viewModel.selectedIndex = index;
                                  }
                                  if (viewModel.selectedIndex == -1) {
                                    viewModel.displayedProducts = List.from(viewModel.products);
                                    viewModel.notifyListeners();
                                  } else {
                                    viewModel.displayedProducts =
                                        viewModel.products.where((product) => product.category == viewModel.category[viewModel.selectedIndex]).toList();
                                    viewModel.notifyListeners();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4),
                                    decoration: BoxDecoration(
                                        color:viewModel.selectedIndex == index ? Colors.green : Color(0xff88001f),
                                        border: Border.all(
                                            color:
                                            const Color(0xFFF4F4FF)),
                                        borderRadius:
                                        BorderRadius.circular(4)),
                                    child: Center(
                                      child: Text(viewModel.category[index],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ),
                                ),
                              );

                            },

                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(thickness: 2,),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.displayedProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 4, // Add shadow to the card
                      margin: EdgeInsets.all(8),
                      child:          ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            _showQuantityDialog(context, viewModel.displayedProducts[index]);
                          },
                        ),
                        title: GestureDetector(
                            onTap: (){
                              _showJsonDialog(context, viewModel.displayedProducts[index]);
                            },
                            child: Text(viewModel.displayedProducts[index].name)),
                        subtitle:Text('${viewModel.displayedProducts[index].details.toString()}'),
                        trailing:   Text('\$${viewModel.displayedProducts[index].cost.toString()}',style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                    );


                  },
                ),
              ),

            ],
          ),
       );
    });
  }
}
