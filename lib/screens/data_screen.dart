import 'package:flutter/material.dart';
import 'package:form_03/models/item_model.dart';
import 'package:form_03/routes/routes.dart';
import 'package:provider/provider.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _itemData = Provider.of<Item>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RouteManager.formScreen, arguments: '');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: _itemData.itemCount == 0
            ? Container(
                alignment: Alignment.center,
                child: const Text(
                  'Add new data \nwith +',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: _itemData.itemCount,
                itemBuilder: (context, index) => Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$${_itemData.items[index].price}'),
                      ],
                    ),
                    title: Text(_itemData.items[index].title),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  RouteManager.formScreen,
                                  arguments: _itemData.items[index].id);
                            },
                            icon: const Icon(Icons.edit),
                            color: Theme.of(context).primaryColor,
                          ),
                          IconButton(
                            onPressed: () {
                              _itemData.removeItem(_itemData.items[index].id);
                            },
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
