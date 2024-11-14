/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 62 (31 per locale)
///
/// Built on 2024-11-13 at 13:46 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.it;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.it) // set locale
/// - Locale locale = AppLocale.it.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.it) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	it(languageCode: 'it', build: Translations.build),
	en(languageCode: 'en', build: _TranslationsEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of translation).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = translation.someKey.anotherKey;
/// String b = translation['someKey.anotherKey']; // Only for edge cases!
Translations get translation => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final translation = Translations.of(context); // Get translation variable.
/// String a = translation.someKey.anotherKey; // Use translation variable.
/// String b = translation['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.translation.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get translation => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final translation = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsWeatherIt weather = _TranslationsWeatherIt._(_root);
	late final _TranslationsNavigationBarIt navigationBar = _TranslationsNavigationBarIt._(_root);
	late final _TranslationsFavoritesIt favorites = _TranslationsFavoritesIt._(_root);
	late final _TranslationsSettingsIt settings = _TranslationsSettingsIt._(_root);
	late final _TranslationsErrorsIt errors = _TranslationsErrorsIt._(_root);
	late final _TranslationsButtonsIt buttons = _TranslationsButtonsIt._(_root);
}

// Path: weather
class _TranslationsWeatherIt {
	_TranslationsWeatherIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get temperature => 'Temperatura';
	String get humidity => 'Umidità';
	String get wind => 'Vento';
	String get details => 'Dettagli';
}

// Path: navigationBar
class _TranslationsNavigationBarIt {
	_TranslationsNavigationBarIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsNavigationBarLabelIt label = _TranslationsNavigationBarLabelIt._(_root);
}

// Path: favorites
class _TranslationsFavoritesIt {
	_TranslationsFavoritesIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Preferiti';
	String get empty => 'Nessuna città preferita';
	String get add => 'Aggiungi ai preferiti';
	String get remove => 'Rimuovi dai preferiti';
}

// Path: settings
class _TranslationsSettingsIt {
	_TranslationsSettingsIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Impostazioni';
	late final _TranslationsSettingsThemeIt theme = _TranslationsSettingsThemeIt._(_root);
	late final _TranslationsSettingsLanguageIt language = _TranslationsSettingsLanguageIt._(_root);
	late final _TranslationsSettingsActionsIt actions = _TranslationsSettingsActionsIt._(_root);
}

// Path: errors
class _TranslationsErrorsIt {
	_TranslationsErrorsIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get generic => 'Si è verificato un errore';
	String get location_denied => 'Permesso di localizzazione negato';
	String get location_denied_forever => 'Permesso negato permanentemente';
	String get location_disabled => 'Servizi di localizzazione disabilitati';
}

// Path: buttons
class _TranslationsButtonsIt {
	_TranslationsButtonsIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get save => 'Salva';
	String get cancel => 'Annulla';
	String get retry => 'Riprova';
}

// Path: navigationBar.label
class _TranslationsNavigationBarLabelIt {
	_TranslationsNavigationBarLabelIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get weather => 'Meteo';
	String get settings => 'Impostazioni';
}

// Path: settings.theme
class _TranslationsSettingsThemeIt {
	_TranslationsSettingsThemeIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Tema';
	String get light => 'Chiaro';
	String get dark => 'Scuro';
	String get system => 'Automatico';
}

// Path: settings.language
class _TranslationsSettingsLanguageIt {
	_TranslationsSettingsLanguageIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Lingua';
	String get italian => 'Italiano';
	String get english => 'Inglese';
}

// Path: settings.actions
class _TranslationsSettingsActionsIt {
	_TranslationsSettingsActionsIt._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get clear_weather => 'Elimina dati meteo';
	String get clear_favorites => 'Elimina città salvate';
	String get clear_all => 'Elimina tutti i dati';
	String get clear_weather_confirmation => 'Dati meteo eliminati';
	String get clear_favorites_confirmation => 'Città preferite eliminate';
	String get clear_all_confirmation => 'Tutti i dati eliminati';
}

// Path: <root>
class _TranslationsEn extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsWeatherEn weather = _TranslationsWeatherEn._(_root);
	@override late final _TranslationsNavigationBarEn navigationBar = _TranslationsNavigationBarEn._(_root);
	@override late final _TranslationsFavoritesEn favorites = _TranslationsFavoritesEn._(_root);
	@override late final _TranslationsSettingsEn settings = _TranslationsSettingsEn._(_root);
	@override late final _TranslationsErrorsEn errors = _TranslationsErrorsEn._(_root);
	@override late final _TranslationsButtonsEn buttons = _TranslationsButtonsEn._(_root);
}

// Path: weather
class _TranslationsWeatherEn extends _TranslationsWeatherIt {
	_TranslationsWeatherEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get temperature => 'Temperature';
	@override String get humidity => 'Humidity';
	@override String get wind => 'Wind';
	@override String get details => 'Details';
}

// Path: navigationBar
class _TranslationsNavigationBarEn extends _TranslationsNavigationBarIt {
	_TranslationsNavigationBarEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsNavigationBarLabelEn label = _TranslationsNavigationBarLabelEn._(_root);
}

// Path: favorites
class _TranslationsFavoritesEn extends _TranslationsFavoritesIt {
	_TranslationsFavoritesEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Favorites';
	@override String get empty => 'No favorite cities';
	@override String get add => 'Add to favorites';
	@override String get remove => 'Remove from favorites';
}

// Path: settings
class _TranslationsSettingsEn extends _TranslationsSettingsIt {
	_TranslationsSettingsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Settings';
	@override late final _TranslationsSettingsThemeEn theme = _TranslationsSettingsThemeEn._(_root);
	@override late final _TranslationsSettingsLanguageEn language = _TranslationsSettingsLanguageEn._(_root);
	@override late final _TranslationsSettingsActionsEn actions = _TranslationsSettingsActionsEn._(_root);
}

// Path: errors
class _TranslationsErrorsEn extends _TranslationsErrorsIt {
	_TranslationsErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get generic => 'An error occurred';
	@override String get location_denied => 'Location permission denied';
	@override String get location_denied_forever => 'Permission permanently denied';
	@override String get location_disabled => 'Location services are disabled';
}

// Path: buttons
class _TranslationsButtonsEn extends _TranslationsButtonsIt {
	_TranslationsButtonsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get save => 'Save';
	@override String get cancel => 'Cancel';
	@override String get retry => 'Retry';
}

// Path: navigationBar.label
class _TranslationsNavigationBarLabelEn extends _TranslationsNavigationBarLabelIt {
	_TranslationsNavigationBarLabelEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get weather => 'Meteo';
	@override String get settings => 'Impostazioni';
}

// Path: settings.theme
class _TranslationsSettingsThemeEn extends _TranslationsSettingsThemeIt {
	_TranslationsSettingsThemeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Theme';
	@override String get light => 'Light';
	@override String get dark => 'Dark';
	@override String get system => 'System';
}

// Path: settings.language
class _TranslationsSettingsLanguageEn extends _TranslationsSettingsLanguageIt {
	_TranslationsSettingsLanguageEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Language';
	@override String get italian => 'Italian';
	@override String get english => 'English';
}

// Path: settings.actions
class _TranslationsSettingsActionsEn extends _TranslationsSettingsActionsIt {
	_TranslationsSettingsActionsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get clear_weather => 'Clear weather data';
	@override String get clear_favorites => 'Clear saved cities';
	@override String get clear_all => 'Clear all data';
	@override String get clear_weather_confirmation => 'Weather data cleared';
	@override String get clear_favorites_confirmation => 'Favorite cities cleared';
	@override String get clear_all_confirmation => 'All data cleared';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'weather.temperature': return 'Temperatura';
			case 'weather.humidity': return 'Umidità';
			case 'weather.wind': return 'Vento';
			case 'weather.details': return 'Dettagli';
			case 'navigationBar.label.weather': return 'Meteo';
			case 'navigationBar.label.settings': return 'Impostazioni';
			case 'favorites.title': return 'Preferiti';
			case 'favorites.empty': return 'Nessuna città preferita';
			case 'favorites.add': return 'Aggiungi ai preferiti';
			case 'favorites.remove': return 'Rimuovi dai preferiti';
			case 'settings.title': return 'Impostazioni';
			case 'settings.theme.title': return 'Tema';
			case 'settings.theme.light': return 'Chiaro';
			case 'settings.theme.dark': return 'Scuro';
			case 'settings.theme.system': return 'Automatico';
			case 'settings.language.title': return 'Lingua';
			case 'settings.language.italian': return 'Italiano';
			case 'settings.language.english': return 'Inglese';
			case 'settings.actions.clear_weather': return 'Elimina dati meteo';
			case 'settings.actions.clear_favorites': return 'Elimina città salvate';
			case 'settings.actions.clear_all': return 'Elimina tutti i dati';
			case 'settings.actions.clear_weather_confirmation': return 'Dati meteo eliminati';
			case 'settings.actions.clear_favorites_confirmation': return 'Città preferite eliminate';
			case 'settings.actions.clear_all_confirmation': return 'Tutti i dati eliminati';
			case 'errors.generic': return 'Si è verificato un errore';
			case 'errors.location_denied': return 'Permesso di localizzazione negato';
			case 'errors.location_denied_forever': return 'Permesso negato permanentemente';
			case 'errors.location_disabled': return 'Servizi di localizzazione disabilitati';
			case 'buttons.save': return 'Salva';
			case 'buttons.cancel': return 'Annulla';
			case 'buttons.retry': return 'Riprova';
			default: return null;
		}
	}
}

extension on _TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'weather.temperature': return 'Temperature';
			case 'weather.humidity': return 'Humidity';
			case 'weather.wind': return 'Wind';
			case 'weather.details': return 'Details';
			case 'navigationBar.label.weather': return 'Meteo';
			case 'navigationBar.label.settings': return 'Impostazioni';
			case 'favorites.title': return 'Favorites';
			case 'favorites.empty': return 'No favorite cities';
			case 'favorites.add': return 'Add to favorites';
			case 'favorites.remove': return 'Remove from favorites';
			case 'settings.title': return 'Settings';
			case 'settings.theme.title': return 'Theme';
			case 'settings.theme.light': return 'Light';
			case 'settings.theme.dark': return 'Dark';
			case 'settings.theme.system': return 'System';
			case 'settings.language.title': return 'Language';
			case 'settings.language.italian': return 'Italian';
			case 'settings.language.english': return 'English';
			case 'settings.actions.clear_weather': return 'Clear weather data';
			case 'settings.actions.clear_favorites': return 'Clear saved cities';
			case 'settings.actions.clear_all': return 'Clear all data';
			case 'settings.actions.clear_weather_confirmation': return 'Weather data cleared';
			case 'settings.actions.clear_favorites_confirmation': return 'Favorite cities cleared';
			case 'settings.actions.clear_all_confirmation': return 'All data cleared';
			case 'errors.generic': return 'An error occurred';
			case 'errors.location_denied': return 'Location permission denied';
			case 'errors.location_denied_forever': return 'Permission permanently denied';
			case 'errors.location_disabled': return 'Location services are disabled';
			case 'buttons.save': return 'Save';
			case 'buttons.cancel': return 'Cancel';
			case 'buttons.retry': return 'Retry';
			default: return null;
		}
	}
}
