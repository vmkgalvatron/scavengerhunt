# Scavenger Hunt Game in Flutter

## Getting Started
To get started with the application, we have assumed used these pre-requisites -
1. Visual Studio Code (VS Code)
2. Flutter V 2.2.1 or greater (not tested yet)
3. Dart 2.12 or greater

- Clone the repo locally and open it in VS Code 
By default, the VS code will recognize and request Flutter SDK. Choose the SDK.

- VS Code by default runs -> flutter pub get [verify if you need to save `pubspec.yaml` before it runs]
 
For help getting started with Flutter, view our [online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a complete API reference.


## Main Objective 
Create a starter application that can be used as a base to build upon with the following features listed in the feature table below.

| Feature | Description |
|--- |--- |
| [Cloud Firestore](#cloud-firestore) | The Application is mainly based on Firestore features like storing data, retriving data. and This is used to store the details of game and its players and activities|
| [Firebase Storage](#firebase-storage) | Firebase Storage is used to store images uploaded by users |
| [Random String](#random-string) | Random String Package is used to generate the random game code and random name of image file. |
| [Image picker](#image-picker) | Image picker package is used to select the image to complete the activity.  |
| [Shared Preferences](#shared-preferences) | Shared Prefrences helps to store data to persistent storage using string list. |
| [Firebase Core](#firebase-core) | A Flutter plugin to use the Firebase Core API, which enables connecting to multiple Firebase apps. |

## File Structure 
Inside the `/lib` folder
| **Folder** 	| **Subfolder/File** 	| **Description** 	|
|---	|---	|---	|
| /services 	|  	| Includes all the backend classes. 	|
|  	| database.dart 	| Class contains all firebase related methods to create collection or delete collection or update collection,etc.	|
|  	| sharedprefs.dart 	| SharedPrefs class containing all the functions related to shared preferences. 	|
|  	| uploadpost.dart | Contains methods to pick image and upload it to firebase storage. |
| /widgets 	|  	| internationalization and Localization diretory 	|
|  	| activity_widget.dart.dart 	| widget that will be displayed in ActivityScreen 	|
|  	| add_activity_dialogue.dart 	| Displays a Dialog to set the activities 	|
|  	| appbar_with_edit.dart 	| Displays AppBar that can change the title 	|
|  	| feed_widget.dart 	| Widget that will displayed in the Game Feed Screen 	|
|  	| loading_dialog.dart 	| Displayes a Dialog Box with Circular Progress Indicator 	|
|  	| player_score_widget.dart 	| Widget that will displayed in the LeaderBoard Screen 	|
|  	| removed_dialog.dart 	| Widget that will displayed when player is removed from game. 	|
|  	| textfield_with_title.dart 	| 	|
| /models	|  	| Components that help to store the data.	|
|  	| activity.dart	| model Class storing information of a particular activity	|
|  	| game.dart 	| model Class storing information of a particular game 	|
|  	| player.dart 	| model Class storing information of a particular player 	|
|  	| post.dart 	| model Class storing information of a particular post 	|
| /screens 	|  	| Screen view of the game 	|
|  	| home_screen.dart 	| The first screen user will see when app is initiated 	|
|  	| create_game.dart 	| Screen that will help host of game to create a game. 	|
|  	| new_game.dart 	| Screen that will help host of game to create activities of game. 	|
|  	| published_game.dart 	| This will be showing the players who had joined the game. |
|  	| live_game.dart 	| This is a Tab View of 3 Screens (activity_screen.dart,leader_board.dart and game_feed.dart 	|
|  	| complete_activity.dart 	| View from which player will be able to complete the activities set by user.	|
|  	| join_game.dart 	| Screen that will help other users of game to join a particular game using game code. 	|
| main.dart 	|  	| initialise the app and redirect to home_screen.	|
| constants.dart 	|  	| Having the constants like max_players and code_length.	|
