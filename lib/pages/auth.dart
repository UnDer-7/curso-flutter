import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
    String _emailValue;
    String _passwordValue;
    bool _acceptTerms = false;

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('LOGIN'),
        ),
        body: Container(
            margin: EdgeInsets.all(10),
            child: ListView(
                children: <Widget>[
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String value) => setState(() => _emailValue = value),
                        decoration: InputDecoration(
                            labelText: 'E-Mail',
                        ),
                    ),
                    TextField(
                        obscureText: true,
                        onChanged: (String value) => setState(() => _passwordValue = value),
                        decoration: InputDecoration(
                            labelText: 'Password',
                        ),
                    ),
                    SizedBox(height: 10),
                    SwitchListTile(
                        title: Text('Acept Terms'),
                        value: _acceptTerms,
                        onChanged: (bool value) => setState(() => _acceptTerms = value),
                    ),
                    RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text('LOGIN'),
                        onPressed: () {
                            print('E-Mail: $_emailValue');
                            print('Password: $_passwordValue');
                            Navigator.pushReplacementNamed(context, '/');
                        },
                    ),
                ],
            ),
        ),
    );
}
