import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:groceryapptesting/views/login.dart';
import 'package:groceryapptesting/views/Home.dart';

class AuthService {

  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {

          if (snapshot.hasData ) {
            if (snapshot.data.email == "admin@gmail.com") {
              print("In admin");
              return MyHomePage(isAdminLogin: true,);
            }

            print("Not in Admin");
            return MyHomePage();
          } else
            return LoginPage();
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign In
  signIn(String email, String password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((val) {
      print('signed in');
    }).catchError((e) {
      print(e);

    });
  }

  //fb signin

  fbSignIn() async {
    final fb = FacebookLogin();

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
      // Logged in

      // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        final AuthCredential authCredential =
        FacebookAuthProvider.credential(accessToken.token);
        final result =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');

        FirebaseAuth.instance.currentUser.updateEmail(email);




        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  //Signup a new user
  signUp(String email, String password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  //Reset Password
  resetPasswordLink(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
