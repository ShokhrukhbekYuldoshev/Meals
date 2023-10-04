import 'package:meals/features/meals/domain/entities/meal_entity.dart';

class MealModel extends MealEntity {
  const MealModel({
    required String id,
    required String name,
    String? thumbnail,
    String? category,
    String? area,
    String? instructions,
    String? tags,
    String? youtube,
    String? source,
    String? imageSource,
    bool? isFavorite,
    required List<String> ingredients,
    required List<String> measures,
  }) : super(
          id: id,
          name: name,
          thumbnail: thumbnail,
          category: category,
          area: area,
          instructions: instructions,
          tags: tags,
          youtube: youtube,
          source: source,
          imageSource: imageSource,
          isFavorite: isFavorite,
          ingredients: ingredients,
          measures: measures,
        );

  factory MealModel.fromJson(Map<String, dynamic> json) {
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
    return MealModel(
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

  factory MealModel.fromEntity(MealEntity entity) => MealModel(
        id: entity.id,
        name: entity.name,
        thumbnail: entity.thumbnail,
        category: entity.category,
        area: entity.area,
        instructions: entity.instructions,
        tags: entity.tags,
        youtube: entity.youtube,
        source: entity.source,
        imageSource: entity.imageSource,
        isFavorite: entity.isFavorite,
        ingredients: entity.ingredients,
        measures: entity.measures,
      );
}
