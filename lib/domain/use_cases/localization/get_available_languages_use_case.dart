import 'package:doublevpartners/domain/entities/option_locale_entity.dart';
import 'package:doublevpartners/domain/repositories/localization_repository.dart';

class GetAvailableLanguagesUseCase {
  final LocalizationRepository localizationRepository;

  GetAvailableLanguagesUseCase({required this.localizationRepository});

  Future<List<OptionLocaleEntity>> call() =>
      localizationRepository.getAvailableLanguages();
}
