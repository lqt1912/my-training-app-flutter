// ignore_for_file: deprecated_member_use, unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Đăng ký bằng email và mật khẩu
Future<void> signUpWithEmailAndPassword(String displayName, String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // User? user = userCredential.user;
    User? user = _auth.currentUser;
    await user!.updateProfile(displayName: displayName);
    print("=======${user.toString()}");
  } catch (e) {
    print("Loi: $e");
  }
}

// Đăng nhập bằng email và mật khẩu
Future<void> signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    print(user?.photoURL.toString());
    // Xử lý sau khi đăng nhập thành công
  } catch (e) {
    // Xử lý lỗi đăng nhập
  }
}

// Đăng xuất
Future<void> signOut() async {
  try {
    await _auth.signOut();
    // Xử lý sau khi đăng xuất thành công
  } catch (e) {
    // Xử lý lỗi đăng xuất
  }
}
