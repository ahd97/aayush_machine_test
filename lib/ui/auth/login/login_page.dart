import 'package:aayush_machine_test/core/navigation/routes.dart';
import 'package:aayush_machine_test/ui/auth/login/login_bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:aayush_machine_test/res.dart';
import 'package:aayush_machine_test/values/export.dart';
import 'package:aayush_machine_test/values/string_constants.dart';
import 'package:aayush_machine_test/widget/button_widget_inverse.dart';
import 'package:aayush_machine_test/widget/loading.dart';
import 'package:aayush_machine_test/widget/text_form_filed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  late GlobalKey<FormState> _formKey;
  late TextEditingController emailController, passwordController;
  late FocusNode emailNode, passwordNode;

  ValueNotifier<bool> showLoading = ValueNotifier<bool>(false);
  var socialId, type = "S";

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginSuccess){
            Navigator.pushReplacementNamed(context, RouteName.homePage);
          }
          if(state is LoginFailure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        listenWhen: (previous, current) {
          return current is LoginSuccess || current is LoginFailure || current is LoginLoading;
        },
        builder: (context, state) {
          return Loading(
            status: state is LoginLoading,
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  width: 1.sw,
                  height: 1.sh,
                  child: SingleChildScrollView(
                    child: ValueListenableBuilder(
                      valueListenable: showLoading,
                      builder: (context, bool value, child) => Loading(
                        status: value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            30.0.VBox,
                            getHeaderContent(),
                            getSignInForm(context),
                            70.0.VBox,
                          ],
                        ).wrapPadding(
                          padding:
                              EdgeInsets.only(top: 0.h, left: 30.w, right: 30.w),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getHeaderContent() {
    return Column(
      children: [
        FlutterLogo(
          size: 0.15.sh,
        ),
        10.0.VBox,
        Text(
          StringConstant.welcomeBack.toUpperCase(),
          style: textBold.copyWith(
            color: AppColor.primaryColor,
            fontSize: 28.sp,
          ),
        ),
      ],
    );
  }

  Widget getSignInForm(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            25.0.VBox,
            AppTextField(
              controller: emailController,
              label: StringConstant.email,
              hint: StringConstant.email,
              keyboardType: TextInputType.emailAddress,
              validators: emailValidator,
              focusNode: emailNode,
              prefixIcon: IconButton(
                onPressed: null,
                icon: Image.asset(
                  Res.email,
                  color: AppColor.primaryColor,
                  height: 26.0,
                  width: 26.0,
                ),
              ),
            ).wrapPaddingHorizontal(20),
            10.0.VBox,
            AppTextField(
              label: StringConstant.password,
              hint: StringConstant.password,
              obscureText: _isHidden,
              validators: passwordValidator,
              controller: passwordController,
              focusNode: passwordNode,
              keyboardType: TextInputType.visiblePassword,
              keyboardAction: TextInputAction.done,
              maxLines: 1,
              maxLength: 15,
              suffixIcon: Align(
                alignment: Alignment.centerRight,
                heightFactor: 1.0,
                widthFactor: 1.0,
                child: Text(
                  StringConstant.forgot,
                  style: textMedium.copyWith(
                    color: AppColor.brownColor,
                    fontSize: 14.0.sp,
                  ),
                ).wrapPaddingAll(12.0).addGestureTap(() => {
                      Future.delayed(Duration.zero, () {
                        passwordNode.unfocus();
                      }),
                    }),
              ),
              prefixIcon: IconButton(
                onPressed: null,
                icon: Image.asset(
                  Res.password,
                  color: AppColor.primaryColor,
                  height: 26.0,
                  width: 26.0,
                ),
              ),
            ).wrapPaddingHorizontal(20),
            16.0.VBox,
            AppButtonInverse(
              StringConstant.logIn.toUpperCase(),
              () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<LoginCubit>(context).login(emailController.text.trim(), passwordController.text.trim());
                }
              },
              elevation: 0.0,
            ).wrapPaddingHorizontal(20),
          ],
        ),
      ),
    );
  }
}
