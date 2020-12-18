import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:UniqueBBSFlutter/widget/common/NetworkErrorBottomSheet.dart';
import 'package:UniqueBBSFlutter/widget/common/NormalBottomSheetContainer.dart';
import 'package:UniqueBBSFlutter/widget/home_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:UniqueBBSFlutter/widget/common/FilledTextField.dart';

class LoginWidget extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:EdgeInsets.only(
            left: 20,
            right: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              SvgIcon.logo
            ),
            _buildLogoText(StringConstant.logo2Line),
            Container(height: 67,),
            _buildLoginTextField(StringConstant.phoneNumber),
            Container(height: 20,),
            _buildLoginTextField(StringConstant.password),
            Container(height: 63,),
            _buildLoginButton(context),
            Container(height: 15,),
            _buildWeComLoginButton(context),
          ],
        ),
      ),
    );
  }
}

_buildNoNumberBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return NormalBottomSheetContainer(
            bottomCardRadius: 30,
            totalHeight: 436,
            pictureSrc: SvgIcon.error,
            bottomSheetHeight: 294,
            bottomSheetTopPadding: 55,
            childInternal: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(StringConstant.noPhoneNumber),
                  Container(height: 30,),
                  buildIKnowButton(context),
                  Container(height: 16,),
                  _buildWeComLoginButton(context),
                ],
              ),
            )
        );
      }
  );
}

_buildLoginButton(BuildContext context) =>
    SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
        color: ColorConstant.primaryColor,
        child: Text(
          StringConstant.login,
          style: TextStyle(color: Colors.white, letterSpacing: 22),
        ),
        onPressed: () {
          buildNetworkErrorBottomSheet(context);
          // todo: login internal
        },
      ),
    );

_buildWeComLoginButton(BuildContext context) =>
    SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.skyButtonGray),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text(StringConstant.useWeComLogin),
        onPressed: () {
          // todo: route to WeCom Page
          _buildNoNumberBottomSheet(context);
        },
      ),
    );

_buildLoginTextField(String hint) =>
    buildFilledTextField(
        hint,
        Radius.circular(50),
        ColorConstant.skyInputPurple,
        ColorConstant.skyInputHintPurple
    );

_buildLogoText(String text) =>
    Text(
      text,
      style: TextStyle(
          color: Color(0xff727272),
          fontSize: 18,
          letterSpacing: 4,
      ),
    );
