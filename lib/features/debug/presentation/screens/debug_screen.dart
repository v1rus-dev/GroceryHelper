import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_colors.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Screen'),
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовки
            Text('Заголовки', style: AppTextStyles.headline1),
            const SizedBox(height: 8),
            Text('Подзаголовок', style: AppTextStyles.headline2),
            const SizedBox(height: 16),

            // Обычный текст
            Text('Обычный текст', style: AppTextStyles.body),
            const SizedBox(height: 16),

            // Кнопки
            Text('Кнопки', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () {}, child: const Text('Primary Button')),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.navigation),
              child: const Text('Navigation Button'),
            ),
            const SizedBox(height: 16),

            // Цвета
            Text('Цвета', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            _buildColorBox('Primary', AppColors.primary),
            _buildColorBox('Primary Light', AppColors.primaryLight),
            _buildColorBox('Primary Dark', AppColors.primaryDark),
            _buildColorBox('Navigation', AppColors.navigation),
            _buildColorBox('Background', AppColors.background),
            _buildColorBox('Accent', AppColors.accent),
            _buildColorBox('Error', AppColors.error),
            _buildColorBox('Text', AppColors.text),
            _buildColorBox('Secondary Text', AppColors.secondaryText),
            const SizedBox(height: 16),

            // Карточки
            Text('Карточки', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Заголовок карточки', style: AppTextStyles.headline2),
                    const SizedBox(height: 8),
                    Text('Содержимое карточки с обычным текстом', style: AppTextStyles.body),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Поля ввода
            Text('Поля ввода', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: 'Обычное поле', hintText: 'Введите текст'),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Поле с иконкой',
                hintText: 'Введите текст',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),

            // Списки
            Text('Списки', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.primaryLight, child: Text('${index + 1}')),
                  title: Text('Элемент ${index + 1}'),
                  subtitle: Text('Описание элемента ${index + 1}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
            ),
            const SizedBox(height: 16),

            // Чипы
            Text('Чипы', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: const Text('Чип 1')),
                Chip(
                  label: const Text('Чип 2'),
                  backgroundColor: AppColors.primaryLight,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                Chip(
                  label: const Text('Чип 3'),
                  backgroundColor: AppColors.navigation,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Прогресс
            Text('Прогресс', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: AppColors.primaryBackground,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
            ),
            const SizedBox(height: 8),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryLight)),
            const SizedBox(height: 16),

            // Переключатели
            Text('Переключатели', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            Switch(value: true, onChanged: (value) {}, activeColor: AppColors.primaryLight),
            const SizedBox(height: 8),
            Checkbox(value: true, onChanged: (value) {}, activeColor: AppColors.primaryLight),
            const SizedBox(height: 16),

            // Иконки
            Text('Иконки', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.home, color: AppColors.primaryLight, size: 32),
                const SizedBox(width: 16),
                Icon(Icons.shopping_cart, color: AppColors.navigation, size: 32),
                const SizedBox(width: 16),
                Icon(Icons.person, color: AppColors.accent, size: 32),
                const SizedBox(width: 16),
                Icon(Icons.error, color: AppColors.error, size: 32),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildColorBox(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '#${color.value.toRadixString(16).toUpperCase().substring(2)}',
            style: TextStyle(color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
