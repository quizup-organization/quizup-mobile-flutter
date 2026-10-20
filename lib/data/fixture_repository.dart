import 'dart:convert';

import 'package:flutter/services.dart';

import 'models.dart';

class FixtureRepository {
  const FixtureRepository._();

  static Future<QuizupFixtures> load() async {
    final raw = await rootBundle.loadString('assets/fixtures/fixtures.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;

    final topics = (json['topics'] as List<dynamic>)
        .map((item) => Topic.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
    final byId = <String, Topic>{for (final topic in topics) topic.id: topic};

    List<Topic> resolve(List<dynamic> ids) {
      return ids
          .map((id) => byId[id as String])
          .whereType<Topic>()
          .toList(growable: false);
    }

    final homeJson = json['home'] as Map<String, dynamic>;
    final home = HomeFixture(
      trending: resolve(homeJson['trendingIds'] as List<dynamic>),
      followed: resolve(homeJson['followedIds'] as List<dynamic>),
      newTopics: resolve(homeJson['newIds'] as List<dynamic>),
    );

    final overviewJson = json['overview'] as Map<String, dynamic>;
    final overviewTopic = byId[overviewJson['topicId'] as String]!;
    final overview = TopicOverview(
      topic: overviewTopic,
      stats: TopicStats.fromJson(
        overviewJson['stats'] as Map<String, dynamic>,
      ),
      mastery: Mastery.fromJson(
        overviewJson['mastery'] as Map<String, dynamic>,
      ),
      leaderboard: (overviewJson['leaderboard'] as List<dynamic>)
          .map((item) => LeaderboardEntry.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );

    final duelJson = json['duel'] as Map<String, dynamic>;
    final duel = DuelFixture(
      topic: byId[duelJson['topicId'] as String]!,
      opponent: DuelOpponent.fromJson(
        duelJson['opponent'] as Map<String, dynamic>,
      ),
      questions: (duelJson['questions'] as List<dynamic>)
          .map((item) => DuelQuestion.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );

    return QuizupFixtures(
      topics: topics,
      home: home,
      overview: overview,
      duel: duel,
    );
  }
}
