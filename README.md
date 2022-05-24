# Shell for new mobile applications using Flutter

[![Codemagic build status](https://api.codemagic.io/apps/60a4747c00a2d3dc4254838e/60a4747c00a2d3dc4254838d/status_badge.svg)](https://codemagic.io/apps/60a4747c00a2d3dc4254838e/60a4747c00a2d3dc4254838d/latest_build)

## Getting Started
To get started with the application, we have assumed used these pre-requisites -
1. Visual Studio Code (VS Code)
2. Flutter V 2.2.1 or greater (not tested yet)
3. Dart 2.12 or greater

- Clone the repo locally and open it in VS Code 
By default, the VS code will recognize and request Flutter SDK. Choose the SDK.

Please refer to the detailed docs *[here](https://github.com/hlth-dev/app-shell/blob/main/Docs/GettingStarted.md)* for **Getting started** with this template.

- VS Code by default runs -> flutter pub get [verify if you need to save `pubspec.yaml` before it runs]
 
For help getting started with Flutter, view our [online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a complete API reference.


## Main Objective 
Create a starter application that can be used as a base to build upon with the following features listed in the feature table below.

| Feature | Description |
|--- |--- |
| [Auth0 Authentication](#authentication-using-auth0) | Using Auth0 and Flutter AppAuth,we have implemented universal login from Auth0. |
| [Landing Page](#landing-page) | A Getting Started / Landing page implemented with scrollable page view. |
| [State Management](#state-management) | Provider Package along with custom streams for login and Secure login State Management. |
| [Splashscreen](#splashscreen) | Generating Native SplashScreen for Web, Android and iOS with Flutter_native_splash. |
| [Secure Login with Biometrics/<br> Local Authentication](#secure-login-with-biometrics) | Local Auth helps us handle biometric Authentication it is coupled with the feature to <br> secure login and securely resume using the application after switching apps. |
| [Bottom Navigation Bar](#bottom-navigation-bar) | Home Screen containing a bottom navigation bar to switch 5 screens / pages/ tabs. |
| [Connectivity](#connectivity) | Provides functionality to check if user is connected to internet or wifi and has internet connection. |
| [Internationalization and<br> Localization](#internationalization-and-localization) | To provide improve accessibility by additional Language support. |
| [Theming](#themeing) | Global Custom Theme is implemented using Material App, for light and dark modes. |
| [Snackbars](#snackbars) | Custom snackbars to display Authentication Errors and Unexpected Instances. |
| [Logging](#logging) | Multi Level Logging for log management. |
| [Notifications](#notifications) | Local Notifications for instant and scheduled Notifications |
| [Permissions](#permissions) | Using Permission Handler to view App Settings , and handle app permissions. |
| [Help Center](#help-center) | Additional Menu with Report a bug , send feedback and privacy policy. |




## File Structure 
Inside the `/lib` folder
| **Folder** 	| **Subfolder/File** 	| **Description** 	|
|---	|---	|---	|
| /Authentication 	|  	| components for Authentication flow 	|
|  	| /constants 	| keys required for Authentication with Auth0 	|
|  	| /models 	| user models, Abstract Classes and Auth0 Service class 	|
|  	| wrapper.dart 	| state Management logic for Authentication Flow 	|
| /l10n 	|  	| internationalization and Localization diretory 	|
|  	| app_en.dart 	| locale keys and description for English Language 	|
|  	| app_es.dart 	| locale keys and description for Spanish Language 	|
|  	| l10n.dart 	| class containing list of all supported languages 	|
| /Landing 	|  	| components for Getting Started / Landing page 	|
|  	| /model 	| model Class for Content on Landing page 	|
|  	| /widgets 	| dots and Carousel Element definition 	|
|  	| landing.dart 	| pageView implementation for Landing page 	|
| /SecureLogin 	|  	| Biometric Authentication implementation using local_auth 	|
|  	| /models 	| localAuth services class 	|
|  	| /widget 	| screens to ask for permission to set up secure login 	|
|  	| local_auth_service.dart 	| to check if the secure login has been setup 	|
|  	| secure_login_manager.dart 	| to implement the secure login 	|
| /services 	|  	|  	|
|  	| /storageHandlers 	| secure storage and shared preferences manager 	|
|  	| connectivity_service.dart 	| class for internet connectivity 	|
|  	| locale_provider.dart 	| class to implement locale/internationlization 	|
|  	| theme_provider.dart 	| class to implement themeing 	|
| /Tabscreens 	|  	|  	|
|  	| /tabscreens 	| 5 tab screen views 	|
|  	| secure_tab_manager.dart 	| class to handle the bottom navigation bar and securing app after app switch 	|
| /utils 	|  	| constant widgets data 	|
|  	| logger.dart 	| Log Service to manage all Loggin and listen to logs. 	|
|  	| notifications.dart 	| Notification Service to handle Local :instant,and scheduled notifications. 	|
|  	| constant_widgets.dart 	| splash screens , snackbars 	|
| /Widgets/HelpCenter 	|  	| Contains Help , support ,report a bug ,send feedback and privacy widgets 	|
|  	| bottom_sheet_widget.dart 	| Widget to send feedback, report a bug 	|
|  	| help_widget.dart 	| Contains the elements of the Help Center 	|
|  	| privacy_terms.dart 	| Implements a web view for displaying privacy terms 	|
| main.dart 	|  	| includes multi providers , locale and theme allocation 	|
| theme.dart 	|  	| Custom global Theme data 	|



## Features 
This Stater Application includes : 


### Splashscreen 
##### Packages :
[flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

Using the package for creating the native Splashscreen files pre-build, we add the required assets and the package before build a following which runs the command :
 >flutter clean && flutter pub get && flutter pub run flutter_native_splash:create

For creating the splash screens for iOs, web, and Android, the configuration files are present in the `pubspec.yaml` file.

**Note** : This is only required once, and the package can be removed after the required files are generated 

_After this, comment/remove the package out, clean build, and run pub get again to remove the package from the build. Launch the app to view the new splash screen [Note: Use `PNG` images as splash screen icons]_

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/01-Splash.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/GettingStarted.md#splashscreens) for more details.


### Landing Page 

Implementation of a Landing/Getting started widget that redirects to authentication for gaining access to the app. It has been implemented using a scrollable page view builder to give it a scrollable carousel feature. 


![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/03-Get%20Started-3.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/Landing-GettingStartedModule.md) for more details.


### Authentication Using Auth0
##### Packages :
[Flutter AppAuth](https://pub.dev/packages/flutter_appauth)

We have Implemented `Flutter AppAuth` with `Auth0` for authentication.
Using the Universal login provided by `Auth0`, we use predefined callbacks for
the authorization of users. The Login callback navigates the User to an InApp web view
that takes care of all authentication via a centralized login/signup page configured via the `Auth0` Dashboard.

##### Setup and Docs :
1. [Auth0 official Docs](https://auth0.com/docs/get-started)  
2. [Auth0 Apis](https://auth0.com/docs/api/authentication?http#logout)

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/old-Designs/Auth0.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/Authentication.md) for more details.




### State management 
##### Packages :
[Provider](https://pub.dev/packages/provider)
[Shared Preference](https://pub.dev/packages/shared_preferences)
[Secure Storage](https://pub.dev/packages/flutter_secure_storage)

A `refresh Token` is generated and stored in Secure Storage
Each time the app is opened, the `refresh Token` is used to initialize Auth0 and get access tokens for the session.
This Token is used to save state, i.e. logged in or not; similarly, the Token to enable/disable Secure Login is stored in the Shared Preferences.

##### Docs :
1. [Gettin Started with Auth0 authentication in Flutter](https://auth0.com/blog/get-started-with-flutter-authentication/#Scaffold-a-Flutter-project)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/StateManagement%20and%20Navigaition.md#state-management)
and [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/StorageHandlers.md) for more details.




### Secure Login with Biometrics 
##### Packages :
[Local_Auth](https://pub.dev/packages/local_auth)
[Foreground/Background Package](https://pub.dev/packages/flutter_fgbg)

`Local Auth` provides us means to use biometric authentication when the User Enters the app. The User can start secure login when they log in/signup.
The `Foreground/Background` Package is used for detecting if the app's context is switched. Suppose the User has opted for secure login. In that case, they are prompted with an authentication dialogue, which proceeds to the home page only if approved.

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/06-LocalAuth.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/SecureLogin.md) for more details.

### Bottom Navigation Bar

It Encapsulates the Home page of the app-shell where five different tabs/screens/pages can be implemented.
- One of the screens that  `tab5` includes the settings page.

It follows the material UI and allows users to navigate within the bottom navigation bar using the Navigator.

##### References :
* [Matrial Design](https://material.io/components/bottom-navigation#usage)

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/08-home.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/StateManagement%20and%20Navigaition.md#navigation-flow) for more details.

### Connectivity
##### Packages :
[Connectivity Plus](https://pub.dev/packages/connectivity_plus)
[Data connection Checker](https://pub.dev/packages/data_connection_checker)

The `Connectivity Plus` package and `Data connection Checker` are used to check if the phone is connected to the internet and renew the app refresh tokens. The `connectivity_plus` package by itself provides us info about whether the User is connected to a wifi network or mobile data. However, it does not tell us if the network/ mobile has internet connectivity [on Android]; this is where `data_connection_checker` solves our problem. On iOs, Connectivity Plus handles internet connectivity as well.

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/13-Connectivity.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/Connectivity.md) for more details.


### Internationalization and Localization
##### Packages :
[Intl](https://pub.dev/packages?q=intl)
We used the flutter intl package for adding internationalization to the app. The lib/l10n folder files must be maintained and updated when some new languages or phrases are added. Dart auto-generates the app_localization files in the .dart_tools folder, which are essential for building the app.
If the files are not autogenerated or updated, please run 
> flutter gen-l10n


![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/14-Intl.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/Internationalization.md) for more details.

### Themeing 
Global Custom Light and Dark themes are implemented using Material Widgets in the app.

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/09-Settings.png?raw=true)
![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/09.1-settings-dark.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/Themeing.md) for more details.

### Snackbars
Authorization errors and state error management is displayed to the User using snack bars. These can be modified for different use-cases.

- Global implementation of the same can be found in `/widgets/constant_widgets.dart` .

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/12-snackbar%20template.png?raw=true)

Please refer to this detailed documentation [here]() for more details.


### Logging
##### Packages :
[Logger](https://pub.dev/packages/logging)

Multi-level Application Logs are displayed by Logger functionality.
- `lib/utils/logger.dart` Initializes the logger and a listener to all the events.
- Any Component that needs to implement logging required a definition of the component name in the widget or dart file with:
```dart
final log = Logger('Class' or 'Component' or 'WidgetName');
```
- When adding a message to the log, one can define the level and then call ```log.'levelName'('message')``` to add the message to the listeners.

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/logging.md) for more details.

### Notifications
##### Packages :
[flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)

Implementation of Local Notifications included but is not limited to instant notifications, scheduled notifications. 

- This feature is implemented in the `NotficationService` class in the `/utils` folder and initialized when the User grants permission to send notifications.

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/08-Enable%20Notifications.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/notifications.md) for more details.

### Permissions
##### Packages :
[permission_handler](https://pub.dev/packages/permission_handler)

To handle and manage App permissions, we use the permission handler plugin. 
- Currently, it is configured to app settings to view the granted permissions from the settings tab, i.e. `tab5` . 


Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/permission.md) for more details.

### Help Center
##### Packages :
[webview_flutter](https://pub.dev/packages/webview_flutter)


Help Center includes support, contact us, Report a bug, Send Feedback, and Privacy policy.

- Report a Bug and Send Feedback features implement a bottom sheet used to accept description and information from the User.

- Privacy Policy Implements a webView of the Privacy terms page.

![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/10-Help%20center.png?raw=true)
![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/12-sendfeedback.png?raw=true)
![alt text](https://github.com/hlth-dev/app-shell/blob/main/Docs/assets/new-designs/11-reportbug.png?raw=true)

Please refer to this detailed documentation [here](https://github.com/hlth-dev/app-shell/blob/main/Docs/HelpCenter.md) for more details.



## Setting up a Different Authentication service
- To set up a different authentication service apart from auth0, the authentication class in `Authentication/models` needs to be modified.
- The Abstract class within `auth_service` and the User class must be modified to reflect the new authentication model.





To know more about adopting the template, please refer to the **[Docs](https://github.com/hlth-dev/app-shell/tree/main/Docs)**

