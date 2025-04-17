import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/layout/cubit/cubit.dart';
import 'package:food_order2/layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/defaultTextBox.dart';
import '../../shared/components/product_item.dart';


class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var searchController=TextEditingController();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        Size size=MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                if(state is GetSearchDataLoading)
                  const LinearProgressIndicator(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultTextbox(
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    onFieldSubmitted: (value){
                      HomeCubit.get(context).getSearchData(value);
                    },
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'search',
                    direction: TextDirection.rtl,
                    onTap: (){
                      final TextSelection textSelection = TextSelection.collapsed(
                          offset: searchController.text.length);
                      searchController.selection = textSelection;
                    }
                  ),
                ),
                ConditionalBuilder(
                  builder: (context) =>
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GridView.count(
                            childAspectRatio: (size.width/2-20) / 172,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            children: List.generate(
                              HomeCubit.get(context).dataSearch.length,
                                  (index) =>
                                  ProductItem(product: HomeCubit.get(context).dataSearch[index],productWidth: size.width/2-20,),
                            ),
                            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                          ),
                        ),
                      ),
                  condition: HomeCubit
                      .get(context)
                      .dataSearch.isNotEmpty,
                  fallback: (context) =>  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Search for any product',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
