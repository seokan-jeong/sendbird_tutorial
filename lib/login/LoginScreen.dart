import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_tutorial/chat/channel_screen.dart';
import 'package:sendbird_tutorial/login/LoginViewModel.dart';
import 'package:sendbird_tutorial/sendbird.dart';
import 'package:sendbird_tutorial/styles/color.dart';
import 'package:sendbird_tutorial/styles/text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userIdController = TextEditingController();

  bool isLoading = false;
  bool enableSignInButton = false;

  bool _shouldEnableSignInButton() {
    if (userIdController.text == "") {
      return false;
    }
    return true;
  }

  final model = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 24, right: 24, top: 56),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  child: Image(
                    image: AssetImage('assets/logoSendbird@3x.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(height: 20),
                Text('Sendbird Sample', style: TextStyles.sendbirdLogo),
                SizedBox(height: 40),
                _buildInputField(userIdController, 'User ID'),
                SizedBox(height: 32),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: _signInButton(context, enableSignInButton),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildInputField(
      TextEditingController controller, String placeholder) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {
          enableSignInButton = _shouldEnableSignInButton();
        });
      },
      style: TextStyles.sendbirdSubtitle1OnLight1,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SBColors.primary_300, width: 2),
        ),
        border: InputBorder.none,
        labelText: placeholder,
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _signInButton(BuildContext context, bool enabled) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => model,
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) {
          return FlatButton(
            height: 48,
            color: enabled ? Theme.of(context).buttonColor : Colors.grey,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            onPressed: !enabled && model.isLoading
                ? null
                : () async {
              try {
                await model.login();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChannelScreen(channelUrl: channelUrl,)),
                );
              } catch (e) {
                print('login_view.dart: _signInButton: ERROR: $e');
              }
            },
            child: !model.isLoading
                ? Text(
              "Sign In",
              style: TextStyles.sendbirdButtonOnDark1,
            )
                : CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        },
      ),
    );
  }
}
