import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(
      HomeLoadingDate(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash Store'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final product = state.productList[index];
                  return Card(
                    child: GridTile(
                      footer: GridTileBar(
                        subtitle: Text(
                          "${product.price} \$",
                          style:
                              const TextStyle(backgroundColor: Colors.black54),
                        ),
                        title: Text(
                          product.title.toString(),
                          style: const TextStyle(
                            backgroundColor: Colors.black54,
                          ),
                        ),
                      ),
                      child: Image.network(product.image.toString()),
                    ),
                  );
                });
          } else if (state is HomeError) {
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
                size: 120,
              ),
            );
          } else {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return const Card();
                });
          }
        },
      ),
    );
  }
}
