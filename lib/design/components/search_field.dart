import 'package:material_ui/material_ui.dart';

import '../tokens.dart';

class QuizupSearchField extends StatelessWidget {
  const QuizupSearchField({
    super.key,
    required this.controller,
    this.hint = 'Rechercher un sujet',
    this.onChanged,
    this.onFilter,
    this.autofocus = false,
    this.focusNode,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilter;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      cursorColor: colors.primary,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: colors.foreground,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: colors.inputMuted,
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
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
                icon: Icon(
                  Icons.tune_rounded,
                  size: 20,
                  color: colors.foreground,
                ),
              ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radii.input),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radii.input),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radii.input),
          borderSide: BorderSide(color: colors.ring, width: 1),
        ),
      ),
    );
  }
}
