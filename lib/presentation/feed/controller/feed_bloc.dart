import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/presentation/feed/controller/feed_state.dart';

class FeedBloc extends Cubit<FeedState>{

  FeedBloc():super(FeedInitialState());
}