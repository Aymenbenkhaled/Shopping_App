import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/models/search_model.dart';
import 'package:ishopit/modules/search/cubit/state.dart';
import 'package:ishopit/shared/components/constants.dart';
import 'package:ishopit/shared/network/endpoints.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';
import 'package:ishopit/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void SearchData(value) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {'text' : value}, token: token)
        .then((value) {
          searchModel = SearchModel.fromJson(value.data);
          print(searchModel!.message);
          emit(SearchSuccessState());
    })
        .catchError((onError) {
          print(onError);
          emit(SearchErrorState());
    });
  }
}
