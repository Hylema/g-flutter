import 'package:http/http.dart' as http;
import 'package:flutter_app/constants/toroWebAuthConst.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  final String codeUrl;
  Otp(this.codeUrl);

  @override
  _OtpState createState() => _OtpState(codeUrl);
}
class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  var response;
  final String codeUrl;

  _OtpState(this.codeUrl);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        test(),
        Text('РЕЗУЛЬТАТ'),
        SizedBox(height: 20.0),
        Text(
            codeUrl == null ? 'Не удалось получить код авторизации' : 'Код авторизации успешно получен === CODE=$codeUrl',
          style: codeUrl == null ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green),
        ),
        SizedBox(height: 20.0),
        Text(
          'Ответ запроса на получение токена === RESPONSE=$response'
        ),
      ],
    );
  }

  test(){
    http.post('https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/token', body: {
      ...constants,
      'code': codeUrl
    }).then((result) {
      setState(() {
        response = result.body;
      });
    });
  }
}