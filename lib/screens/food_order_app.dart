import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(FoodOrderApp());
}

class FoodOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Food Order'),
        ),
        drawer: Drawer(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                color: Colors.teal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "MESC Prakash",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Flutter Developer",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.menuItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cartProvider.menuItems[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addItem(cartProvider.menuItems[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Food Order App',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                    child: Text('View Cart (${cart.itemCount})'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView.builder(
        itemCount: cartProvider.menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartProvider.menuItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addItem(cartProvider.menuItems[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  title: Text(item),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      cart.removeItem(item);
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Order Confirmation'),
                  content: Text('Your order has been placed.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        cart.clear();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
