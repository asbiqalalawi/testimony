class LanguageModel {
  final String code;
  final String value;

  const LanguageModel({
     required this.code,
     required this.value,
  });
}

class Languages {
  const Languages._();

  static const languages = [
    LanguageModel(code: 'en', value: 'English'),
    LanguageModel(code: 'id', value: 'Bahasa Indonesia'),
  ];
}