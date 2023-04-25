import 'package:new_pokemon_app/config/constants.dart';
import 'package:new_pokemon_app/config/theme.dart';

import 'package:new_pokemon_app/core/utils/extensions/context.dart';
import 'package:new_pokemon_app/core/utils/extensions/string.dart';
import 'package:new_pokemon_app/core/widgets/image.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';

import 'package:new_pokemon_app/presentation/pokemon_info/pokemon_info.dart';

import 'package:flutter/material.dart';

class PokemonGridItem extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonGridItem(this.pokemon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(PokemonInfoPage(pokemon)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Insets.xs),
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Hero(
              tag: ValueKey(pokemon.id),
              child: HostedImage(
                pokemon.imageUrl,
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    pokemon.pokeAppId,
                    style: const TextStyle(color: AppColours.textBodyColour),
                  ),
                  Text(
                    pokemon.name.capitalize(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
