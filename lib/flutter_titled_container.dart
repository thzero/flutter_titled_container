import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum TextAlignTitledContainer { left, center, right }

class TitledContainer extends SingleChildRenderObjectWidget {
  const TitledContainer({
    Key? key,
    required Widget child,
    titleColor,
    required this.title,
    textAlign,
    fontFamily,
    fontSize,
    fontWeight,
    backgroundColor,
  })  : fontFamily = fontFamily ?? null,
        fontSize = fontSize ?? 14.0,
        fontWeight = fontWeight ?? FontWeight.normal,
        titleColor = titleColor ?? const Color.fromRGBO(0, 0, 0, 1.0),
        textAlign = textAlign ?? TextAlignTitledContainer.left,
        backgroundColor = backgroundColor ?? const Color.fromRGBO(255, 255, 255, 1.0),
        super(key: key, child: child);

  final Color titleColor;
  final Color backgroundColor;
  final String title;
  final TextAlignTitledContainer textAlign;
  final String? fontFamily;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTitledContainer(
      titleColor: titleColor,
      title: title,
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      backgroundColor: backgroundColor,
      textAlign: textAlign,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderTitledContainer renderObject) {
    renderObject.titleColor = titleColor;
    renderObject.backgroundColor = backgroundColor;
    renderObject.title = title;
    renderObject.fontFamily = fontFamily;
    renderObject.fontSize = fontSize;
    renderObject.fontWeight = fontWeight;
    renderObject.textAlign = textAlign;
  }
}

class RenderTitledContainer extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  RenderTitledContainer({
    required Color titleColor,
    required String title,
    required String? fontFamily,
    required double fontSize,
    required FontWeight fontWeight,
    required Color backgroundColor,
    required TextAlignTitledContainer textAlign,
  })  : _titleColor = titleColor,
        _title = title,
        _textAlign = textAlign,
        _backgroundColor = backgroundColor,
        _fontFamily = fontFamily,
        _fontSize = fontSize,
        _fontWeight = fontWeight;

  Color get titleColor => _titleColor;
  Color _titleColor;
  set titleColor(Color value) {
    if (_titleColor == value) return;
    _titleColor = value;
    markNeedsPaint();
  }

  Color get backgroundColor => _backgroundColor;
  Color _backgroundColor;
  set backgroundColor(Color value) {
    if (_backgroundColor == value) return;
    _backgroundColor = value;
    markNeedsPaint();
  }

  String get title => _title;
  String _title;
  set title(String value) {
    if (_title == value) return;
    _title = value;
    markNeedsPaint();
  }

  TextAlignTitledContainer get textAlign => _textAlign;
  TextAlignTitledContainer _textAlign;
  set textAlign(TextAlignTitledContainer value) {
    if (_textAlign == value) return;
    _textAlign = value;
    markNeedsPaint();
  }

  String? get fontFamily => _fontFamily;
  String? _fontFamily;
  set fontFamily(String? value) {
    if (_fontFamily == value) return;
    _fontFamily = value;
    markNeedsPaint();
  }

  double get fontSize => _fontSize;
  double _fontSize;
  set fontSize(double value) {
    if (_fontSize == value) return;
    _fontSize = value;
    markNeedsPaint();
  }

  FontWeight get fontWeight => _fontWeight;
  FontWeight _fontWeight;
  set fontWeight(FontWeight value) {
    if (_fontWeight == value) return;
    _fontWeight = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    if (child == null) {
      size = constraints.smallest;
    } else {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(Size(child!.size.width, child!.size.height));
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);

      final canvas = context.canvas;
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      final textSpan = TextSpan(
        text: ' $title ',
        style: TextStyle(
          color: titleColor,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: 1.0,
          backgroundColor: backgroundColor,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      final TextPainter txtPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      txtPainter.layout(minWidth: 0, maxWidth: double.infinity);
      double xPos = 10.0;
      switch (textAlign) {
        case TextAlignTitledContainer.center:
          xPos = (size.width - txtPainter.size.width) / 2.0;
          break;
        case TextAlignTitledContainer.right:
          xPos = (size.width - txtPainter.size.width - 10);
          break;
        default:
          xPos = 10.0;
      }
      final titleOffset = Offset(xPos, -fontSize / 2);
      textPainter.paint(canvas, titleOffset);

      canvas.restore();
    }
  }

  @override
  @protected
  bool get alwaysNeedsCompositing => true;
}
