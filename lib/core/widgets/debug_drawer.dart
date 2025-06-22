import 'package:groceryhelper/core/navigation/app_router.dart';
import 'package:groceryhelper/core/navigation/router_paths.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:groceryhelper/core/services/talker_service.dart';

class DebugDrawer extends StatefulWidget {
  const DebugDrawer({super.key});

  @override
  State<DebugDrawer> createState() => _DebugDrawerState();
}

class _DebugDrawerState extends State<DebugDrawer> {
  double _position = 100.0; // Начальная позиция по Y
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Показываем только в debug режиме
    if (!kDebugMode) return const SizedBox.shrink();

    return Positioned(
      right: 0,
      top: _position,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta.dy;
            // Ограничиваем движение в пределах экрана
            _position = _position.clamp(
              0.0,
              MediaQuery.of(context).size.height - 60.0,
            );
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isExpanded ? 200 : 40,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_isExpanded ? 12 : 20),
              bottomLeft: Radius.circular(_isExpanded ? 12 : 20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(-2, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              onLongPress: () {
                appRouter.push(RouterPaths.talker);
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_isExpanded ? 12 : 20),
                bottomLeft: Radius.circular(_isExpanded ? 12 : 20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Иконка
                  Container(
                    width: 40,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade700,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_isExpanded ? 12 : 20),
                        bottomLeft: Radius.circular(_isExpanded ? 12 : 20),
                      ),
                    ),
                    child: Icon(
                      _isExpanded ? Icons.chevron_right : Icons.bug_report,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  // Текст (показывается только при развернутом состоянии)
                  if (_isExpanded)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  TalkerScreen(talker: TalkerService.instance),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Debug',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
