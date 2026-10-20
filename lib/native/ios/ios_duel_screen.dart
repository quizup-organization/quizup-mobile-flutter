import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';

class IosDuelScreen extends StatefulWidget {
  const IosDuelScreen({super.key, required this.fixture});

  final DuelFixture fixture;

  @override
  State<IosDuelScreen> createState() => _IosDuelScreenState();
}

class _IosDuelScreenState extends State<IosDuelScreen> {
  int _questionIndex = 0;
  int? _selectedIndex;
  int _score = 0;

  DuelQuestion get _question => widget.fixture.questions[_questionIndex];

  bool get _isLast => _questionIndex == widget.fixture.questions.length - 1;

  void _select(int index) {
    if (_selectedIndex != null) {
      return;
    }
    setState(() {
      _selectedIndex = index;
      if (index == _question.correctIndex) {
        _score += 100;
      }
    });
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

  Widget? _trailingFor(int index) {
    if (_selectedIndex == null) {
      return null;
    }
    if (index == _question.correctIndex) {
      return const Icon(
        cupertino.CupertinoIcons.check_mark,
        color: cupertino.CupertinoColors.activeGreen,
      );
    }
    if (_selectedIndex == index) {
      return const Icon(
        cupertino.CupertinoIcons.xmark,
        color: cupertino.CupertinoColors.systemRed,
      );
    }
    return null;
  }

  Future<void> _showResult() {
    final win = _score > widget.fixture.opponent.score;
    return cupertino.showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) {
        return cupertino.CupertinoAlertDialog(
          title: Text(win ? 'Victoire' : 'Bien joué'),
          content: Text(
            'Toi $_score — ${widget.fixture.opponent.name} '
            '${widget.fixture.opponent.score}',
          ),
          actions: [
            cupertino.CupertinoDialogAction(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _replay();
              },
              child: const Text('Rejouer'),
            ),
            cupertino.CupertinoDialogAction(
              isDefaultAction: true,
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
    return cupertino.CupertinoPageScaffold(
      navigationBar: cupertino.CupertinoNavigationBar(
        middle: Text(
          'Question ${_questionIndex + 1} / '
          '${widget.fixture.questions.length}',
        ),
        trailing: cupertino.CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Quitter'),
        ),
      ),
      child: ListView(
        children: [
          Image.asset(
            _question.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          cupertino.CupertinoListSection.insetGrouped(
            header: Text(_question.text),
            children: [
              for (var index = 0; index < _question.answers.length; index++)
                cupertino.CupertinoListTile(
                  title: Text(_question.answers[index]),
                  trailing: _trailingFor(index),
                  onTap: _selectedIndex == null
                      ? () => _select(index)
                      : null,
                ),
            ],
          ),
          cupertino.CupertinoListSection.insetGrouped(
            header: const Text('Score'),
            children: [
              cupertino.CupertinoListTile(
                title: const Text('Toi'),
                trailing: Text('$_score'),
              ),
              cupertino.CupertinoListTile(
                title: Text(widget.fixture.opponent.name),
                trailing: Text('${widget.fixture.opponent.score}'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: cupertino.CupertinoButton.filled(
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
