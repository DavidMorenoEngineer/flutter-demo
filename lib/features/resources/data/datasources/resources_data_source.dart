import 'package:injectable/injectable.dart';

import '../../domain/entities/resource_item.dart';

/// Static, deterministic content — no backend, matching the other showcase repos.
abstract interface class ResourcesDataSource {
  Future<List<ResourceItem>> fetch();
}

@LazySingleton(as: ResourcesDataSource)
class ResourcesMockDataSource implements ResourcesDataSource {
  const ResourcesMockDataSource();

  @override
  Future<List<ResourceItem>> fetch() async => const [
        ResourceItem(category: 'Education', title: 'We Didn\'t Get the Time Back. Now AI Is Making the Same Promise.'),
        ResourceItem(category: 'Community', title: 'We\'re in a Trust Recession. What Would It Take to Rebuild It?'),
        ResourceItem(category: 'Education', title: 'America Has an Entrepreneurship Gap. It Isn\'t an Information Gap.'),
        ResourceItem(category: 'Education', title: 'How to Start a Business: A Step-by-Step Guide'),
        ResourceItem(category: 'Funding', title: 'How Much Does It Cost to Start a Small Business?'),
        ResourceItem(category: 'Education', title: 'Small Business Survival Rates: What the Data Says'),
        ResourceItem(category: 'Education', title: 'How to Price Your Product or Service'),
        ResourceItem(category: 'Community', title: 'Free Government Resources for Small Business Owners'),
        ResourceItem(category: 'Education', title: 'How to Calculate Your Breakeven Point'),
        ResourceItem(category: 'Legal', title: 'Sole Proprietorship vs LLC: Which to Choose'),
        ResourceItem(category: 'Community', title: 'How to Build a Support System as a Founder'),
        ResourceItem(category: 'Guides', title: 'Free Help and Market Data', isTool: true),
        ResourceItem(category: 'Tools', title: 'Free Business Calculators', isTool: true),
        ResourceItem(category: 'Guides', title: 'The SideKix Business Glossary', isTool: true),
        ResourceItem(category: 'Education', title: 'The Business Startup Checklist: From Idea to First Customer'),
        ResourceItem(category: 'Education', title: 'How to Build a Business While Working a 9-to-5'),
        ResourceItem(category: 'Education', title: 'How to Start a Business With No Money'),
        ResourceItem(category: 'Mindset', title: 'How to Manage Being Overwhelmed As A Founder'),
        ResourceItem(category: 'Mindset', title: 'How to Stay Motivated While Building a Business'),
        ResourceItem(category: 'Guides', title: 'Taking Small Actions When You Feel Stuck'),
        ResourceItem(category: 'Templates', title: 'Business Roadmap Template'),
        ResourceItem(category: 'Templates', title: '90-Day Goal-Setting Template'),
        ResourceItem(category: 'Templates', title: 'Weekly Business Check-In Template'),
        ResourceItem(category: 'Advisors', title: 'Business Advisor vs Coach vs Consultant: Which Do You Need?'),
        ResourceItem(category: 'Tools', title: 'Best AI Tools for Small Business Owners'),
        ResourceItem(category: 'Funding', title: 'How to Get Funding for Your Business Idea'),
        ResourceItem(category: 'Mentorship', title: 'How to Find a Business Mentor (And Actually Get One)'),
        ResourceItem(category: 'News', title: 'Popular Small Business Ideas in 2026'),
      ];
}
