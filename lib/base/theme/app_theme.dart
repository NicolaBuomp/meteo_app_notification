import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightPrimaryColor = Color(0xFF6F62FD);
  static const Color lightBackgroundColor = Color(0xFF6F62FD);
  static const Color darkPrimaryColor = Color.fromARGB(255, 35, 26, 130);
  static const Color darkBackgroundColor = Color.fromARGB(255, 36, 27, 133);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5397E1), // Blu chiaro
    scaffoldBackgroundColor: const Color(0xFF695CEC), // Sfondo blu chiaro
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF695CEC), // Blu primario
      onPrimary: Colors.white, // Testo bianco su elementi primari
      secondary: const Color(0xFF8AA0F8), // Blu ancora più chiaro
      onSecondary: Colors.white, // Testo su secondario
      surface: Colors.white,
      onSurface: const Color(0xFF695CEC),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6631BD),
        foregroundColor: Colors.white, // Colore del testo
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 12), // Padding interno
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500), // Stile del testo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Angoli arrotondati
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF6631BD), // Sfondo bianco per le card
      elevation: 4, // Elevazione per effetto ombra
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white, fontSize: 40),
      headlineSmall: TextStyle(color: Colors.white, fontSize: 20),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(Colors.white),
      overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF6A5AE0), // Viola scuro
    scaffoldBackgroundColor: const Color(0xFF0B1131), // Blu notte
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF6A5AE0), // Viola primario
      onPrimary: Colors.white, // Testo bianco su elementi primari
      secondary: const Color(0xFF8AA0F8), // Blu chiaro per elementi secondari
      onSecondary: Colors.white, // Testo su secondario
      surface: const Color(0xFF6A5AE0), // Sfondo delle card
      onSurface: Colors.white, // Testo su superfici
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromARGB(255, 46, 45, 51), // Colore di sfondo
        foregroundColor: Colors.white, // Colore del testo
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 12), // Padding interno
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500), // Stile del testo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Angoli arrotondati
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // Testo bianco per body
      bodyMedium: TextStyle(color: Colors.white),
      headlineLarge:
          TextStyle(color: Colors.white, fontSize: 40), // Testo titoli
      headlineSmall: TextStyle(color: Colors.white, fontSize: 20),
    ),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.all(const Color(0xFF6A5AE0)), // Stile scuro
      overlayColor:
          WidgetStateProperty.all(const Color(0xFF6A5AE0).withOpacity(0.1)),
    ),
  );
}
