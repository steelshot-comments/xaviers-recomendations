part of 'auth_screen.dart';

class FirebaseAuthFunctions {
  static signUpUser(
      String email, String password, String fullName, BuildContext ctx) async {
    try {
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(fullName);
      // String? uid = FirebaseAuth.instance.currentUser.uid;
      // CollectionReference users = FirebaseFirestore.instance.collection('users');
      // users.doc().set({});
      // await FirebaseFirestore.instance.collection('users').doc()
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("Weak password"),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("Email already in use"),
        ));
      } else if (e.code == 'invalid-credentials') {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("Invalid credentials"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  static LoginUser(String email, String password, BuildContext ctx) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("No user found with this email"),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("Password did not match"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
