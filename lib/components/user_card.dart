import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';

class ArtistCard extends StatelessWidget {
  final ArtistModel artist;

  const ArtistCard({Key? key, required this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarView(
            url: artist.image,
            name: artist.name,
            size: 70,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            artist.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ).p8,
    ).round(10);
  }
}
