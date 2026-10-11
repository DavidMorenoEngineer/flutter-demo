import 'package:injectable/injectable.dart';

import '../../domain/entities/events_content.dart';

/// Static, deterministic content — no backend, matching the other showcase repos.
abstract interface class EventsDataSource {
  Future<EventsContent> fetch();
}

@LazySingleton(as: EventsDataSource)
class EventsMockDataSource implements EventsDataSource {
  const EventsMockDataSource();

  @override
  Future<EventsContent> fetch() async => const EventsContent(
        states: [
          StateCount('Texas', 124),
          StateCount('North Carolina', 97),
          StateCount('Pennsylvania', 82),
          StateCount('New York', 72),
          StateCount('Illinois', 68),
          StateCount('Ohio', 66),
          StateCount('Virginia', 65),
        ],
        events: [
          CommunityEvent(
            title: 'From Intimidation to Implementation: Making AI Work for Your Small Business',
            host: 'SBA',
            when: 'Mon, Oct 5 · 6:00 PM',
            format: 'Online',
            cost: 'Cost not listed',
            state: 'Virginia',
          ),
          CommunityEvent(
            title: 'AI^2 for Main Street',
            host: 'Indiana SBDC',
            when: 'Tue, Oct 6',
            format: 'In person',
            cost: 'No cost',
            state: 'Ohio',
          ),
          CommunityEvent(
            title: 'AI Agents for Small Business: From Owner-Dependent to AI-Enabled',
            host: 'Pennsylvania SBDC',
            when: 'Tue, Oct 6',
            format: 'Online',
            cost: 'No cost',
            state: 'Pennsylvania',
          ),
          CommunityEvent(
            title: 'Funding Your First Year: Grants, Loans and Bootstrapping',
            host: 'Cape Fear Community College',
            when: 'Wed, Oct 7 · 12:00 PM',
            format: 'Livestream',
            cost: 'No cost',
            state: 'North Carolina',
          ),
          CommunityEvent(
            title: 'Pricing Your Product or Service With Confidence',
            host: 'Texas SBDC Network',
            when: 'Thu, Oct 8 · 10:00 AM',
            format: 'Online',
            cost: 'No cost',
            state: 'Texas',
          ),
          CommunityEvent(
            title: 'Founder Office Hours: Legal Basics for Week One',
            host: 'Chicago Founders Guild',
            when: 'Fri, Oct 9 · 4:30 PM',
            format: 'In person',
            cost: 'No cost',
            state: 'Illinois',
          ),
          CommunityEvent(
            title: 'Women in Business: Building Your Support System',
            host: 'Brooklyn Small Business Hub',
            when: 'Sat, Oct 10 · 9:00 AM',
            format: 'In person',
            cost: 'No cost',
            state: 'New York',
          ),
        ],
      );
}
