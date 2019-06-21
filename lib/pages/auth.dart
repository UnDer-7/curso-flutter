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
    Widget build(BuildContext context) {
        final double targetWidth = _setTargetWith(context);

        return Scaffold(
            appBar: AppBar(
                title: Text('LOGIN'),
            ),
            body: Container(
                decoration: BoxDecoration(
                    image: _buildBackgroundImage(),
                ),
                padding: EdgeInsets.all(10),
                child: Center(
                    child: SingleChildScrollView(
                        child: Container(
                            width: targetWidth,
                            child: Column(
                                children: <Widget>[
                                    _buildEmailTextField(),
                                    SizedBox(height: 10),
                                    _buildPasswordTextField(),
                                    SizedBox(height: 10),
                                    _buildAcceptSwitch(),
                                    RaisedButton(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        textColor: Colors.white,
                                        child: Text('LOGIN'),
                                        onPressed: _submitForm,
                                    ),
                                ],
                            ),
                        ),
                    ),
                ),
            ),
        );
    }

    DecorationImage _buildBackgroundImage() =>
        DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('assets/background.jpg'),
        );

    TextField _buildEmailTextField() =>
        TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) => setState(() => _emailValue = value),
            decoration: InputDecoration(
                labelText: 'E-Mail',
                filled: true,
                fillColor: Colors.white,
            ),
        );

    TextField _buildPasswordTextField() =>
        TextField(
            obscureText: true,
            onChanged: (String value) => setState(() => _passwordValue = value),
            decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
            ),
        );

    SwitchListTile _buildAcceptSwitch() =>
        SwitchListTile(
            title: Text('Acept Terms'),
            value: _acceptTerms,
            onChanged: (bool value) => setState(() => _acceptTerms = value),
        );

    void _submitForm() {
        print('E-Mail: $_emailValue');
        print('Password: $_passwordValue');
        Navigator.pushReplacementNamed(context, '/products');
    }

    double _setTargetWith(BuildContext context) {
        final double deviceWidth = MediaQuery.of(context).size.width;

        if (deviceWidth > 768.0) {
            return 500.0;
        } else{
            return deviceWidth * 0.95;
        }
    }
}

