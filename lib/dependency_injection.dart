import 'package:get_it/get_it.dart';
import 'package:racer_app/presentation/login/controller/auth_blocs.dart';
import 'package:racer_app/repository/auth_repo.dart';

final inst = GetIt.instance;

void initDependencies(){
    //register repos
    inst.registerLazySingleton<AuthRepo>(()=>AuthRepoFirebase());

    //register blocs
    inst.registerFactory<LoginBloc>(()=>LoginBloc(inst.get()));
}