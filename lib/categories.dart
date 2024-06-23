import 'package:flutter/material.dart';
import 'package:new_task/view_all.dart';

import 'cubits/products_cubit.dart';
import 'cubits/state.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> items = {
      'assets/categories/men.jpg': 'Men',
      'assets/categories/women.jpg': 'Women',
    };
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: items.entries.map((entry) {
          return Flexible(
            child: _buildCategoryContainer(
              image: entry.key,
              label: entry.value,
              context: context,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryContainer({
    required String image,
    required String label,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () async {
        final ProductCubit cubit = ProductCubit();
        label == 'Men'
            ? await cubit.getMaleProducts()
            : await cubit.getFemaleProducts();
        final state = cubit.state;
        if (state is SuccessState) {
          final products = state.data;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewAll(products: products)));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
