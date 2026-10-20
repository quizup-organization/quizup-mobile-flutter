import 'package:material_ui/material_ui.dart';

class Topic {
  const Topic({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.banner,
    required this.colorHex,
    required this.description,
    required this.followers,
    required this.games,
    required this.recentRank,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      banner: json['banner'] as String,
      colorHex: json['color'] as String,
      description: json['description'] as String,
      followers: json['followers'] as int,
      games: json['games'] as int,
      recentRank: json['recentRank'] as int,
    );
  }

  final String id;
  final String name;
  final String category;
  final String image;
  final String banner;
  final String colorHex;
  final String description;
  final int followers;
  final int games;
  final int recentRank;

  Color get color {
    final hex = colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) {
      return '?';
    }
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class HomeFixture {
  const HomeFixture({
    required this.trending,
    required this.followed,
    required this.newTopics,
  });

  final List<Topic> trending;
  final List<Topic> followed;
  final List<Topic> newTopics;
}

class TopicStats {
  const TopicStats({
    required this.followers,
    required this.games,
    required this.myRank,
  });

  factory TopicStats.fromJson(Map<String, dynamic> json) {
    return TopicStats(
      followers: json['followers'] as int,
      games: json['games'] as int,
      myRank: json['myRank'] as int,
    );
  }

  final int followers;
  final int games;
  final int myRank;
}

class Mastery {
  const Mastery({
    required this.grade,
    required this.progress,
    required this.remainingXp,
    required this.nextGrade,
  });

  factory Mastery.fromJson(Map<String, dynamic> json) {
    return Mastery(
      grade: json['grade'] as String,
      progress: (json['progress'] as num).toDouble(),
      remainingXp: json['remainingXp'] as int,
      nextGrade: json['nextGrade'] as String,
    );
  }

  final String grade;
  final double progress;
  final int remainingXp;
  final String nextGrade;
}

class LeaderboardEntry {
  const LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.level,
    required this.xp,
    required this.colorHex,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'] as int,
      name: json['name'] as String,
      level: json['level'] as int,
      xp: json['xp'] as int,
      colorHex: json['color'] as String,
    );
  }

  final int rank;
  final String name;
  final int level;
  final int xp;
  final String colorHex;

  Color get color {
    final hex = colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  String get initials => name.substring(0, 1).toUpperCase();
}

class TopicOverview {
  const TopicOverview({
    required this.topic,
    required this.stats,
    required this.mastery,
    required this.leaderboard,
  });

  final Topic topic;
  final TopicStats stats;
  final Mastery mastery;
  final List<LeaderboardEntry> leaderboard;
}

class DuelOpponent {
  const DuelOpponent({
    required this.name,
    required this.level,
    required this.score,
    required this.colorHex,
  });

  factory DuelOpponent.fromJson(Map<String, dynamic> json) {
    return DuelOpponent(
      name: json['name'] as String,
      level: json['level'] as int,
      score: json['score'] as int,
      colorHex: json['color'] as String,
    );
  }

  final String name;
  final int level;
  final int score;
  final String colorHex;

  Color get color {
    final hex = colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  String get initials => name.substring(0, 1).toUpperCase();
}

class DuelQuestion {
  const DuelQuestion({
    required this.text,
    required this.image,
    required this.answers,
    required this.correctIndex,
  });

  factory DuelQuestion.fromJson(Map<String, dynamic> json) {
    return DuelQuestion(
      text: json['text'] as String,
      image: json['image'] as String,
      answers: (json['answers'] as List<dynamic>).cast<String>(),
      correctIndex: json['correctIndex'] as int,
    );
  }

  final String text;
  final String image;
  final List<String> answers;
  final int correctIndex;
}

class DuelFixture {
  const DuelFixture({
    required this.topic,
    required this.opponent,
    required this.questions,
  });

  final Topic topic;
  final DuelOpponent opponent;
  final List<DuelQuestion> questions;
}

class QuizupFixtures {
  const QuizupFixtures({
    required this.topics,
    required this.home,
    required this.overview,
    required this.duel,
  });

  final List<Topic> topics;
  final HomeFixture home;
  final TopicOverview overview;
  final DuelFixture duel;

  Topic topicById(String id) {
    return topics.firstWhere((topic) => topic.id == id);
  }
}
