import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

/// For Roboto Google Font
myStyleRoboto({required double fontSize, required Color color, FontWeight ?fontWeight, FontStyle? fontStyle, double? letterSpacing, TextDecoration? textDirection, Color? decorationColor}){
  return GoogleFonts.roboto(fontSize: fontSize, color: color, fontWeight: fontWeight, fontStyle: fontStyle, letterSpacing: letterSpacing, decoration: textDirection, decorationColor: decorationColor);
}
