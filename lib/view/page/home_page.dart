import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testimony/cubit/home_cubit.dart';
import 'package:testimony/cubit/language_cubit.dart';
import 'package:testimony/model/language_model.dart';
import 'package:testimony/view/widget/testimony_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 2;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getTestimonies();
  }

  void _search() {
    if (_searchController.text.isNotEmpty) {
      context.read<HomeCubit>().searchTestimonies(search: _searchController.text);
    } else {
      page = 2;
      context.read<HomeCubit>().getTestimonies();
    }
  }

  _changeLanguage() {
    return showDialog(
      context: context,
      builder: (context) => BlocBuilder<LanguageCubit, LanguageModel>(
        builder: (context, state) {
          return Dialog(
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.choose_language,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    RadioListTile<LanguageModel>(
                      title: const Text('English'),
                      value: Languages.languages[0],
                      groupValue: state,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<LanguageCubit>().changeLocale(value);
                        }
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile<LanguageModel>(
                      title: const Text('Bahasa Indonesia'),
                      value: Languages.languages[1],
                      groupValue: state,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<LanguageCubit>().changeLocale(value);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onSubmitted: (_) {
            _search();
          },
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.search,
            suffixIcon: IconButton(
              onPressed: () {
                _search();
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _changeLanguage();
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccess) {
              return Scrollbar(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    if (index < state.testimonies.length) {
                      return TestimonyCard(testimony: state.testimonies[index]);
                    }
                    if (state.fullLoaded ?? false) {
                      return Center(child: Text(AppLocalizations.of(context)!.data_loaded));
                    }
                    if (_searchController.text.isEmpty) {
                      context.read<HomeCubit>().getMoreTestimonies(context, page: page++);
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const SizedBox();
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemCount: state.testimonies.length + 1,
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
