import 'package:new_pokemon_app/config/constants.dart';
import 'package:new_pokemon_app/config/theme.dart';

import 'package:new_pokemon_app/core/utils/extensions/context.dart';
import 'package:new_pokemon_app/core/utils/extensions/string.dart';
import 'package:new_pokemon_app/core/utils/pokemon_types.dart';

import 'package:new_pokemon_app/core/widgets/gap.dart';
import 'package:new_pokemon_app/core/widgets/loading_indicator.dart';
import 'package:new_pokemon_app/core/widgets/image.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';

import 'package:new_pokemon_app/generator/assets.gen.dart';

import 'package:new_pokemon_app/presentation/bloc/pokemon_cubit.dart';
import 'package:new_pokemon_app/presentation/bloc/favourite_pokemon_cubit.dart';
