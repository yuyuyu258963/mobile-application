import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../Common/MyNotification/index.dart';
import '../../DataBase/Tables/userData.dart';
import '../Utils/FuncTools/index.dart';
import '../Common/Input/EmailInput.dart';
import '../Common/Header.dart';

import '../Common/Input/Withoutvalidator.dart';
import '../Common/Input/pwdInputDecoration.dart';
import '../Common/MyactionButton.dart';

/**
 * 重新注册
 */
class ResetUserPassword extends StatefulWidget {
  const ResetUserPassword({Key? key}) : super(key: key);

  @override
  State<ResetUserPassword> createState() => _ResetUserPasswordState();
}

class _ResetUserPasswordState extends State<ResetUserPassword> {
  final GlobalKey _resetPasswordformKey = GlobalKey<FormState>();
  late String _email, _password, _rep, _captcha, trueCaptcha;

  pwdInputState input1State = pwdInputState(true, Colors.grey);

  pwdInputState input2State = pwdInputState(true, Colors.grey);

  // 设定修改
  void setEmail(String? email) {
    _email = email!;
  }

  void setPassword(String? pwd) {
    _password = pwd!;
  }

  void setRePassword(String? pwd) {
    _rep = pwd!;
  }

  void setCapCha(String? capCha) {
    _captcha = capCha!;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _resetPasswordformKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          ...headTitle("重置密码", 75.0),
          const SizedBox(height: 20),
          MyEmailInputField(
            changeEmail: setEmail,
          ),
          // 用户名输入框
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          PwdInputDecoration(
            inputTitle: '密码',
            showState: input1State,
            setPwdInputContent: setPassword,
            iconPressed: () {
              setState(() {
                input1State.handelClickInputIcon(context);
              });
            },
          ),
          const SizedBox(height: 10),
          PwdInputDecoration(
            inputTitle: '再次输入密码',
            showState: input2State,
            setPwdInputContent: setRePassword,
            iconPressed: () {
              setState(() {
                input2State.handelClickInputIcon(context);
              });
            },
            emptyTip: "请再次输入密码",
          ),
          const SizedBox(height: 10),
          capChaLineBuilder(),
          const SizedBox(height: 40),
          buildBtnReSetPwd(Colors.green),
        ],
      ),
    );
  }

  /// 验证码
  Widget capChaLineBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 60.0,
          width: 200,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: "验证码",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            trueCaptcha = generateRandomString(4);
            MyInfoDialog.showCaptcha(context, "验证码为: $trueCaptcha ");
          },
          child: const Text("获取验证码"),
        ),
      ],
    );
  }

  /// 校验重置密码信息
  void verifyReSetPwdInformation() async {
    if ((_resetPasswordformKey.currentState as FormState).validate()) {
      (_resetPasswordformKey.currentState as FormState).save();
      if ((_password != null && _rep != null) && _password != _rep) {
        MyInfoDialog.errorToast("您两次输入的密码不一致！");
      } else {
        UserData().update(_email, "email", {"password": _password}).then((bool value) {
          debugPrint(value.toString());
          if(value){
            MyInfoDialog.errorToast("修改密码成功");
          } else {
            MyInfoDialog.errorToast("修改密码失败");
          }
        });
      }
    }
    debugPrint("$_email, $_password, $_rep");
  }

  //  重置密码按钮
  Widget buildBtnReSetPwd(Color? btnColor) {
    return MyActionButton(
      btnColor: btnColor!,
      btnText: "重置密码",
      verify: verifyReSetPwdInformation,
    );
  }
}
