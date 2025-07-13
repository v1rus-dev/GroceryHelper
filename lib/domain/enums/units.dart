enum Units { kg, g, l, ml, pc, pack, box, pouch, can, bottle, packet }

extension UnitsExtension on Units {
  String get shortName => switch (this) {
    Units.kg => 'кг.',
    Units.g => 'гр.',
    Units.l => 'л.',
    Units.ml => 'мл.',
    Units.pc => 'шт.',
    Units.pack => 'уп.',
    Units.box => 'кр.',
    Units.pouch => 'пач.',
    Units.can => 'б.',
    Units.bottle => 'бут.',
    Units.packet => 'пак.',
  };

  String get displayName => switch (this) {
    Units.kg => 'Килограмм',
    Units.g => 'Грамм',
    Units.l => 'Литр',
    Units.ml => 'Миллилитр',
    Units.pc => 'Штука',
    Units.pack => 'Упаковка',
    Units.box => 'Коробка',
    Units.pouch => 'Пачка',
    Units.can => 'Банка',
    Units.bottle => 'Бутылка',
    Units.packet => 'Пакет',
  };
}
