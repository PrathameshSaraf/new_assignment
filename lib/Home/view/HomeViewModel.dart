import 'dart:convert';
import 'package:stacked/stacked.dart';
import '../../Model/product.dart';

class HomeViewModel extends BaseViewModel{
  List<Product> products=[];
  List<Product> displayedProducts=[];
  List<String> category=[];
  int selectedIndex=-1;


  void init(){
    products = _loadProductsFromJson();
    category= getCategoryListFromJson();
    displayedProducts = List.from(products);
  }

  List<String> getCategoryListFromJson() {
    Set<String> categories = Set();
    for (var product in products) {
      if (product.category.isNotEmpty) {
        categories.add(product.category);
      }
    }
    return categories.toList();
  }

  List<Product> _loadProductsFromJson() {
    String jsonString = '''
    [
      {
        "p_name": "Apple",
        "p_id": 1,
        "p_cost": 30,
        "p_availability": 1,
        "p_details": "Imported from Swiss",
        "p_category": "Premium"
      },
      {
        "p_name": "Mango",
        "p_id": 2,
        "p_cost": 50,
        "p_availability": 1,
        "p_details": "Farmed at Selam",
        "p_category": "Tamilnadu"
      },
      {
        "p_name": "Banana",
        "p_id": 3,
        "p_cost": 5,
        "p_availability": 0
      },
      {
        "p_name": "Orange",
        "p_id": 4,
        "p_cost": 25,
        "p_availability": 1,
        "p_details": "from Nagpur",
        "p_category": "Premium"
      }
    ]
    ''';

    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }


}