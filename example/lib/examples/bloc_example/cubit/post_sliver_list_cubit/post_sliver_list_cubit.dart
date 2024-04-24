import 'package:bloc/bloc.dart';

part 'post_sliver_list_state.dart';

class PostSliverListCubit extends Cubit<PostSliverListState> {
  PostSliverListCubit() : super(PostSliverListInitial());
}
