
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/layout/cubit/states.dart';
import 'package:food_order2/models/DataModel.dart';
import 'package:food_order2/shared/components/components.dart';
import 'package:food_order2/shared/constants/constants.dart';
import 'package:food_order2/shared/network/local/cache_helper.dart';
import 'package:food_order2/shared/network/remote/dioHelper.dart';
import '../../modules/Login/login.dart';
import '../../modules/cart/cart.dart';
import '../../modules/home/home.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() :super(HomeState());

  static HomeCubit get(context) => BlocProvider.of(context);

  Widget? categories;

  int cartItems = 0;

  int currentIndex = 0;

  Map<int, String> screenIndex = {
    0: 'home',
    1: 'cart',
  };
  String currentScreen = 'home';

  late List<Object?> id;

  Map<String, Widget> homeScreens = {
    'home': const Home(),
    'cart': const Cart(),
  };

  ScrollPhysics scrollPhysics = const BouncingScrollPhysics();

  void changeScreen(int index) {
    currentScreen = screenIndex[index]!;
    emit(ChangeScreenState());
  }

  void changeCategoriesItem(index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  List<ProductModel> cartModel = [];

  getCartData() {
    cartItems = CacheHelper.getData(key: 'cartItems') ?? 0;
    id = CacheHelper.getData(key: 'idCartProduct') ?? [];
    for (var idProduct in id) {
      for (var element in productsModel) {
        if (idProduct.toString() == element.id.toString()) {
          element.quantity = CacheHelper.getData(key: 'quantity${element.id}');
          cartModel.add(element);
        }
      }
    }
  }

  List<String> idCartProduct = [];

  void addToCart(ProductModel product) {
    idCartProduct = [];
    cartModel.add(product);
    for (var element in cartModel) {
      idCartProduct.add(element.id!.toString());
    }
    CacheHelper.putData(key: 'idCartProduct', value: idCartProduct);
  }

  void minusOfCart(ProductModel product) {
    idCartProduct = [];
    cartModel.remove(product);
    for (var element in cartModel) {
      idCartProduct.add(element.id!.toString());
    }
    CacheHelper.putData(key: 'idCartProduct', value: idCartProduct);
  }

  void plusProduct(ProductModel product) {
    product.quantity++;
    CacheHelper.putData(key: 'quantity${product.id}', value: product.quantity);
    if (product.quantity == 1) {
      cartItems++;
      CacheHelper.putData(key: 'cartItems', value: cartItems);
      addToCart(product);
    }
    emit(ChangeQuantityState());
  }

  void minusProduct(ProductModel product) {
    product.quantity--;
    CacheHelper.putData(key: 'quantity${product.id}', value: product.quantity);
    if (product.quantity == 0) {
      cartItems--;
      CacheHelper.putData(key: 'cartItems', value: cartItems);
      minusOfCart(product);
    }
    emit(ChangeQuantityState());
  }

  deleteItemOfCart(ProductModel product) {
    CacheHelper.removeData('quantity${product.id}');
    cartItems--;
    product.quantity=0;
    CacheHelper.putData(key: 'cartItems', value: cartItems);
    minusOfCart(product);
    emit(RemoveDataOfCArt());
  }

  bool isDark = false;

  void changeDarkMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    }
    else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeDarkModeState());
      });
    }
  }

  List<CategoriesModel> categoriesModel = categories_test;

  List<ProductModel> productsModel = products_test;


  void getDataApp(context) {
    for (var element in productsModel) {
      for (var element1 in categoriesModel) {
        if (element.categoryId == element1.id) {
          element1.products.add(element);
        }
      }
    }
      emit(GetDataLoading());
      DioHelper.getData(url: 'categories').
      then((value) {
        categoriesModel.clear();
        productsModel.clear();
        value.data.forEach(
                (element) {
              categoriesModel.add(CategoriesModel.fromJson(element));
            }
        );
      }).
      catchError((error) {
        print(error);
        emit(GetDataError(error));
      });
      DioHelper.getData(url: 'products').
      then((value) {
        emit(GetDataSuccess());
        value.data.forEach(
                (element) {
              productsModel.add(ProductModel.fromJson(element));
              for (var element1 in categoriesModel) {
                if (element['category_id'] == element1.id) {
                  element1.products.add(ProductModel.fromJson(element));
                }
              }
            }
        );
        getCartData();
      }).
      catchError((error) {
        showToast(context: context, msg: error.toString());
        emit(GetDataError(error));
      });
    }


    late List<ProductModel> dataSearch = [];

    void getSearchData(String? search) {
      dataSearch = [];
      emit(GetSearchDataLoading());
      for (var element in productsModel) {
        if (element.productName!.contains('$search')) {
          dataSearch.add(element);
        }
      }
      emit(GetSearchDataSuccess());
    }

    void deleteCart() {
      for (var element in cartModel) {
        CacheHelper.removeData('quantity${element.id}');
      }
      cartModel = [];
      cartItems = 0;
      CacheHelper.removeData('cartItems');
      CacheHelper.removeData('idCartProduct');
      for (var element in products_test) {
        element.quantity=0;
      }
      emit(RemoveDataOfCArt());
    }

    void signOut(context) {
      CacheHelper.removeData('token');
      pushAndReplacement(context: context, screen: const Login());
      emit(SignOutState());
    }

}
