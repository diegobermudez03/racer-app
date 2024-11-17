import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/presentation/chats/controller/chats_states.dart';

class ChatsBloc extends Cubit<ChatsState>{

  ChatsBloc():super(ChatsInitialState());
}