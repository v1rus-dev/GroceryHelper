import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:groceryhelper/app/router/app_router.dart';
import 'package:groceryhelper/app/router/router_paths.dart';
import 'package:groceryhelper/shared/constants/app_assets.dart';
import 'package:groceryhelper/shared_ui/theme/app_theme_extension.dart';
import 'package:groceryhelper/shared_ui/widgets/buttons/app_fub_button.dart';
import 'package:groceryhelper/shared_ui/widgets/toolbars/app_main_toolbar.dart';

part 'baskets_di.dart';
part 'presentation/view/buskets_screen.dart';
part 'presentation/bloc/buskets_bloc.dart';
part 'presentation/bloc/buskets_event.dart';
part 'presentation/bloc/buskets_state.dart';
