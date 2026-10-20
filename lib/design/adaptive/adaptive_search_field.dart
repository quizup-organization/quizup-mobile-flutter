import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../components/search_field.dart';
import '../tokens.dart';
import 'native_style.dart';

class AdaptiveSearchField extends StatelessWidget {
  const AdaptiveSearchField({
    super.key,
    required this.controller,
    this.hint = 'Rechercher un sujet',
    this.onChanged,
    this.onFilter,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilter;

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    if (!settings.isPlatformMode) {
      return QuizupSearchField(
        controller: controller,
        hint: hint,
        onChanged: onChanged,
        onFilter: onFilter,
      );
    }

    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final platform = settings.resolvedPlatform;

    if (platform == TargetPlatform.iOS) {
      return cupertino.CupertinoSearchTextField(
        controller: controller,
        onChanged: onChanged,
        placeholder: hint,
        backgroundColor: colors.inputMuted,
        borderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        style: nativeTextStyle(
          platform: platform,
          size: 14,
          weight: FontWeight.w400,
          color: colors.foreground,
        ),
        placeholderStyle: nativeTextStyle(
          platform: platform,
          size: 14,
          weight: FontWeight.w400,
          color: colors.mutedForeground,
        ),
        prefixIcon: Icon(
          cupertino.CupertinoIcons.search,
          size: 19,
          color: colors.mutedForeground,
        ),
        suffixIcon: Icon(
          cupertino.CupertinoIcons.slider_horizontal_3,
          size: 19,
          color: colors.foreground,
        ),
        suffixMode: cupertino.OverlayVisibilityMode.always,
        onSuffixTap: onFilter,
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      cursorColor: colors.primary,
      style: nativeTextStyle(
        platform: platform,
        size: 14,
        weight: FontWeight.w400,
        color: colors.foreground,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: colors.inputMuted,
        hintText: hint,
        hintStyle: nativeTextStyle(
          platform: platform,
          size: 14,
          weight: FontWeight.w400,
          color: colors.mutedForeground,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 20,
          color: colors.mutedForeground,
        ),
        suffixIcon: onFilter == null
            ? null
            : IconButton(
                onPressed: onFilter,
                tooltip: 'Filtres',
                icon: Icon(Icons.tune_rounded, size: 20),
              ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colors.ring),
        ),
      ),
    );
  }
}
