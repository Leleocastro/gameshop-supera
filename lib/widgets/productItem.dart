import 'package:flutter/material.dart';
import 'package:gameshop_supera/exceptions/errException.dart';
import 'package:gameshop_supera/providers/product.dart';
import 'package:gameshop_supera/utils/appRoutes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/${product.image}'),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCTFORM,
                  arguments: product,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Tem certeza?'),
                    content: Text('Quer excluir o produto?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text(
                          'Não',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Produto removido!'),
                              duration: Duration(
                                seconds: 2,
                              ),
                            ),
                          );
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text(
                          'Sim',
                        ),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value) {
                    try {
                      // await Provider.of<Products>(context, listen: false)
                      //     .deleteProduct(product.id);
                    } on ErrException catch (error) {
                      print(error.toString());
                      scaffold.showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                        ),
                      );
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
