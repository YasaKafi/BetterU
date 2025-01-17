import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../common/theme.dart';


class ChatBubbleTooltipShape extends SfTooltipShape {
  @override
  void paint(PaintingContext context,
      Offset thumbCenter,
      Offset offset,
      TextPainter textPainter, {
        required Animation<double> animation,
        required Paint paint,
        required RenderBox parentBox,
        required SfSliderThemeData sliderThemeData,
        required Rect trackRect,
      }) {
    final Paint bubblePaint = Paint()
      ..color = primaryColor // Warna balon tooltip
      ..style = PaintingStyle.fill;

    // Dimensi balon tooltip
    const double bubbleWidth = 80;
    const double bubbleHeight = 40;
    const double arrowHeight = 10;
    const double arrowWidth = 20;

    // Membuat rect untuk balon tooltip
    final RRect bubbleRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(
            thumbCenter.dx, thumbCenter.dy - bubbleHeight / 2 - arrowHeight),
        width: bubbleWidth,
        height: bubbleHeight,
      ),
      const Radius.circular(8.0), // Radius sudut balon
    );

    // Membuat path untuk balon dengan ekor segitiga (balon chat)
    final Path bubblePath = Path()
      ..addRRect(bubbleRect)
      ..moveTo(
          thumbCenter.dx - arrowWidth / 2, thumbCenter.dy - bubbleHeight / 2)
      ..lineTo(thumbCenter.dx + arrowWidth / 2,
          thumbCenter.dy - bubbleHeight / 2)..lineTo(
          thumbCenter.dx, thumbCenter.dy)
      ..close();

    // Gambar balon tooltip
    context.canvas.drawPath(bubblePath, bubblePaint);

    // **Mengatur Teks Kustom**
    // Format nilai dengan tambahan "ml"
    final String formattedText = "${textPainter.text!.toPlainText()} ml";

    // Update teks dalam `TextPainter`
    final TextPainter formattedTextPainter = TextPainter(
      text: TextSpan(
        text: formattedText,
        style: txtPrimarySubTitle.copyWith(
          color: baseColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )
      ..layout();

    // Mengatur posisi teks di tengah balon
    final Offset textOffset = Offset(
      thumbCenter.dx - (formattedTextPainter.width / 2),
      thumbCenter.dy - bubbleHeight / 2 - arrowHeight -
          (formattedTextPainter.height / 2),
    );

    // Gambar teks tooltip
    formattedTextPainter.paint(context.canvas, textOffset);
  }
}

class CustomDividerShape extends SfDividerShape {
  @override
  void paint(PaintingContext context, Offset center, Offset? startThumbCenter,
      Offset? endThumbCenter, Offset? thumbCenter,
      {dynamic currentValue,
        SfRangeValues? currentValues,
        required Animation<double> enableAnimation,
        required Paint? paint,
        required RenderBox parentBox,
        required TextDirection textDirection,
        required SfSliderThemeData themeData}) {
    // Menentukan apakah divider sudah dilewati oleh slider (startThumbCenter atau endThumbCenter)
    bool isStepPassed = (startThumbCenter?.dx ?? 0) > center.dx;

    // Kustomisasi warna divider dengan opacity yang lebih rendah jika belum dilewati slider
    final Paint dividerPaint = Paint()
      ..color = primaryColor.withOpacity(
          isStepPassed ? 1.0 : 0.4) // Opacity 0.4 jika belum dilewati
      ..style = PaintingStyle.fill;

    // Outer circle untuk step
    context.canvas.drawCircle(center, 7, dividerPaint);

    // Inner circle berwarna putih
    final Paint innerCirclePaint = Paint()
      ..color = Colors.white;
    context.canvas.drawCircle(center, 5, innerCirclePaint);
  }
}

// Custom Thumb Shape (untuk kepala slider)
class CustomThumbShape extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox? child,
        dynamic currentValue,
        SfRangeValues? currentValues,
        required Animation<double> enableAnimation,
        required Paint? paint,
        required RenderBox parentBox,
        required TextDirection textDirection,
        required SfSliderThemeData themeData,
        SfThumb? thumb}) {
    final Paint thumbPaint = paint ?? Paint()
      ..color = primaryColor;

    final double radius = 8;

    // Ukuran lebih besar untuk kepala slider yang bergerak
    double scale = 1.0;
    if (enableAnimation.value > 0) {
      // Saat slider bergerak, beri efek scale (lebih besar)
      scale = 1 + (enableAnimation.value * 0.3); // Penyesuaian besar scale
    }

    // Outer circle dengan ukuran yang lebih besar saat bergerak
    context.canvas.drawCircle(center, radius * scale, thumbPaint);

    // Inner circle berwarna putih untuk semua (termasuk divider dan step)
    final Paint innerCirclePaint = Paint()
      ..color = Colors.white;
    context.canvas.drawCircle(center, radius * scale * 0.4, innerCirclePaint);
  }
}