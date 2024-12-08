import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_with_bloc/home_screen/api/product_repository.dart';

import '../api/product_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<HomeLoadingDate>((event, emit) async {
      emit(HomeLoading());
      try {
        final result = await ProductRepository().getData();
        if (result != []) {
          emit(
            HomeSuccess(
              productList: result,
            ),
          );
        } else {
          emit(
            HomeError(),
          );
        }
      } catch (e) {
        emit(
          HomeError(),
        );
      }
    });
  }
}
