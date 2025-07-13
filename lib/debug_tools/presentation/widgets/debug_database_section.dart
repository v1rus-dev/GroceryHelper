import 'package:flutter/material.dart';
import 'package:groceryhelper/common_ui/theme/app_colors.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/app_primary_button.dart';
import 'package:groceryhelper/infrastructure/services/database_service.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';

class DebugDatabaseSection extends StatefulWidget {
  const DebugDatabaseSection({super.key});

  @override
  State<DebugDatabaseSection> createState() => _DebugDatabaseSectionState();
}

class _DebugDatabaseSectionState extends State<DebugDatabaseSection> {
  bool _isInitialized = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkInitializationStatus();
  }

  Future<void> _checkInitializationStatus() async {
    final databaseService = locator<DatabaseService>();
    final status = await databaseService.isDatabaseInitialized();
    setState(() {
      _isInitialized = status;
    });
  }

  Future<void> _initializeDatabase() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final databaseService = locator<DatabaseService>();
      await databaseService.initializeDatabase();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('База данных успешно инициализирована'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка инициализации: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        await _checkInitializationStatus();
      }
    }
  }

  Future<void> _reinitializeDatabase() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final databaseService = locator<DatabaseService>();
      await databaseService.reinitializeDatabase();

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('База данных переинициализирована'), backgroundColor: Colors.blue));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка переинициализации: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        await _checkInitializationStatus();
      }
    }
  }

  Future<void> _resetInitializationFlag() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final databaseService = locator<DatabaseService>();
      await databaseService.initializer.resetInitializationFlag();

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Флаг инициализации сброшен'), backgroundColor: Colors.orange));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка сброса флага: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        await _checkInitializationStatus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.storage, color: AppColors.primaryLight),
                const SizedBox(width: 8.0),
                const Text('База данных', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16.0),

            // Статус инициализации
            Row(
              children: [
                const Text('Статус инициализации: '),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: _isInitialized ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    _isInitialized ? 'Инициализирована' : 'Не инициализирована',
                    style: const TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Кнопки управления
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: [
                  if (!_isInitialized)
                    SizedBox(
                      width: double.infinity,
                      child: AppPrimaryButton(onPressed: _initializeDatabase, text: 'Инициализировать базу данных'),
                    ),

                  if (!_isInitialized) const SizedBox(height: 8.0),

                  SizedBox(
                    width: double.infinity,
                    child: AppPrimaryButton(
                      onPressed: _reinitializeDatabase,
                      text: 'Переинициализировать',
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 8.0),

                  SizedBox(
                    width: double.infinity,
                    child: AppPrimaryButton(
                      onPressed: _resetInitializationFlag,
                      text: 'Сбросить флаг инициализации',
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
