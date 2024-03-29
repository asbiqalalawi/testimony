import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testimony/cubit/home_cubit.dart';
import 'package:testimony/cubit/language_cubit.dart';
import 'package:testimony/model/language_model.dart';
import 'package:testimony/service/home_service.dart';
import 'package:testimony/view/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(HomeService())),
        BlocProvider(create: (context) => LanguageCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageModel>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Testimony',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(state.code),
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
