// ignore_for_file: constant_identifier_names

import 'package:nucleusv2/src/feature/theme/app_theme.dart';

import 'package:flutter/material.dart';

enum AppButtonType { Elevated, Outlined, Text }

class AppButton extends StatelessWidget {
  final String label;
  final String? tooltip;
  final Function()? onPressed;
  final AppButtonType type;
  final AppColorVariant variant;
  final AppSizeVariant size;
  final bool processing;
  final IconData? icon;
  final bool iconTrails;

  const AppButton({
    super.key,
    required this.label,
    this.tooltip = '',
    this.onPressed,
    this.type = AppButtonType.Elevated,
    this.variant = AppColorVariant.Primary,
    this.size = AppSizeVariant.Md,
    this.processing = false,
    this.icon,
    this.iconTrails = false,
  });

  ButtonStyle _styleElevated(BuildContext context) {
    switch (variant) {
      case AppColorVariant.Primary:
        return ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primaryButtonFg,
          backgroundColor: Theme.of(context).colorScheme.primaryButtonBg,
        );
      case AppColorVariant.Secondary:
        return ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.secondaryButtonFg,
          backgroundColor: Theme.of(context).colorScheme.secondaryButtonBg,
        );
      case AppColorVariant.Danger:
        return ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.dangerButtonFg,
          backgroundColor: Theme.of(context).colorScheme.dangerButtonBg,
        );
    }
  }

  ButtonStyle _styleOutlined(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (variant) {
      case AppColorVariant.Primary:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primaryButtonBg,
        );
      case AppColorVariant.Secondary:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.secondaryButtonBg,
        );
      case AppColorVariant.Danger:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.dangerButtonBg,
        );
    }
  }

  ButtonStyle _styleText(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (variant) {
      case AppColorVariant.Primary:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primaryButtonBg,
        );
      case AppColorVariant.Secondary:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.secondaryButtonBg,
        );
      case AppColorVariant.Danger:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.dangerButtonBg,
        );
    }
  }

  Color _iconColor(dynamic context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (onPressed == null) {
      return Theme.of(context).disabledColor;
    }

    switch (type) {
      case AppButtonType.Elevated:
        switch (variant) {
          case AppColorVariant.Primary:
            return colorScheme.primaryButtonFg;
          case AppColorVariant.Secondary:
            return colorScheme.secondaryButtonFg;
          case AppColorVariant.Danger:
            return colorScheme.dangerButtonFg;
        }
      case AppButtonType.Text:
      case AppButtonType.Outlined:
        switch (variant) {
          case AppColorVariant.Primary:
            return colorScheme.primaryButtonBg;
          case AppColorVariant.Secondary:
            return colorScheme.secondaryButtonBg;
          case AppColorVariant.Danger:
            return colorScheme.dangerButtonBg;
        }
    }
  }

  Widget _child(BuildContext context) {
    if (icon != null || processing) {
      return Tooltip(
        message: tooltip ?? label,
        child: Wrap(
          textDirection: iconTrails ? TextDirection.rtl : TextDirection.ltr,
          children: [
            processing
                ? SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      color: _iconColor(context),
                      strokeWidth: 2.0,
                    ),
                  )
                : Icon(
                    icon,
                    size: 16,
                    color: _iconColor(context),
                  ),
            const SizedBox(
              width: 6,
            ),
            Text(label),
          ],
        ),
      );
    }

    return Text(label);
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppButtonType.Elevated:
        return ElevatedButton(
          onPressed: processing ? () {} : onPressed,
          style: _styleElevated(context),
          child: _child(context),
        );
      case AppButtonType.Outlined:
        return OutlinedButton(
          onPressed: processing ? () {} : onPressed,
          style: _styleOutlined(context),
          child: _child(context),
        );
      case AppButtonType.Text:
        return TextButton(
          onPressed: processing ? () {} : onPressed,
          style: _styleText(context),
          child: _child(context),
        );
    }
  }
}
