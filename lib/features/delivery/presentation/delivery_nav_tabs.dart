import 'package:iconsax/iconsax.dart';
import 'package:homemade/core/common/widgets/navigation/nav_tab.dart';
import 'package:homemade/features/chat/presentation/screens/chat_list.dart';
import 'package:homemade/features/delivery/presentation/screens/delivery_home.dart';
import 'package:homemade/features/settings/presentation/screens/settings.dart';

const List<NavTab> kDeliveryNavTabs = [
  NavTab(icon: Iconsax.home, label: 'Accueil', screen: DeliveryHomeScreen()),
  NavTab(icon: Iconsax.message, label: 'Messages', screen: ChatListScreen()),
  NavTab(icon: Iconsax.user, label: 'Profil', screen: SettingsScreen()),
];
