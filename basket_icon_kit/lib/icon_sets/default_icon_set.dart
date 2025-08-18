enum DefaultIconSet { bag, bag1, buy, card, display, drop, game, heart, miniBuy, moon, sun, wallet }

extension DefaultIconSetExtension on DefaultIconSet {
  String get name => switch (this) {
    DefaultIconSet.bag => 'default_bag',
    DefaultIconSet.bag1 => 'default_bag1',
    DefaultIconSet.buy => 'default_buy',
    DefaultIconSet.card => 'default_card',
    DefaultIconSet.display => 'default_display',
    DefaultIconSet.drop => 'default_drop',
    DefaultIconSet.game => 'default_game',
    DefaultIconSet.heart => 'default_heart',
    DefaultIconSet.miniBuy => 'default_mini_buy',
    DefaultIconSet.moon => 'default_moon',
    DefaultIconSet.sun => 'default_sun',
    DefaultIconSet.wallet => 'default_wallet',
  };

  int get id => switch (this) {
    DefaultIconSet.bag => 1,
    DefaultIconSet.bag1 => 2,
    DefaultIconSet.buy => 3,
    DefaultIconSet.card => 4,
    DefaultIconSet.display => 5,
    DefaultIconSet.drop => 6,
    DefaultIconSet.game => 7,
    DefaultIconSet.heart => 8,
    DefaultIconSet.miniBuy => 9,
    DefaultIconSet.moon => 10,
    DefaultIconSet.sun => 11,
    DefaultIconSet.wallet => 12,
  };

  String get path => switch (this) {
    DefaultIconSet.bag => 'assets/icons/default/ic_bag.svg',
    DefaultIconSet.bag1 => 'assets/icons/default/ic_bag_1.svg',
    DefaultIconSet.buy => 'assets/icons/default/ic_buy.svg',
    DefaultIconSet.card => 'assets/icons/default/ic_card.svg',
    DefaultIconSet.display => 'assets/icons/default/ic_display.svg',
    DefaultIconSet.drop => 'assets/icons/default/ic_drop.svg',
    DefaultIconSet.game => 'assets/icons/default/ic_game.svg',
    DefaultIconSet.heart => 'assets/icons/default/ic_heart.svg',
    DefaultIconSet.miniBuy => 'assets/icons/default/ic_mini_buy.svg',
    DefaultIconSet.moon => 'assets/icons/default/ic_moon.svg',
    DefaultIconSet.sun => 'assets/icons/default/ic_sun.svg',
    DefaultIconSet.wallet => 'assets/icons/default/ic_wallet.svg',
  };

  DefaultIconSet getById(int id) => switch (id) {
    1 => DefaultIconSet.bag,
    2 => DefaultIconSet.bag1,
    3 => DefaultIconSet.buy,
    4 => DefaultIconSet.card,
    5 => DefaultIconSet.display,
    6 => DefaultIconSet.drop,
    7 => DefaultIconSet.game,
    8 => DefaultIconSet.heart,
    9 => DefaultIconSet.miniBuy,
    10 => DefaultIconSet.moon,
    11 => DefaultIconSet.sun,
    12 => DefaultIconSet.wallet,
    _ => throw Exception('Invalid id: $id'),
  };
}
