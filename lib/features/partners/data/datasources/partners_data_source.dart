import 'package:injectable/injectable.dart';

import '../../domain/entities/partners_content.dart';

/// Static, deterministic content — no backend, matching the other showcase repos.
abstract interface class PartnersDataSource {
  Future<PartnersContent> fetch();
}

@LazySingleton(as: PartnersDataSource)
class PartnersMockDataSource implements PartnersDataSource {
  const PartnersMockDataSource();

  @override
  Future<PartnersContent> fetch() async => const PartnersContent(
        headline: 'Collaboration is what builds community.',
        subheadline:
            'Three ways to work with us, each with a different shape. Pick the one that fits and we will take it from there.',
        companyCount: 'Forty-three companies',
        tracks: [
          PartnerTrack(
            title: 'Affiliates',
            headline: 'You get discovered by people who need exactly what you do.',
            bullets: [
              "Your business surfaces in Kix suggestions when a member's situation matches what you offer",
              'An exclusive member discount listed in the community classifieds',
              'Referral tracking, so you see what the relationship is actually worth',
              'No cost to join and no exclusivity',
            ],
            cta: 'Talk to us about becoming an affiliate',
          ),
          PartnerTrack(
            title: 'Partners',
            headline: 'You help build the thing, and the thing carries your name.',
            bullets: [
              'Co-created workshops, trainings and content, credited to you',
              'Your offering integrated into the member journey rather than bolted on',
              'A say in long-term programmes for entrepreneur education and access',
              'Named on this page and in the product',
            ],
            cta: 'Talk to us about becoming a partner',
          ),
          PartnerTrack(
            title: 'Sponsors',
            headline: 'You fund the work and get seen doing it.',
            bullets: [
              'Fund an event, a programme or a campaign and put your name on it',
              'In-app and on-site placement where members are already looking',
              'Co-branded experiences built with our team',
              'Reporting on reach, not vanity numbers',
            ],
            cta: 'Talk to us about becoming a sponsor',
          ),
        ],
        national: [
          'Amplemarket', 'Apollo', 'BILL', 'Beehiiv', 'Capsule', 'Carta', 'Clearco',
          'ElevenLabs', 'FreshBooks', 'Google Workspace', 'Gusto', 'Housecall Pro',
          'Make', 'Printify', 'Shopify', 'Trainual', 'ZenBusiness', 'monday.com',
        ],
        partners: ['Right to Start', 'Second Order Studio', 'Self Help Credit Union', 'Zapier'],
        local: ['BlueTone Media', 'Bridge to Wilmington', 'Cape Fear Community College', 'K Starr Coaching', 'UNCW'],
      );
}
