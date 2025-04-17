import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/modules/Register/Register.dart';
import 'package:food_order2/shared/components/defaultTextBox.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    final focusNode=FocusNode();
    var formKey=GlobalKey<FormState>();





    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: defaultColor(context)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'Login now to browse our hot offers',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          DefaultTextbox(
                            controller: emailController,
                            textInputAction:TextInputAction.next,
                            onFieldSubmitted: (_){FocusScope.of(context).requestFocus(focusNode);} ,
                            prefixIcon:const Icon(
                              Icons.email,
                            ),
                            hintText: 'email',
                            textInputType: TextInputType.emailAddress,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'email must be not empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          DefaultTextbox(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'password must be not empty';
                              }
                              return null;
                            },
                            obscureText: !LoginCubit.get(context).isPass,
                            focusNode: focusNode,
                            controller: passwordController,
                            prefixIcon:const Icon(
                              Icons.lock,

                            ),
                            hintText: 'password',
                            textInputType: TextInputType.visiblePassword,
                            suffixIcon: IconButton(
                              icon: Icon(LoginCubit.get(context).passIcon),
                              onPressed: () {
                                LoginCubit.get(context).changePassIcon();
                              },),
                          ),

                          const SizedBox(height: 20,),
                          Center(
                            child: ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: defaultColor(context),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate()){
                                        LoginCubit.get(context).userLogin(
                                          context,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    child:  Text(
                                      'Login',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                );
                              },
                              fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          Row(children:  [
                             Text(
                              'you haven\'t an account ',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            TextButton(
                                onPressed: (){
                                  navigateTo(context: context, screen: const Register());
                                },
                                child:  Text(
                                  'RegisterNow',
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: defaultColor(context),
                                  )
                                ),
                            )
                          ],),
                        ],
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
}
