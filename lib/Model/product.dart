class Product {
  final String name;
  final int id;
  final double cost;
  final int availability;
  final String details;
  final String category;
  int quantity; // Updated field to store quantity

  Product({
    required this.name,
    required this.id,
    required this.cost,
    required this.availability,
    this.details = "",
    this.category = "",
    this.quantity = 0, // Initialize quantity to 0
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['p_name'],
      id: json['p_id'],
      cost: json['p_cost'].toDouble(),
      availability: json['p_availability'],
      details: json['p_details'] ?? "",
      category: json['p_category'] ?? "",
      quantity: json['p_quantity'] ?? 0, // Initialize quantity from JSON, default to 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'p_name': name,
      'p_id': id,
      'p_cost': cost,
      'p_availability': availability,
      'p_details': details,
      'p_category': category,
      'p_quantity': quantity, // Include quantity in JSON
    };
  }
}