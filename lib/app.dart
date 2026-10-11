import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/theme/sx_theme.dart';
import 'features/advisors/presentation/cubit/advisors_cubit.dart';
import 'features/events/presentation/cubit/event_filter_cubit.dart';
import 'features/events/presentation/cubit/events_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/how_it_works/presentation/cubit/how_it_works_cubit.dart';
import 'features/kix_chat/presentation/bloc/kix_chat_bloc.dart';
import 'features/membership/presentation/cubit/billing_cubit.dart';
import 'features/membership/presentation/cubit/membership_cubit.dart';
import 'features/partners/presentation/cubit/partners_cubit.dart';
import 'features/resources/presentation/cubit/resource_filter_cubit.dart';
import 'features/resources/presentation/cubit/resources_cubit.dart';
import 'features/shell/presentation/navigation_cubit.dart';
import 'features/shell/presentation/pages/app_shell.dart';

class SideKixDemoApp extends StatelessWidget {
  const SideKixDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Providers sit above MaterialApp so pushed routes (the full-screen Kix
    // chat) can reach them.
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<NavigationCubit>()..selectByName(Uri.base.queryParameters['tab'])),
        BlocProvider(create: (_) => getIt<HomeCubit>()..load()),
        BlocProvider(create: (_) => getIt<HowItWorksCubit>()..load()),
        BlocProvider(create: (_) => getIt<MembershipCubit>()..load()),
        BlocProvider(create: (_) => getIt<BillingCubit>()),
        BlocProvider(create: (_) => getIt<AdvisorsCubit>()..load()),
        BlocProvider(create: (_) => getIt<PartnersCubit>()..load()),
        BlocProvider(create: (_) => getIt<EventsCubit>()..load()),
        BlocProvider(create: (_) => getIt<EventFilterCubit>()),
        BlocProvider(create: (_) => getIt<ResourcesCubit>()..load()),
        BlocProvider(create: (_) => getIt<ResourceFilterCubit>()),
        BlocProvider.value(value: getIt<KixChatBloc>()),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: MaterialApp(
          title: 'SideKix — Flutter demo',
          debugShowCheckedModeBanner: false,
          theme: SxTheme.dark,
          home: const AppShell(),
        ),
      ),
    );
  }
}
