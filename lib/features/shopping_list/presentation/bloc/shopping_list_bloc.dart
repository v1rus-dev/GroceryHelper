import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListInitial()) {
    print('Init shopping list bloc');
    on<ShoppingListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  Future<void> close() {
    print('Close shopping list bloc');
    return super.close();
  }
}
