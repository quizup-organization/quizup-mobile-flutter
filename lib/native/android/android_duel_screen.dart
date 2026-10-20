import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';

class AndroidDuelScreen extends StatefulWidget {
  const AndroidDuelScreen({super.key, required this.fixture});

  final DuelFixture fixture;

  @override
  State<AndroidDuelScreen> createState() => _AndroidDuelScreenState();
}

class _AndroidDuelScreenState extends State<AndroidDuelScreen> {
  int _questionIndex = 0;
  int? _selectedIndex;
  int _score = 0;

  DuelQuestion get _question => widget.fixture.questions[_questionIndex];

  bool get _isLast => _questionIndex == widget.fixture.questions.length - 1;

  void _select(int index) {
    if (_selectedIndex != null) {
      return;
    }
    final correct = index == _question.correctIndex;
    setState(() {
      _selectedIndex = index;
      if (correct) {
        _score += 100;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          correct ? 'Bonne réponse' : 'Ce n’est pas la bonne réponse.',
        ),
      ),
    );
  }

  void _next() {
    if (_selectedIndex == null) {
      return;
    }
    if (_isLast) {
      _showResult();
      return;
    }
    setState(() {
      _questionIndex += 1;
      _selectedIndex = null;
    });
  }

  void _replay() {
    setState(() {
      _questionIndex = 0;
      _selectedIndex = null;
      _score = 0;
    });
  }

  Future<void> _showResult() {
    final win = _score > widget.fixture.opponent.score;
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(win ? 'Victoire' : 'Bien joué'),
          content: Text(
            'Toi $_score — ${widget.fixture.opponent.name} '
            '${widget.fixture.opponent.score}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _replay();
              },
              child: const Text('Rejouer'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Retour'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question ${_questionIndex + 1} / '
          '${widget.fixture.questions.length}',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Chip(label: Text('$_score pts')),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.asset(
            _question.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _question.text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              value: (_questionIndex + 1) /
                  widget.fixture.questions.length,
            ),
          ),
          RadioGroup<int>(
            groupValue: _selectedIndex,
            onChanged: (value) {
              if (_selectedIndex == null && value != null) {
                _select(value);
              }
            },
            child: Column(
              children: [
                for (var index = 0;
                    index < _question.answers.length;
                    index++)
                  RadioListTile<int>(
                    value: index,
                    title: Text(_question.answers[index]),
                  ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Toi'),
                  trailing: Text('$_score'),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(widget.fixture.opponent.name),
                  trailing: Text('${widget.fixture.opponent.score}'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _selectedIndex == null ? null : _next,
                child: Text(
                  _isLast ? 'Voir le résultat' : 'Question suivante',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
