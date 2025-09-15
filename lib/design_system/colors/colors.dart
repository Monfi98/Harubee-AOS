import 'dart:ui';

enum Appearance {
  light,
  dark
}

class Colors {
  static Color mainPrimary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF5849E4);
      case Appearance.dark: return const Color(0xFF5849DF);
    }
  }
  static Color mainPrimary30(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x4D4956E4);
      case Appearance.dark: return const Color(0x4D5849DF);
    }
  }
  static Color mainPrimary10(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x1A5849E4);
      case Appearance.dark: return const Color(0x265849DF);
    }
  }
  static Color mainSecondary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF898EEB);
      case Appearance.dark: return const Color(0xFF5E50D7);
    }
  }
  static Color mainTertiary60(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x99D6D6FD);
      case Appearance.dark: return const Color(0x335144C3);
    }
  }
  static Color mainTertiary15(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x26D6D6FD);
      case Appearance.dark: return const Color(0x33877CE8);
    }
  }
  static Color mainTertiary10(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x1AD6D6FD);
      case Appearance.dark: return const Color(0x1C877CE8);
    }
  }
  static Color textPrimary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF21212E);
      case Appearance.dark: return const Color(0xFFFCFCFC);
    }
  }
  static Color textPrimary30(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x4D21212E);
      case Appearance.dark: return const Color(0x59FCFCFC);
    }
  }
  static Color textPrimary10(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x1A21212E);
      case Appearance.dark: return const Color(0x1AFCFCFC);
    }
  }
  static Color textPrimary5(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x0D21212E);
      case Appearance.dark: return const Color(0x0DFCFCFC);
    }
  }
  static Color textSecondary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF9AA5D1);
      case Appearance.dark: return const Color(0xFF5D608F);
    }
  }
  static Color textSecondary40(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x669AA5D1);
      case Appearance.dark: return const Color(0x66393B66);
    }
  }
  static Color textTertiary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFFC4C2E0);
      case Appearance.dark: return const Color(0xFF64666F);
    }
  }
  static Color textTertiary30(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x4DD6DAEC);
      case Appearance.dark: return const Color(0x4D64666F);
    }
  }
  static Color textFixed = const Color(0xFFFEFEFE);
  static Color bgPrimary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFFFEFEFE);
      case Appearance.dark: return const Color(0xFF17172A);
    }
  }
  static Color bgSecondary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFFF0F0FE);
      case Appearance.dark: return const Color(0xFF45428A);
    }
  }
  static Color bgSecondary50(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x80F0F0FE);
      case Appearance.dark: return const Color(0x4D413E85);
    }
  }
  static Color bgAccent(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF5849E4);
      case Appearance.dark: return const Color(0x33413E85);
    }
  }
  static Color warning(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFFFF5252);
      case Appearance.dark: return const Color(0xFFD65252);
    }
  }
  static Color warning10(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x1AFF5C5C);
      case Appearance.dark: return const Color(0x1AD65252);
    }
  }
  static Color info(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF21212E);
      case Appearance.dark: return const Color(0xFF17172A);
    }
  }
  static Color strict(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x4D5849E4);
      case Appearance.dark: return const Color(0xFF5F5CB3);
    }
  }
  static Color alertBg(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x1A5849E4);
      case Appearance.dark: return const Color(0xFF28265C);
    }
  }
  static Color alertText(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF5849E4);
      case Appearance.dark: return const Color(0xFFA4A1EF);
    }
  }
  static Color hivePrimary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFFFEFEFE);
      case Appearance.dark: return const Color(0xFF5849DF);
    }
  }
  static Color hiveText(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF5849E4);
      case Appearance.dark: return const Color(0xFFFCFCFC);
    }
  }
  static Color dayText(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF5849E4);
      case Appearance.dark: return const Color(0xFF17172A);
    }
  }
  static Color mainText(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF5849E4);
      case Appearance.dark: return const Color(0xFF6F6FFF);
    }
  }
  static Color hiveSecondary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF898EEB);
      case Appearance.dark: return const Color(0xFF3A1F9F);
    }
  }
  static Color hiveSecondaryBack(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x4D21212E);
      case Appearance.dark: return const Color(0x4D4C3FBF);
    }
  }
  static Color hiveSecondaryButton(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x99D6D6FD);
      case Appearance.dark: return const Color(0x665144C3);
    }
  }
  static Color hiveSecondaryText(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x80F0F0FE);
      case Appearance.dark: return const Color(0x99877CE8);
    }
  }
  static Color hivePrimaryBack(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFFD6DAEC);
      case Appearance.dark: return const Color(0x4D7769FF);
    }
  }
  static Color hivePrimaryButton(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x99D6D6FD);
      case Appearance.dark: return const Color(0x1AFCFCFC);
    }
  }
  static Color mainBgPrimary(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFFFEFEFE);
      case Appearance.dark: return const Color(0x4D413E85);
    }
  }
  static Color mainBgAccent(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0xFF5849E4);
      case Appearance.dark: return const Color(0xFF17172A);
    }
  }
  static Color textSecondaryInversion(Appearance mode) {
    switch (mode) {
      case Appearance.light: return const Color(0x80F0F0FE);
      case Appearance.dark: return const Color(0x4DFEFEFE);
    }
  }
}