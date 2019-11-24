import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String verificationId;

signInEmail(email, password) async{
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
}

signInPhone(phone) async{
  final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
    verificationId = verId;
  };

  final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
    verificationId = verId;
  };

  final PhoneVerificationCompleted verFieldSuccess = (user) {
    print('Success');
  };

  final PhoneVerificationFailed verFiledError = (AuthException exception) {
    print('ERROR - ${exception.message}');
  };

  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phone,
    timeout: const Duration(seconds: 5),
    verificationCompleted: verFieldSuccess,
    verificationFailed: verFiledError,
    codeSent: smsCodeSent,
    codeAutoRetrievalTimeout: autoRetrieve,
  );

  //Проверка авторизованного пользователя
  FirebaseAuth.instance.currentUser().then((user){});
}

confirmSmsCode(code) async {
  final AuthCredential credential = PhoneAuthProvider.getCredential(
    verificationId: verificationId,
    smsCode: code,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);
}