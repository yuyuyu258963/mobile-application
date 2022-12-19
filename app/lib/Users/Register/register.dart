import 'package:flutter/material.dart';

import '../../Common/MyNotification/index.dart';
import '../../DataBase/Tables/userData.dart';
import '../../Routes/RouteController.dart';
import '../Utils/FuncTools/index.dart';
import '../../interface/userInfo.dart';
import '../Common/Header.dart';
import '../Common/Input/EmailInput.dart';
import '../Common/Input/Withoutvalidator.dart';
import '../Common/Input/pwdInputDecoration.dart';
import '../Common/MyactionButton.dart';

/**
 * 用户注册的部分界面
 */
class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  late final GlobalKey _formKey = GlobalKey<FormState>();
  late String _phoneNumber, _email, _userName, _captcha, _password, trueCaptcha;

  pwdInputState input1State = pwdInputState(true, Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          ...headTitle("注册", 75.0),
          const SizedBox(height: 20),
          MyEmailInputField(
            changeEmail: setEmail,
          ),
          const SizedBox(height: 10),
          WithoutValidatorInput(
            setInputContent: setPhoneNumber,
            inputDecorationPrefix: '电话号码',
          ),
          const SizedBox(height: 10),
          WithoutValidatorInput(
            setInputContent: setUserName,
            inputDecorationPrefix: '用户名',
          ),
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
          capChaLineBuilder(),
          const SizedBox(height: 40),
          buildBtnRegister(Colors.deepPurpleAccent),
        ],
      ),
    );
  }

  setPassword(String? value) {
    _password = value!;
  }

  setPhoneNumber(String? value) {
    _phoneNumber = value!;
  }

  setEmail(String? value) {
    _email = value!;
  }

  setUserName(String? value) {
    _userName = value!;
  }

  setCaptcha(String? value) {
    _captcha = value!;
  }

  // 注册行
  Widget capChaLineBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 80.0,
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
            validator: (v) {
              if (v!.isEmpty) {
                return "请输入验证码";
              }
              return null;
            },
            onSaved: setCaptcha,
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

  String viewString() {
    return '_UserRegisterState{_phoneNumber: $_phoneNumber, _email: $_email, _userName: $_userName, _captcha: $_captcha, _password: $_password, input1State: $input1State}';
  }

  /// 校验信息
  void verifyRegisterInformation() async {
    if ((_formKey.currentState as FormState).validate()) {
      (_formKey.currentState as FormState).save();
      debugPrint(viewString());

      /// 用户输入的验证码不正确
      if (_captcha.toLowerCase() != trueCaptcha.toLowerCase()) {
        MyInfoDialog.showToast("验证码不正确");
        return;
      } else {
        bool? userState = await UserData().insertUsr(MyUserInfo(
            email: _email,
            password: _password,
            phoneNumber: int.parse(_phoneNumber),
            userName: _userName));
        if (userState == null || userState == false) {
          MyInfoDialog.showToast("用户已经注册");
        } else if(userState){
          MyInfoDialog.showToast("用户注册成功, 自动跳转登录界面中");
          timeOut((){
            RouteController.gotoAimPage(context, "login");
          });
        } else {
          MyInfoDialog.showToast("注册失败");
        }
      }
    }
  }

  //  创建注册按钮
  Widget buildBtnRegister(Color? btnColor) {
    return MyActionButton(
      btnColor: btnColor!,
      btnText: "注册",
      verify: verifyRegisterInformation,
    );
  }
}
