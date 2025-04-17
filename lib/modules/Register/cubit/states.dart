
class RegisterState{}

class RegisterInitialState extends RegisterState{}

class RegisterSuccessState extends RegisterState{}

class RegisterErrorState extends RegisterState{}

class RegisterLoadingState extends RegisterState{}

class CreateUserErrorState extends RegisterState{
  String? error;
  CreateUserErrorState(this.error){
    print(error);
  }
}

class CreateUserSuccessState extends RegisterState{}

class ChangeVisibilityState extends RegisterState{}

