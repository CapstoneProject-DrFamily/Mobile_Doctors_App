import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/enums/processTimeline.dart';
import 'package:mobile_doctors_apps/helper/common.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:timelines/timelines.dart';

Container timelineProcess(
    BuildContext contextC, int _processIndex, TimeLineViewModel model) {
  return Container(
    height: 150,
    child: Timeline.tileBuilder(
        theme: TimelineThemeData(
            direction: Axis.horizontal,
            connectorTheme: ConnectorThemeData(space: 30, thickness: 5)),
        builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemExtentBuilder: (contextD, __) =>
                MediaQuery.of(contextD).size.width /
                ProcessTimeline.values.length,
            oppositeContentsBuilder: (contextE, index) {
              return Material(
                color: Colors.transparent,
                child: Container(
                  child: InkWell(
                    onTap: () {
                      if (index <= model.index) {
                        model.changeIndex(index);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Image.asset(
                        'assets/images/time_line_${index + 1}.png',
                        width: 200,
                      ),
                    ),
                  ),
                ),
              );
            },
            contentsBuilder: (contextF, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  ProcessTimeline.values[index].toString().split(".").last,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Common.getColor(index, _processIndex),
                  ),
                ),
              );
            },
            indicatorBuilder: (contextI, index) {
              var color;
              var child;
              if (index == _processIndex) {
                color = Common.inProgressColor;
                child = Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                    )

                    //     CircularProgressIndicator(
                    //   strokeWidth: 3.0,
                    //   valueColor: AlwaysStoppedAnimation(Colors.white),
                    // ),
                    );
              } else if (index < model.index) {
                color = Common.completeColor;
                child = Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 25.0,
                );
              } else {
                color = Common.todoColor;
              }

              if (index <= _processIndex) {
                return Stack(
                  children: [
                    CustomPaint(
                      size: Size(30.0, 30.0),
                      painter: _BezierPainter(
                        color: color,
                        drawStart: index > 0,
                        drawEnd: index < _processIndex,
                      ),
                    ),
                    DotIndicator(
                      size: 30.0,
                      color: color,
                      child: child,
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    CustomPaint(
                      size: Size(15.0, 15.0),
                      painter: _BezierPainter(
                        color: color,
                        drawEnd: index < ProcessTimeline.values.length - 1,
                      ),
                    ),
                    OutlinedDotIndicator(
                      borderWidth: 4.0,
                      color: color,
                    ),
                  ],
                );
              }
            },
            connectorBuilder: (contextM, index, type) {
              if (index > 0) {
                if (index == _processIndex) {
                  final prevColor = Common.getColor(index - 1, _processIndex);
                  final color = Common.getColor(index, _processIndex);
                  var gradientColors;
                  if (type == ConnectorType.start) {
                    gradientColors = [Color.lerp(prevColor, color, 0.5), color];
                  } else {
                    gradientColors = [
                      prevColor,
                      Color.lerp(prevColor, color, 0.5)
                    ];
                  }
                  return DecoratedLineConnector(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                      ),
                    ),
                  );
                } else {
                  return SolidLineConnector(
                    color: Common.getColor(index, model.index),
                  );
                }
              } else {
                return null;
              }
            },
            itemCount: ProcessTimeline.values.length)),
  );
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    @required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
