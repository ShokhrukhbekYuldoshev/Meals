# 🍴 Meals

<!-- codemagic status -->

[![Codemagic build status](https://api.codemagic.io/apps/6522a4b96aa51bb12d48ec88/6522a4b96aa51bb12d48ec87/status_badge.svg)](https://codemagic.io/apps/6522a4b96aa51bb12d48ec88/6522a4b96aa51bb12d48ec87/latest_build)

<!-- download codemagic android ios  -->

[![Download Android](https://img.shields.io/badge/Download-Android-green.svg)](https://api.codemagic.io/artifacts/f4239bb3-189f-4f68-a5ba-3611a0d9e674/e16dd854-c9a8-4950-8197-c5c44dca17cc/app-debug.aab)
[![Download iOS](https://img.shields.io/badge/Download-iOS-blue.svg)](https://api.codemagic.io/artifacts/43194651-3c10-424c-9746-9c5ce2c3e0b1/2c61c7bb-9368-4c9f-9933-1b73b6a51c90/Runner.app.zip)

## 📝 Description

Flutter app that uses Clean Architecture with Bloc and the [themealdb.com](https://www.themealdb.com/) API.

## 📱 Platforms

| Android | iOS | Web | MacOS | Linux | Windows |
| :-----: | :-: | :-: | :---: | :---: | :-----: |
|   ✔️    | ✔️  | ✔️  |  ✔️   |  ✔️   |   ✔️    |

## ✨ Features

-   [x] List of meals
-   [x] Meal details
-   [x] Ingredients
-   [x] Instructions with video (if available)
-   [x] Search meals
-   [x] Filter meals by category
-   [ ] Filter meals by area
-   [ ] Filter meals by ingredients
-   [x] Filter meals by letter
-   [ ] Filter meals by tags
-   [x] Dark mode

## 📸 Screenshots

<!-- variables -->

[home]: screenshots/home.png 'Home'
[category_list]: screenshots/category_list.png 'Category List'
[category_meals]: screenshots/category_meals.png 'Category Meals'
[meal_details_1]: screenshots/meal_details_1.png 'Meal Details 1'
[meal_details_2]: screenshots/meal_details_2.png 'Meal Details 2'
[search]: screenshots/search.png 'Search'
[meals_by_letter]: screenshots/meals_by_letter.png 'Meals by Letter'

<!-- Table -->

|     Home      |
| :-----------: |
| ![home][home] |

|          Category List          |
| :-----------------------------: |
| ![category_list][category_list] |

|          Category Meals           |
| :-------------------------------: |
| ![category_meals][category_meals] |

|          Meal Details 1           |
| :-------------------------------: |
| ![meal_details_1][meal_details_1] |

|          Meal Details 2           |
| :-------------------------------: |
| ![meal_details_2][meal_details_2] |

|      Search       |
| :---------------: |
| ![search][search] |

|           Meals by Letter           |
| :---------------------------------: |
| ![meals_by_letter][meals_by_letter] |

## 📚 Dependencies

| Name                                                                      | Version | Description                                                         |
| ------------------------------------------------------------------------- | ------- | ------------------------------------------------------------------- |
| [bloc](https://pub.dev/packages/bloc)                                     | 8.1.2   | A predictable state management library                              |
| [equatable](https://pub.dev/packages/equatable)                           | 2.0.5   | Simplify Equality Comparisons                                       |
| [get_it](https://pub.dev/packages/get_it)                                 | 7.6.4   | Simple direct Service Locator that allows to decouple the interface |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)                     | 8.1.3   | Flutter Widgets that make it easy to implement BLoC design patterns |
| [connectivity_plus](https://pub.dev/packages/connectivity_plus)           | 4.0.2   | Flutter plugin for discovering the state of the network connection  |
| [dartz](https://pub.dev/packages/dartz)                                   | 0.10.1  | Functional programming in Dart                                      |
| [dio](https://pub.dev/packages/dio)                                       | 5.3.3   | A powerful Http client for Dart, which supports Interceptors        |
| [url_launcher](https://pub.dev/packages/url_launcher)                     | 6.1.12  | A Flutter plugin for launching a URL in the mobile platform.        |
| [window_manager](https://pub.dev/packages/window_manager)                 | 0.3.6   | A Flutter plugin to manage windows on Linux, MacOS and Windows      |
| [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | 0.13.1  | A package that provides icons for Flutter apps                      |

## 📦 Installation

### Prerequisites

-   Flutter
-   Android Studio / Xcode

### Setup

1. Clone the repo

```sh
git clone
```

2. Install dependencies

```sh
dart pub get
```

3. Run the app

```sh
flutter run
```

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## 👨‍💻 Author

**Shokhrukhbek Yuldoshev**

-   Github: [@ShokhrukhbekYuldoshev](https://github.com/ShokhrukhbekYuldoshev)
-   Email: [@shokhrukhbekdev@gmail.com](mailto:shokhrukhbekdev@gmail.com)

## 🌟 Show your support

Give a ⭐️ if you like this project!
