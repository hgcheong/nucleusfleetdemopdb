import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/env.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app/storage.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/feature/auth/providers/login_form_provider.dart';
import 'package:nucleusv2/src/feature/brand/components/brand_logo.dart';
import 'package:nucleusv2/src/feature/theme/app_theme.dart';

class LoginForm extends BaseComponent {
  LoginForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    

      final version = Env.appVersion;
    if(version != "10618"){
      return Scaffold(
        body:  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BrandLogo(
              // maxWidth: 300,
              ),
              sbh20,
         Text("Version 10618 is available. Please Clear Your Browser Cache For Files & Reload Nucleus",),
          const SizedBox(
            height: 80,
          ),
          //   AppButton(
          //   onPressed: () {
          //     web.window.location.reload();
          //   },
          //  processing:false,
          //   label: "Reload Nucleus",
          // ),
      
        ],
      
      )));
    }
    final loginFormProvider = ref.read(loginFormStateNotifierProvider.notifier);
  //  final loginFormModel = ref.watch(loginFormStateNotifierProvider);
    int hours = DateTime.now().hour;
    String filename = "";
      if(hours>7 && hours<12){ 
    filename = 'morningpdb.png'; 
    } else if(hours>=12 && hours<=18){
     filename = 'afternoonpdb.png'; 
     }else{
    filename = 'nightpdb.png';
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        
        Positioned.fill(
          child: Image.asset('assets/images/$filename' ,
                          fit: BoxFit.cover),
        ),
        Positioned(
          top:10,
          left: 30,
          height:50 ,
          width: 131,
          child: Image.asset('assets/images/logologinpdb.png',
                          fit: BoxFit.fill),
        ),
        // const Positioned(
        //   left: 50, top: 50,
        //   height: 50,
        //   width: 35,
        Positioned(
          width: 320,
          height: 320,
          left: 10,
          top: 80,
          child: Center(
            child: Form(
              key: _formKey,
              child: Opacity(
                opacity: 0.7,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Nucleus Portal',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        sbh20,
                        const Icon(Icons.account_circle_rounded),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: SelectableText("User ID or Email"),
                          ),
                          controller: loginFormProvider.emailController,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: SelectableText("Password"),
                          ),
                          controller: loginFormProvider.passwordController,
                          obscureText: true,
                          onFieldSubmitted: (value) {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            loginFormProvider.submit();
                          },
                        ),
               
                        sbh10,
                                   Opacity(
                              opacity: 1,
                              child: AppButton(
                                variant: AppColorVariant.Secondary,
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  singleton<Storage>().setString('login_email',
                                      loginFormProvider.email);
                                  loginFormProvider.submit();
                                },
                                icon: Icons.login,
                                label: "Sign In or Login",
                                // processing:
                                //     loginFormModel.status == LoginFormStatus.Processing,
                              ),
                            ),
                                     sbh20,
                        Wrap(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              AppButton(
                                variant: AppColorVariant.Secondary,
                                  onPressed: loginFormProvider.forgotPassword,
                                  label: "Forgot Password",
                                  type: AppButtonType.Text),
                              AppButton(
                                variant: AppColorVariant.Secondary,
                                  onPressed: loginFormProvider.forgotPassword,
                                  label: "Need Help?",
                                  type: AppButtonType.Text),
                            ]),
                 
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
