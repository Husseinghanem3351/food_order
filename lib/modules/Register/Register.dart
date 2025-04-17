import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/layout/home_layout.dart';
import 'package:food_order2/modules/Register/cubit/states.dart';

import '../../shared/components/defaultTextBox.dart';
import '../../shared/constants/constants.dart';
import 'cubit/cubit.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusEmail=FocusNode();
    final focusPassword=FocusNode();
    final focusPhone=FocusNode();
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var phoneController=TextEditingController();
    GlobalKey<FormState> formKey=GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLayout(),
              ),
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Register',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: defaultColor(context)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        DefaultTextbox(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'name must be not empty';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.person),
                          textInputType: TextInputType.name,
                          hintText: 'name',
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_){FocusScope.of(context).requestFocus(focusEmail);},
                        ),
                        const SizedBox(height: 10,),
                        DefaultTextbox(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'email must be not empty';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.email),
                          textInputType: TextInputType.emailAddress,
                          hintText: 'email address',
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_){FocusScope.of(context).requestFocus(focusPassword);},
                          focusNode: focusEmail,
                        ),
                        const SizedBox(height: 10,),
                        DefaultTextbox(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'password must be not empty';
                              }
                              return null;
                            },
                            focusNode: focusPassword,
                            controller: passwordController,
                            prefixIcon:const Icon( Icons.lock),
                            hintText: 'password',
                            textInputType: TextInputType.visiblePassword,
                            obscureText: !RegisterCubit.get(context).isPass,
                            suffixIcon: IconButton(
                              icon:Icon( RegisterCubit.get(context).passIcon),
                              onPressed: () {
                                RegisterCubit.get(context).changePassIcon();
                              },),
                            onFieldSubmitted: (_){FocusScope.of(context).requestFocus(focusPhone);},
                            textInputAction: TextInputAction.next
                        ),
                        const SizedBox(height: 10,),
                        DefaultTextbox(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'phone must be not empty';
                            }
                            return null;
                          },
                          focusNode: focusPhone,
                          controller: phoneController,
                          prefixIcon:const Icon( Icons.phone),
                          hintText: 'phone',
                          textInputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20,),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: defaultColor(context),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                   if(formKey.currentState!.validate()){
                                     RegisterCubit.get(context).userRegister(
                                         context,
                                         name: nameController.text,
                                         phone: phoneController.text,
                                         password: passwordController.text,
                                         email: emailController.text);
                                   }
                                  },
                                  child:  Text(
                                    'Register',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              );
                            },
                            fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator()),
                          ),
                        )
                      ],
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
