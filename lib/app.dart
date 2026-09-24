import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'features/subnet/presentation/cubit/cidr_cubit.dart';
import 'features/subnet/presentation/cubit/subnet_cubit.dart';
import 'features/subnet/presentation/pages/home_shell.dart';
import 'l10n/app_localizations.dart';

class SubnetterApp extends StatelessWidget {
  const SubnetterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SettingsCubit>()..init()),
        BlocProvider(create: (_) => sl<SubnetCubit>()),
        BlocProvider(create: (_) => sl<CidrCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, dynamic>(
        builder: (context, _) {
          final s = context.watch<SettingsCubit>().state;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: s.themeMode,
            locale: s.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const HomeShell(),
          );
        },
      ),
    );
  }
}