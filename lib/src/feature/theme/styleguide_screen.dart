import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/badges.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/components/cards.dart';
import 'package:nucleusv2/src/feature/theme/app_theme.dart';
import 'package:nucleusv2/src/feature/user/components/acx_iconmenu.dart';

const int wid=206;

@RoutePage()
class StyleguideScreen extends BaseScreen {
  const StyleguideScreen({super.key});

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: const AcxIconMenu(),
      centerTitle: false,
      title: const SelectableText("Style Guide"),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final textTheme = Theme.of(context).textTheme;
    //final _colorScheme = Theme.of(context).colorScheme;

    final List<IconData> icons = [
      Icons.favorite,
      Icons.favorite_outline,
      Icons.bookmark,
      Icons.bookmark_outline,
      Icons.delete,
      Icons.play_arrow_rounded,
      Icons.pause_rounded,
      Icons.shuffle_rounded,
      Icons.shuffle_on_rounded,
      Icons.repeat_rounded,
      Icons.repeat_one_rounded,
      Icons.repeat_on_rounded,
      Icons.playlist_play_rounded,
      Icons.playlist_add,
      Icons.skip_previous_rounded,
      Icons.skip_next_rounded,
      Icons.volume_mute,
      Icons.more_horiz,
      Icons.more_vert,
      Icons.chevron_left,
      Icons.chevron_right,
      Icons.keyboard_arrow_down_rounded,
      Icons.keyboard_arrow_up_rounded,
      Icons.close,
      Icons.email,
      Icons.phone,
      Icons.place,
      Icons.check,
      Icons.warning,
      Icons.error,
      Icons.notification_important,
      Icons.add,
      Icons.waves,
      Icons.sort,
      Icons.filter_list,
      Icons.person,
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Heading("Headings"),
          SelectableText("Heading 1", style: textTheme.displayLarge),
          SelectableText("Heading 2", style: textTheme.displayMedium),
          SelectableText("Heading 3", style: textTheme.displaySmall),
          SelectableText("Heading 4", style: textTheme.headlineMedium),
          SelectableText("Heading 5", style: textTheme.headlineSmall),
          SelectableText("Heading 6", style: textTheme.titleLarge),
          SelectableText("Subtitle 1", style: textTheme.titleMedium),
          SelectableText("Subtitle 2", style: textTheme.titleSmall),
          const _Heading("Buttons"),
          Wrap(
            children: [
              AppButton(
                label: "Elevated Primary",
                onPressed: () {},
              ),
              const _Spacer(size: 12, horizontal: true),
              AppButton(
                label: "Outlined Primary",
                onPressed: () {},
                type: AppButtonType.Outlined,
              ),
              const _Spacer(horizontal: true),
              AppButton(
                label: "Text Primary",
                onPressed: () {},
                type: AppButtonType.Text,
              ),
            ],
          ),
          const _Spacer(),
          Wrap(
            children: [
              AppButton(
                label: "Elevated Secondary",
                onPressed: () {},
                variant: AppColorVariant.Secondary,
              ),
              const _Spacer(horizontal: true),
              AppButton(
                label: "Outlined Secondary",
                onPressed: () {},
                type: AppButtonType.Outlined,
                variant: AppColorVariant.Secondary,
              ),
              const _Spacer(horizontal: true),
              AppButton(
                label: "Text Secondary",
                onPressed: () {},
                type: AppButtonType.Text,
                variant: AppColorVariant.Secondary,
              ),
            ],
          ),
          const _Spacer(),
          Wrap(
            children: [
              AppButton(
                label: "Elevated Danger",
                onPressed: () {},
                variant: AppColorVariant.Danger,
              ),
              const _Spacer(horizontal: true),
              AppButton(
                label: "Outlined Danger",
                onPressed: () {},
                type: AppButtonType.Outlined,
                variant: AppColorVariant.Danger,
              ),
              const _Spacer(horizontal: true),
              AppButton(
                label: "Text Danger",
                onPressed: () {},
                type: AppButtonType.Text,
                variant: AppColorVariant.Danger,
              ),
            ],
          ),
          const _Spacer(),
          Wrap(
            children: [
              AppButton(
                label: "Icon",
                onPressed: () {},
                icon: Icons.favorite,
              ),
              const _Spacer(horizontal: true),
              AppButton(
                label: "Processing",
                onPressed: () {},
                processing: true,
                variant: AppColorVariant.Secondary,
                type: AppButtonType.Outlined,
              ),
              const _Spacer(horizontal: true),
              const AppButton(
                label: "Disabled",
              ),
            ],
          ),
          const _Heading("Text"),
          SelectableText(
            "Body Text 1: Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus suscipit tortor eget felis porttitor volutpat. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Vivamus suscipit tortor eget felis porttitor volutpat.",
            style: textTheme.bodyLarge,
          ),
          const _Spacer(),
          SelectableText(
            "Body Text 2: Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus suscipit tortor eget felis porttitor volutpat. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Vivamus suscipit tortor eget felis porttitor volutpat.",
            style: textTheme.bodyMedium,
          ),
          const _Spacer(),
          SelectableText(
            "Caption: Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus suscipit tortor eget felis porttitor volutpat. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Vivamus suscipit tortor eget felis porttitor volutpat.",
            style: textTheme.bodySmall,
          ),
          const _Heading("List Tiles"),
          ListTile(
            title: const SelectableText("List Tile"),
            subtitle: const SelectableText("Default list tile..."),
            leading: const Icon(Icons.inbox),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            dense: true,
            title: const SelectableText("Dense List Tile"),
            subtitle: const SelectableText("Dense list tile..."),
            leading: const Icon(Icons.inbox),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const _Heading("Cards"),
          Wrap(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: const AppCard(
                  child: SelectableText(
                    "Simple Card",
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: const AppCard(
                  headerText: "Header here",
                  child: SelectableText(
                    "Card with header",
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: const AppCard(
                  headerText: "Header here",
                  footerText: "Footer here",
                  headerTrailing: AppBadge(label: "Badge"),
                  child: SelectableText(
                    "Card with header and footer",
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: AppCard(
                  headerText: "A Lovely Card",
                  headerLeading: const Icon(Icons.verified),
                  headerTrailing: IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.more_horiz,
                    ),
                    onPressed: () {},
                  ),
                  footerText: "The is the footer",
                  child: const SelectableText(
                    "This is a card",
                  ),
                ),
              ),
            ],
          ),
          const _Heading("Icons"),
          Wrap(children: icons.map((icon) => _Icon(icon)).toList())
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String label;
  const _Heading(this.label);

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectableText(
            label,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }
}

class _Spacer extends StatelessWidget {
  final double size;
  final bool horizontal;
  const _Spacer({this.size = 12.0, this.horizontal = false});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return horizontal ? SizedBox(width: size) : SizedBox(height: size);
  }
}

class _Icon extends StatelessWidget {
  final IconData icon;
  const _Icon(this.icon);

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon(icon),
    );
  }
}
