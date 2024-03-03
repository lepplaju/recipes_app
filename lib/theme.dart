import 'package:flutter/material.dart';

class CustomTheme {
  // ThemeData getDefaultTheme() {
  //   return ThemeData(
  //       primaryColor: Colors.blue,
  //       elevatedButtonTheme: ElevatedButtonThemeData(
  //           style: ButtonStyle(
  //               backgroundColor:
  //                   MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
  //               // Foregroundcolor sets the color of the text inside the button
  //               foregroundColor: MaterialStateProperty.all<Color>(Colors.brown),
  //               textStyle: MaterialStateProperty.all<TextStyle>(
  //                 TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ))));
  // }

  ThemeData getDefaultTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey[800], // Primary color for the app
      hintColor: Colors.blueAccent, // Accent color for buttons, etc.
      scaffoldBackgroundColor:
          Colors.blueGrey[900], // Background color for scaffold
      cardColor: Colors.blueGrey[800], // Background color for cards
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.blueAccent, // Color of selected text
        cursorColor: Colors.blueAccent, // Color of the text cursor
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.blueAccent), // Background color of ElevatedButton
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontSize: 16, // Font size of text in ElevatedButton
              fontWeight:
                  FontWeight.bold, // Font weight of text in ElevatedButton
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              Colors.blueAccent), // Color of text in TextButton
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.blueGrey[800], // Fill color of TextField
        border: OutlineInputBorder(
          // Border of TextField
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          // Border of TextField when enabled
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          // Border of TextField when focused
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.blueGrey[800], // Background color of AppBar
        elevation: 0, // Elevation of AppBar
        iconTheme:
            IconThemeData(color: Colors.blueAccent), // Color of icons in AppBar
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            Colors.blueGrey[800], // Background color of BottomNavigationBar
        selectedItemColor:
            Colors.blueAccent, // Color of selected item in BottomNavigationBar
        unselectedItemColor:
            Colors.grey, // Color of unselected item in BottomNavigationBar
      ),
    );
  }
}
