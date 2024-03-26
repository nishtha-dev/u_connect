

# You Connect



## OVERVIEW👩‍💻

This project displays  a social media platform build using flutter with a login/sign-up module & a profile section with edit profile option.

## Features Implemented
 - User Authentication:-
  Implement Firebase Authentication to allow users to register and login using email/password or social media accounts.
  Ensure proper error handling for authentication processes..
   
 - Display a list or a summary of recent contributions towards the goal, including dates and amounts.

 - User Profile:-
  Users should be able to create and edit their profiles.
Profile information should include at least a username, bio, and profile picture.
  Display user profiles with relevant information..


##### Duration : 2024.03.22 ~ 2024.03.26

<img width="200" height="400" align='left' src="https://res.cloudinary.com/dvnfhm7q4/image/upload/v1711403319/landing_page_ewsbfn.png">

<img width="200" height="400" align='left' src="https://res.cloudinary.com/dvnfhm7q4/image/upload/v1711403319/login_page_qxfgy4.png">

<img width="200" height="400" align='left' src="https://res.cloudinary.com/dvnfhm7q4/image/upload/v1711403359/sign_up_page_vedc0c.png">

<img width="200" height="400" align='left' src="https://res.cloudinary.com/dvnfhm7q4/image/upload/v1711403407/forgot_password_bv9ys6.png">

<img width="200" height="400" align='left' src="https://res.cloudinary.com/dvnfhm7q4/image/upload/v1711401963/Simulator_Screen_Shot_-_iPhone_14_Pro_Max_-_2024-03-26_at_02.49.38_gvnlbt.png">

#####

## Prerequisites
Before following the steps to build and run this quickstart you will need:
 1. [Node.Js](https://nodejs.org/en/download) Version 16.0 or higher
 2. [Java](https://jdk.java.net/) JDK version 11 or higher.

### Steps To Use Run This Project:
##### 1) Install Flutter.
##### 2) Install Dart.
##### 3) Clone this repo to desired location.
##### 4) Run Pub Get and Pub Upgrade.
##### 5) Run this Project on your iOS emulator.
##### 6) Install Firebase

### Technology of Use 💻
####  Tools:-
1) Flutter

#### Google Technologies:-
1) Firebase
2) Cloud Firestore
3) Cloud Storage
4) Firebase Authentication


#### Languages:-
1) Dart

## Running the project with Firebase

To use this project with Firebase, follow these steps:

- Create a new project with the Firebase console
- Enable Firebase Authentication, along with the Email/Password Authentication Sign-in provider in the Firebase Console (Authentication > Sign-in method > Email/Password > Edit > Enable > Save)
- Enable Cloud Firestore

Then, follow one of the two approaches below. 👇

### 1. Using the CLI

Make sure you have the Firebase CLI and [FlutterFire CLI](https://pub.dev/packages/flutterfire_cli) installed.

Then run this on the terminal from the root of this project:

- Run `firebase login` so you have access to the Firebase project you have created
- Run `flutterfire configure` and follow all the steps

For more info, follow this guide:

- [How to add Firebase to a Flutter app with FlutterFire CLI](https://codewithandrea.com/articles/flutter-firebase-flutterfire-cli/)

### 2. Manual way (not recommended)

If you don't want to use FlutterFire CLI, follow these steps instead:

- Register separate iOS, Android, and web apps in the Firebase project settings.
- On Android, use `com.example.starter_architecture_flutter_firebase` as the package name.
- then, [download and copy](https://firebase.google.com/docs/flutter/setup#configure_an_android_app) `google-services.json` into `android/app`.
- On iOS, use `com.example.starterArchitectureFlutterFirebase` as the bundle ID.
- then, [download and copy](https://firebase.google.com/docs/flutter/setup#configure_an_ios_app) `GoogleService-Info.plist` into `iOS/Runner`, and add it to the Runner target in Xcode.

For more information about Firestore visit the [Firestore docs][firestore-docs].

For more information about the Firebase Emulator Suite visit the [Emulator Suite docs][emulator-docs]

[firestore-docs]: https://firebase.google.com/docs/firestore/
[emulator-docs]: https://firebase.google.com/docs/emulator-suite
