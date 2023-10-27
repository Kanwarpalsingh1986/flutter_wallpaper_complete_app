import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black12,
          child: Image.network(
            category.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ).round(10),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.black38,
          ).round(10)
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 10,
          child: Text(
            category.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600,color: Colors.white),
          ),
        )
      ],
    );
  }
}

class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: category.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ).round(10),
        const SizedBox(width: 10,),
        Expanded(
          child: Text(
            category.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
