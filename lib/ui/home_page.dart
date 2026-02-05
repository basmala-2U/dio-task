import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../data/network/api_service.dart';
import 'package:provider/provider.dart';
import '../data/providers/theme_provider.dart';

// home page screen that shows products list
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // future that will hold products coming from api
  late Future<List<ProductModel>> productsFuture;

  @override
  void initState() {
    super.initState();

    // call api once when the screen is created
    productsFuture = ApiService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // top app bar with title and theme switch button
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('Products', style: TextStyle(color: Colors.white)),

        // dark / light mode button using provider
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),

      // body depends on api response (loading, error, or data)
      body: FutureBuilder<List<ProductModel>>(
        future: productsFuture,
        builder: (context, snapshot) {
          // while waiting for api response
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // if something went wrong
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          // api data successfully received
          final products = snapshot.data!;

          // list of products
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              // single product card
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      // product image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.thumbnail,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // product title and price
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${product.price} \$',
                              style: const TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
