import 'package:flutter/material.dart';

import '../../advisors/presentation/pages/advisors_page.dart';
import '../../events/presentation/pages/events_page.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../how_it_works/presentation/pages/how_it_works_page.dart';
import '../../membership/presentation/pages/membership_page.dart';
import '../../partners/presentation/pages/partners_page.dart';
import '../../resources/presentation/pages/resources_page.dart';

/// The seven top-nav items of the website — mirrored 1:1 in the bottom bar.
enum AppDestination {
  home('Home', Icons.home_outlined, Icons.home_rounded, HomePage.new),
  howItWorks('How it works', Icons.alt_route_outlined, Icons.alt_route_rounded, HowItWorksPage.new),
  membership('Membership', Icons.workspace_premium_outlined, Icons.workspace_premium_rounded, MembershipPage.new),
  advisors('Advisors', Icons.people_outline_rounded, Icons.people_rounded, AdvisorsPage.new),
  partners('Partners', Icons.handshake_outlined, Icons.handshake_rounded, PartnersPage.new),
  events('Events', Icons.event_outlined, Icons.event_rounded, EventsPage.new),
  resources('Resources', Icons.menu_book_outlined, Icons.menu_book_rounded, ResourcesPage.new);

  const AppDestination(this.label, this.icon, this.selectedIcon, this.pageBuilder);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget Function({Key? key}) pageBuilder;
}
