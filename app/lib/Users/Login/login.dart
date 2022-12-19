import 'package:app/Users/Utils/FuncTools/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Common/MyNotification/index.dart';
import '../../DataBase/Tables/userData.dart';
import '../../Provider/Stores/userState.dart';
import '../../Routes/RouteController.dart';
import '../../interface/userInfo.dart';
import '../Common/Header.dart';
import '../Common/Input/EmailInput.dart';
import '../Common/Input/pwdInputDecoration.dart';
import '../Common/MyactionButton.dart';
import 'Common/OtherLoginMethod.dart';
import 'Common/forgetFormat.dart';
import 'Common/register_text.dart';
import 'Common/welcome_title.dart';
import 'Common/joint_us_title.dart';

/// 用户登陆页面
class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";
  pwdInputState input1State = pwdInputState(true, Colors.grey);

  void setEmail(String? e) {
    _email = e!;
  }

  void setPwd(String? pwd) {
    _password = pwd!;
  }

  @override
  Widget build(BuildContext context) {
    MyUserInfo? historyUsr = context.read<UserStateStore>().user;
    if (historyUsr != null) {
      setPwd(historyUsr.password);
      setEmail(historyUsr.email);
      debugPrint(historyUsr.toString());
    }

    return Form(
      key: _formKey, // 设置全局global，用于后面获取FormState
      // 为这个 form 设定一个 field 限制 form 中的参数不能是空的
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          headTitle("登录", 75.0)[0], // Login下面的下划线
          const SizedBox(height: 30),
          const WelcomeTitle(),
          const SizedBox(height: 5),
          const JointUsTitle(),
          const SizedBox(height: 10),
          headTitle("登录", 85.0)[2], // Login下面的下划线
          const SizedBox(height: 60),
          MyEmailInputField(
              changeEmail: setEmail,
              initialValue: _email ?? ""), // 输入邮箱
          const SizedBox(height: 30),
          buildPasswordTextField(context, initialValue:_password ?? ""), // 输入密码
          const ForgetNameString(), // 忘记密码
          const SizedBox(height: 60),
          buildLoginButton(context), // 登录按钮
          const SizedBox(height: 40),

          buildOtherLoginText(), // 其他账号登录的文字
          const OtherLoginMethod(), // 其他登录方式
          const RegisterText(), // 注册
        ],
      ),
    );
  }

  /// 编写其他账号登录的部分
  Widget buildOtherLoginText() {
    return Center(
      child: Text(
        '其他账号登录',
        style: TextStyle(color: Colors.grey[850], fontSize: 16),
      ),
    );
  }

  /// 登录按钮输入验证
  Future<Null> Function() verifyLogin(BuildContext context) {
    return () async {
      if ((_formKey.currentState as FormState).validate()) {
        (_formKey.currentState as FormState).save();
        //TODO 执行登录方法
        debugPrint('email: $_email, password: $_password');
        UserData().findUser(_email).then((List<Map<String, dynamic>>? value) {
          if (value == null || value.isEmpty) {
            debugPrint("||  ${value.toString()}, $_email,  $_password ||");
            MyInfoDialog.errorToast("用户未注册！");
          } else if (value[0]["password"] != _password) {
            MyInfoDialog.errorToast("密码错误");
          } else {
            timeOut(() {
              MyUserInfo user = MyUserInfo.fromMap(value[0]);
              context.read<UserStateStore>().login(user);
              debugPrint(context.read<UserStateStore>().toString());
              MyInfoDialog.errorToast("登录成功");
              timeOut(() {
                RouteController.loginHomePage(context);
              });
            });
          }
        }).catchError((err) {
          MyInfoDialog.errorToast("登录失败");
        });
        // RouteController.loginHomePage(context);
      }
    };
  }

  /// 用户登录按钮
  Widget buildLoginButton(BuildContext context) {
    return MyActionButton(
      btnText: "登录",
      verify: verifyLogin(context),
    );
  }

  /// 密码输入框
  Widget buildPasswordTextField(BuildContext context, {String initialValue:""}) {
    return PwdInputDecoration(
      inputTitle: '密码',
      showState: input1State,
      setPwdInputContent: setPwd,
      initialValue: initialValue,
      iconPressed: () {
        setState(() {
          input1State.handelClickInputIcon(context);
        });
      },
    );
  }
}
