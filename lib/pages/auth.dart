import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
    final Map<String, dynamic> _formData = {
        'email': null,
        'password': null,
        'acceptTerms': false,
    };

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                            child: Form(
                                key: _formKey,
                                child: Column(
                                    children: <Widget>[
                                        _buildEmailTextField(),
                                        SizedBox(height: 10),
                                        _buildPasswordTextField(),
                                        SizedBox(height: 10),
                                        _buildAcceptSwitch(),
                                        RaisedButton(
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
            ),
        );
    }

    DecorationImage _buildBackgroundImage() =>
        DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('assets/background.jpg'),
        );

    TextFormField _buildEmailTextField() =>
        TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (String value) => _formData['email'] = value,
            validator: (String value) {
                if (value.isEmpty) return 'E-Mail is required';
                if (RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
                ).hasMatch(value)) return 'Plese enter a valid E-Mail';
            },
            decoration: InputDecoration(
                labelText: 'E-Mail',
                filled: true,
                fillColor: Colors.white,
            ),
        );

    TextFormField _buildPasswordTextField() =>
        TextFormField(
            obscureText: true,
            onSaved: (String value) => _formData['password'] = value,
            validator: (String input) {
                if (input.isEmpty) return 'Password is required';
                if (input.length < 6) return 'Password invalid';
            },
            decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
            ),
        );

    SwitchListTile _buildAcceptSwitch() =>
        SwitchListTile(
            title: Text('Acept Terms'),
            value: _formData['acceptTerms'],
            onChanged: (bool value) => _formData['acceptTerms'] = value,
        );

    void _submitForm() {
//        if (!_formKey.currentState.validate() || !_formData['acceptTerms']) return;

        _formKey.currentState.save();

        print('Form Data: $_formData');
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

