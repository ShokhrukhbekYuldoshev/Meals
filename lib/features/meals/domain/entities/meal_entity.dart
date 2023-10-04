import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  final String id;
  final String name;
  final String? thumbnail;
  final String? category;
  final String? area;
  final String? instructions;
  final String? tags;
  final String? youtube;
  final String? source;
  final String? imageSource;
  final bool? isFavorite;
  final List<String> ingredients;
  final List<String> measures;

  const MealEntity({
    required this.id,
    required this.name,
    this.thumbnail,
    this.category,
    this.area,
    this.instructions,
    this.tags,
    this.youtube,
    this.source,
    this.imageSource,
    this.isFavorite,
    required this.ingredients,
    required this.measures,
  });

  factory MealEntity.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    final measures = <String>[];
    for (var i = 1; i <= 20; i++) {
      if (json['strIngredient$i'] != null && json['strIngredient$i'] != '') {
        ingredients.add(json['strIngredient$i']);
      }
      if (json['strMeasure$i'] != null && json['strMeasure$i'] != '') {
        measures.add(json['strMeasure$i']);
      }
    }
    return MealEntity(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      tags: json['strTags'],
      youtube: json['strYoutube'],
      source: json['strSource'],
      imageSource: json['strImageSource'],
      isFavorite: json['isFavorite'],
      ingredients: ingredients,
      measures: measures,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        thumbnail,
        category,
        area,
        instructions,
        tags,
        youtube,
        source,
        imageSource,
        isFavorite,
        ingredients,
        measures,
      ];
}

// ====================================================================================================================
// EXAMPLE:
// {
//       "idMeal": "52768",
//       "strMeal": "Apple Frangipan Tart",
//       "strDrinkAlternate": null,
//       "strCategory": "Dessert",
//       "strArea": "British",
//       "strInstructions": "Preheat the oven to 200C/180C Fan/Gas 6.\r\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\r\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\r\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\r\nBake for 20-25 minutes until golden-brown and set.\r\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\r\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, crème fraiche or ice cream.",
//       "strMealThumb": "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
//       "strTags": "Tart,Baking,Fruity",
//       "strYoutube": "https://www.youtube.com/watch?v=rp8Slv4INLk",
//       "strIngredient1": "digestive biscuits",
//       "strIngredient2": "butter",
//       "strIngredient3": "Bramley apples",
//       "strIngredient4": "butter, softened",
//       "strIngredient5": "caster sugar",
//       "strIngredient6": "free-range eggs, beaten",
//       "strIngredient7": "ground almonds",
//       "strIngredient8": "almond extract",
//       "strIngredient9": "flaked almonds",
//       "strIngredient10": "",
//       "strIngredient11": "",
//       "strIngredient12": "",
//       "strIngredient13": "",
//       "strIngredient14": "",
//       "strIngredient15": "",
//       "strIngredient16": null,
//       "strIngredient17": null,
//       "strIngredient18": null,
//       "strIngredient19": null,
//       "strIngredient20": null,
//       "strMeasure1": "175g/6oz",
//       "strMeasure2": "75g/3oz",
//       "strMeasure3": "200g/7oz",
//       "strMeasure4": "75g/3oz",
//       "strMeasure5": "75g/3oz",
//       "strMeasure6": "2",
//       "strMeasure7": "75g/3oz",
//       "strMeasure8": "1 tsp",
//       "strMeasure9": "50g/1¾oz",
//       "strMeasure10": "",
//       "strMeasure11": "",
//       "strMeasure12": "",
//       "strMeasure13": "",
//       "strMeasure14": "",
//       "strMeasure15": "",
//       "strMeasure16": null,
//       "strMeasure17": null,
//       "strMeasure18": null,
//       "strMeasure19": null,
//       "strMeasure20": null,
//       "strSource": null,
//       "strImageSource": null,
//       "strCreativeCommonsConfirmed": null,
//       "dateModified": null
//     },