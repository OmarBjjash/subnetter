import 'package:get_it/get_it.dart';
import '../../features/settings/data/settings_repository.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/subnet/domain/usecases/calculate_subnets.dart';
import '../../features/subnet/presentation/cubit/cidr_cubit.dart';
import '../../features/subnet/presentation/cubit/subnet_cubit.dart';

final sl = GetIt.instance;

Future<void> setupDI() async {
  // Repositories
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepository());

  // Use cases
  sl.registerLazySingleton(() => CalculateSubnetsUseCase());
  sl.registerLazySingleton(() => CalculateCidrUseCase());

  // Cubits (singletons so state survives navigation)
  sl.registerLazySingleton(() => SubnetCubit(sl()));
  sl.registerLazySingleton(() => CidrCubit(sl()));
  sl.registerLazySingleton(() => SettingsCubit(sl()));
}