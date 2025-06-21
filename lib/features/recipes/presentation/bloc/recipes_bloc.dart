import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc() : super(RecipesInitial()) {
    print('Init recipes bloc');
    on<RecipesInit>(_oninit);
  }

  _oninit(RecipesInit event, Emitter<RecipesState> emit) async {}

  @override
  Future<void> close() {
    print('Close recipes bloc');
    return super.close();
  }
}
