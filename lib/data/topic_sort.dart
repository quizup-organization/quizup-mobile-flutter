import 'models.dart';

enum TopicSort {
  popular('Populaires'),
  alpha('A-Z'),
  recent('Récents');

  const TopicSort(this.label);

  final String label;
}

List<Topic> applyTopicSort(List<Topic> topics, TopicSort sort) {
  final result = List<Topic>.of(topics);
  final comparator = switch (sort) {
    TopicSort.popular => (Topic a, Topic b) =>
      b.followers.compareTo(a.followers),
    TopicSort.alpha => (Topic a, Topic b) => a.name.compareTo(b.name),
    TopicSort.recent => (Topic a, Topic b) =>
      a.recentRank.compareTo(b.recentRank),
  };
  result.sort(comparator);
  return result;
}
