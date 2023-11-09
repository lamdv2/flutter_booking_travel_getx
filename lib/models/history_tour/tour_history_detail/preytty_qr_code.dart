import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/history_tour/history_tour_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class PrettyQrHomePage extends StatefulWidget {
  @override
  State<PrettyQrHomePage> createState() => _PrettyQrHomePageState();
}

class _PrettyQrHomePageState extends State<PrettyQrHomePage> {
  final HistoryTourController historyTourController =
      Get.put(HistoryTourController());

  @override
  Widget build(BuildContext context) {
    return PrettyQrSettings(
      decoration: historyTourController.decoration,
      onChanged: (value) => setState(
        () {
          historyTourController.decoration = value;
        },
      ),
    );
  }
}

class PrettyQrAnimatedView extends StatefulWidget {
  final QrImage qrImage;

  final PrettyQrDecoration decoration;

  const PrettyQrAnimatedView({
    required this.qrImage,
    required this.decoration,
  });

  @override
  State<PrettyQrAnimatedView> createState() => PrettyQrAnimatedViewState();
}

class PrettyQrAnimatedViewState extends State<PrettyQrAnimatedView> {
  late PrettyQrDecoration previosDecoration;

  @override
  void initState() {
    super.initState();

    previosDecoration = widget.decoration;
  }

  @override
  void didUpdateWidget(
    covariant PrettyQrAnimatedView oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (widget.decoration != oldWidget.decoration) {
      previosDecoration = oldWidget.decoration;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TweenAnimationBuilder<PrettyQrDecoration>(
        tween: PrettyQrDecorationTween(
          begin: previosDecoration,
          end: widget.decoration,
        ),
        curve: Curves.ease,
        duration: const Duration(
          milliseconds: 240,
        ),
        builder: (context, decoration, child) {
          return PrettyQrView(
            qrImage: widget.qrImage,
            decoration: decoration,
          );
        },
      ),
    );
  }
}

class PrettyQrSettings extends StatefulWidget {
  final PrettyQrDecoration decoration;

  final ValueChanged<PrettyQrDecoration>? onChanged;

  @visibleForTesting
  static const kDefaultPrettyQrDecorationImage = PrettyQrDecorationImage(
    image: AssetImage('assets/icons/ic_logo_app.png'),
    position: PrettyQrDecorationImagePosition.embedded,
  );

  const PrettyQrSettings({
    required this.decoration,
    this.onChanged,
  });

  @override
  State<PrettyQrSettings> createState() => PrettyQrSettingsState();
}

class PrettyQrSettingsState extends State<PrettyQrSettings> {
  final AppController appController = Get.find();

  Color get shapeColor {
    var shape = widget.decoration.shape;
    if (shape is PrettyQrSmoothSymbol) return shape.color;
    if (shape is PrettyQrRoundedSymbol) return shape.color;
    return Colors.black;
  }

  bool get isRoundedBorders {
    var shape = widget.decoration.shape;
    if (shape is PrettyQrSmoothSymbol) {
      return shape.roundFactor > 0;
    } else if (shape is PrettyQrRoundedSymbol) {
      return shape.borderRadius != BorderRadius.zero;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return PopupMenuButton(
              onSelected: changeShape,
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              initialValue: widget.decoration.shape.runtimeType,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    key: UniqueKey(),
                    value: PrettyQrSmoothSymbol,
                    child: Text(
                      'Smooth',
                      style: appController.isDarkModeOn.value
                          ? AppStyles.lightDarkModeSize16Fw500FfMont
                          : AppStyles.gray600Size16Fw500FfMont,
                    ),
                  ),
                  PopupMenuItem(
                    key: UniqueKey(),
                    value: PrettyQrRoundedSymbol,
                    child: Text(
                      'RoundedRectangle',
                      style: appController.isDarkModeOn.value
                          ? AppStyles.lightDarkModeSize16Fw500FfMont
                          : AppStyles.gray600Size16Fw500FfMont,
                    ),
                  ),
                ];
              },
              child: ListTile(
                leading: const Icon(Icons.format_paint_outlined),
                title: Text(
                  'Style',
                  style: AppStyles.gray600Size16Fw500FfMont,
                ),
                trailing: Text(
                  widget.decoration.shape is PrettyQrSmoothSymbol
                      ? 'Smooth'
                      : 'RoundedRectangle',
                  style: appController.isDarkModeOn.value
                      ? AppStyles.lightDarkModeSize16Fw500FfMont
                      : AppStyles.gray600Size16Fw500FfMont,
                ),
              ),
            );
          },
        ),
        SwitchListTile.adaptive(
          value: shapeColor != Colors.black,
          onChanged: (value) => toggleColor(),
          secondary: const Icon(Icons.color_lens_outlined),
          title: Text(
            'Colored',
            style: appController.isDarkModeOn.value
                ? AppStyles.lightDarkModeSize16Fw500FfMont
                : AppStyles.gray600Size16Fw500FfMont,
          ),
        ),
        SwitchListTile.adaptive(
          value: isRoundedBorders,
          onChanged: (value) => toggleRoundedCorners(),
          secondary: const Icon(Icons.rounded_corner),
          title: Text(
            'RoundedCorners',
            style: appController.isDarkModeOn.value
                ? AppStyles.lightDarkModeSize16Fw500FfMont
                : AppStyles.gray600Size16Fw500FfMont,
          ),
        ),
        const Divider(),
        SwitchListTile.adaptive(
          value: widget.decoration.image != null,
          onChanged: (value) => toggleImage(),
          secondary: Icon(
            widget.decoration.image != null
                ? Icons.image_outlined
                : Icons.hide_image_outlined,
          ),
          title: Text(
            'Image',
            style: appController.isDarkModeOn.value
                ? AppStyles.lightDarkModeSize16Fw500FfMont
                : AppStyles.gray600Size16Fw500FfMont,
          ),
        ),
        if (widget.decoration.image != null)
          ListTile(
            enabled: widget.decoration.image != null,
            leading: const Icon(Icons.layers_outlined),
            title: Text(
              'ImagePosition',
              style: appController.isDarkModeOn.value
                  ? AppStyles.lightDarkModeSize16Fw500FfMont
                  : AppStyles.gray600Size16Fw500FfMont,
            ),
            trailing: PopupMenuButton(
              onSelected: changeImagePosition,
              initialValue: widget.decoration.image?.position,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: PrettyQrDecorationImagePosition.embedded,
                    child: Text(
                      'Embedded',
                      style: appController.isDarkModeOn.value
                          ? AppStyles.lightDarkModeSize16Fw500FfMont
                          : AppStyles.gray600Size16Fw500FfMont,
                    ),
                  ),
                  PopupMenuItem(
                    value: PrettyQrDecorationImagePosition.foreground,
                    child: Text(
                      'Foreground',
                      style: appController.isDarkModeOn.value
                          ? AppStyles.lightDarkModeSize16Fw500FfMont
                          : AppStyles.gray600Size16Fw500FfMont,
                    ),
                  ),
                  PopupMenuItem(
                    value: PrettyQrDecorationImagePosition.background,
                    child: Text(
                      'Background',
                      style: appController.isDarkModeOn.value
                          ? AppStyles.lightDarkModeSize16Fw500FfMont
                          : AppStyles.gray600Size16Fw500FfMont,
                    ),
                  ),
                ];
              },
            ),
          ),
      ],
    );
  }

  void changeShape(
    final Type type,
  ) {
    var shape = widget.decoration.shape;
    if (shape.runtimeType == type) return;

    if (shape is PrettyQrSmoothSymbol) {
      shape = PrettyQrRoundedSymbol(color: shapeColor);
    } else if (shape is PrettyQrRoundedSymbol) {
      shape = PrettyQrSmoothSymbol(color: shapeColor);
    }

    widget.onChanged?.call(widget.decoration.copyWith(shape: shape));
  }

  void toggleColor() {
    var shape = widget.decoration.shape;
    var color = shapeColor != Colors.black
        ? Colors.black
        : Theme.of(context).colorScheme.secondary;

    if (shape is PrettyQrSmoothSymbol) {
      shape = PrettyQrSmoothSymbol(
        color: color,
        roundFactor: shape.roundFactor,
      );
    } else if (shape is PrettyQrRoundedSymbol) {
      shape = PrettyQrRoundedSymbol(
        color: color,
        borderRadius: shape.borderRadius,
      );
    }

    widget.onChanged?.call(widget.decoration.copyWith(shape: shape));
  }

  void toggleRoundedCorners() {
    var shape = widget.decoration.shape;

    if (shape is PrettyQrSmoothSymbol) {
      shape = PrettyQrSmoothSymbol(
        color: shape.color,
        roundFactor: isRoundedBorders ? 0 : 1,
      );
    } else if (shape is PrettyQrRoundedSymbol) {
      shape = PrettyQrRoundedSymbol(
        color: shape.color,
        borderRadius: isRoundedBorders
            ? BorderRadius.zero
            : const BorderRadius.all(Radius.circular(10)),
      );
    }

    widget.onChanged?.call(widget.decoration.copyWith(shape: shape));
  }

  void toggleImage() {
    const defaultImage = PrettyQrSettings.kDefaultPrettyQrDecorationImage;
    final image = widget.decoration.image != null ? null : defaultImage;

    widget.onChanged?.call(
        PrettyQrDecoration(image: image, shape: widget.decoration.shape));
  }

  void changeImagePosition(
    final PrettyQrDecorationImagePosition value,
  ) {
    final image = widget.decoration.image?.copyWith(position: value);
    widget.onChanged?.call(widget.decoration.copyWith(image: image));
  }
}
