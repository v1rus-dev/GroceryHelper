import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'products_list_event.dart';
part 'products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductsListBloc() : super(ProductsInitial()) {
    print('Init products bloc');
    on<ProductsListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  Future<void> close() {
    print('Close products bloc');
    return super.close();
  }
}
