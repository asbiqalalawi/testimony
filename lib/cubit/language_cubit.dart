import 'package:bloc/bloc.dart';
import 'package:testimony/model/language_model.dart';

class LanguageCubit extends Cubit<LanguageModel> {
  LanguageCubit() : super(Languages.languages[0]);

  changeLocale(LanguageModel locale) => emit(locale);
}
