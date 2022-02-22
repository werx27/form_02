import 'package:flutter/foundation.dart';

class ItemModel {
  String id;
  String title;
  double price;

  ItemModel({
    required this.id,
    required this.title,
    required this.price,
  });
}

class Item with ChangeNotifier {
  final List<ItemModel> _items = [
    ItemModel(
      id: '01',
      title: 'Title 01',
      price: 55.69,
    ),
    ItemModel(
      id: '02',
      title: 'Title 02',
      price: 39.11,
    ),
    ItemModel(
      id: '03',
      title: 'Title 03',
      price: 25.89,
    ),
    ItemModel(
      id: '04',
      title: 'Title 04',
      price: 17.34,
    ),
  ];

  List<ItemModel> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  ItemModel findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void editItem(ItemModel item) {
    if (item.id == '') {
      final newItem = ItemModel(
        id: item.id,
        title: item.title,
        price: item.price,
      );
      _items.insert(0, newItem);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    ItemModel item = findById(id);
    _items.remove(item);
    notifyListeners();
  }
}
