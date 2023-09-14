MyProfile Flutter App
=====================

MyProfile is a Flutter-based mobile application that allows users to create and manage their profiles. This README provides an overview of the project's structure, key functionality, and code organization.

Table of Contents
-----------------

* [Introduction](#introduction)
* [Getting Started](#getting-started)
* [Folder Structure](#folder-structure)
* [Key Features](#key-features)
* [Dependencies](#dependencies)
* [Flutter and Dart Versions](#flutter-and-dart-versions)
* [Contributing](#contributing)
* [License](#license)

Introduction
------------

MyProfile is a mobile app developed using the Flutter framework. It offers users the ability to create and edit their profiles, including personal information, skills, and profile pictures. The app uses various controllers and utilities to handle user interactions and data storage.

Getting Started
---------------

To run the MyProfile app locally, follow these steps:

1. Clone the repository:

   git clone https://github.com/SR-INGENIOUSMINDSLAB/myprofile-flutter.git
2. Navigate to the project directory:

   cd myprofile-flutter
3. Install dependencies:

   flutter pub get
4. Run the app:

   flutter run

The app should now be running on your local device or emulator.

Folder Structure
----------------

The project is organized into the following main directories:

* `lib`: Contains the Dart code for the MyProfile app.
  * `controllers`: Controllers for different screens and functionality.
  * `models`: Data models used throughout the app.
  * `pages`: All screens are located here, including:
    * `auth`: Contains the login functionality.
      * In the `auth` folder, you'll find:
        * `login_binding.dart`
        * `login_controller.dart`
        * `login_view.dart`
    * `edit_profile`: Manages profile editing.
      * Controller: `edit_profile_controller.dart`
      * View: `edit_profile_view.dart`
      * Binding: `edit_profile_binding.dart`
    * `home`: Manages the home screen.
      * Controller: `home_controller.dart`
      * View: `home_view.dart`
      * Binding: `home_binding.dart`
    * `splash`: Handles the splash screen.
      * Controller: `splash_controller.dart`
      * View: `splash_view.dart`
      * Binding: `splash_binding.dart`
  * `routes`: Defines the app's routing and navigation.
  * `services`: Contains `shared_pref.dart` for data storage.
  * `utils`: Utility functions and helper classes, including `methods.dart`, `responsive_utils.dart`, and `widget_helper.dart`.
  * `widgets`: Custom widgets used in the UI, such as `common_image_view`, `custom_toast.dart`, `gradient_button.dart`, and `login_field.dart`.

Key Features
------------

MyProfile offers the following key features:

* User login. (Login with dev@demo.com and password is Developer)
* Profile creation and editing.
* Image cropping and selection from the camera or gallery.
* Data storage using shared preferences.
* Validation of user inputs.

Dependencies
------------

The app relies on several Flutter packages, including:

* `cupertino_icons`
* `extended_image`
* `flutter_screenutil`
* `flutter_svg`
* `get`
* `image_cropper`
* `image_picker`
* `path_provider`
* `shared_preferences`

For more details about dependencies and versions, please check the `pubspec.yaml` file.

Flutter and Dart Versions
-------------------------

* Flutter: 3.10.6
* Dart: 3.0.6
