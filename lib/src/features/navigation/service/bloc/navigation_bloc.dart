import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationArticlesState()) {
    on<NavigationToArticlesEvent>(
        (event, emit) => emit(NavigationArticlesState()));
    on<NavigationToCategoriesEvent>(
        (event, emit) => emit(NavigationCategoriesState()));
    on<NavigationToFavouritesEvent>(
        (event, emit) => emit(NavigationFavouritesState()));
    on<NavigationToUserEvent>((event, emit) => emit(NavigationUserState()));
  }
}
