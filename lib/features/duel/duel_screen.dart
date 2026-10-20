import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../design/adaptive/adaptive_button.dart';
import '../../design/adaptive/adaptive_dialog.dart';
import '../../design/components/avatar.dart';
import '../../design/components/pressable_scale.dart';
import '../../design/components/progress_bar.dart';
import '../../design/components/quizup_button.dart';
import '../../design/components/quizup_text.dart';
import '../../design/tokens.dart';
import '../../shared/format.dart';

class DuelScreen extends StatefulWidget {
  const DuelScreen({super.key, required this.fixture});

  final DuelFixture fixture;

  @override
  State<DuelScreen> createState() => _DuelScreenState();
}

class _DuelScreenState extends State<DuelScreen> {
  int _questionIndex = 0;
  int? _selectedIndex;
  int _score = 0;
  bool _finished = false;

  DuelQuestion get _question => widget.fixture.questions[_questionIndex];

  bool get _isLast => _questionIndex == widget.fixture.questions.length - 1;

  bool get _isCorrect => _selectedIndex == _question.correctIndex;

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
      setState(() => _finished = true);
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
      _finished = false;
    });
  }

  Future<void> _quit() async {
    final leave = await showAdaptiveConfirmDialog(
      context,
      title: 'Quitter le duel ?',
      message: 'Ta progression sur cette partie sera perdue.',
      confirmLabel: 'Quitter',
      cancelLabel: 'Continuer',
      destructive: true,
    );
    if (leave && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: colors.duelBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: colors.duelBackground,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.2, -0.8),
              radius: 1.2,
              colors: [
                colors.primary.withValues(alpha: 0.24),
                colors.duelBackground,
              ],
            ),
          ),
          child: SafeArea(
            child: _finished ? _buildResult(context) : _buildQuestion(context),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
          child: Row(
            children: [
              PressableScale(
                onTap: () {
                  _quit();
                },
                semanticLabel: 'Quitter le duel',
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuizupText(
                      'Duel amical',
                      size: 13,
                      weight: FontWeight.w700,
                      color: colors.onDuel,
                    ),
                    QuizupText(
                      'Question ${_questionIndex + 1} / ${widget.fixture.questions.length}',
                      size: 10,
                      color: colors.mutedOnDuel,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.duelAccent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: colors.duelAccent.withValues(alpha: 0.24),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bolt_rounded,
                      size: 14,
                      color: colors.duelAccent,
                    ),
                    const SizedBox(width: 3),
                    QuizupText(
                      '$_score pts',
                      size: 12,
                      weight: FontWeight.w700,
                      color: colors.duelAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              for (var index = 0; index < widget.fixture.questions.length; index++)
                Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(
                      right: index == widget.fixture.questions.length - 1 ? 0 : 5,
                    ),
                    decoration: BoxDecoration(
                      color: index <= _questionIndex
                          ? colors.duelAccent
                          : Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              QuizupAvatar(
                name: 'Toi',
                color: colors.primary,
                size: 28,
                showBorder: true,
                borderColor: Colors.white24,
              ),
              const SizedBox(width: 6),
              QuizupText(
                'Toi',
                size: 11,
                weight: FontWeight.w600,
                color: colors.onDuel,
              ),
              const SizedBox(width: 8),
              QuizupText(
                '$_score',
                size: 13,
                weight: FontWeight.w800,
                color: colors.onDuel,
              ),
              const Spacer(),
              QuizupText(
                '${widget.fixture.opponent.score}',
                size: 13,
                weight: FontWeight.w800,
                color: colors.onDuel,
              ),
              const SizedBox(width: 8),
              QuizupText(
                widget.fixture.opponent.name,
                size: 11,
                weight: FontWeight.w600,
                color: colors.onDuel,
              ),
              const SizedBox(width: 6),
              QuizupAvatar(
                name: widget.fixture.opponent.name,
                color: widget.fixture.opponent.color,
                size: 28,
                showBorder: true,
                borderColor: Colors.white24,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
            children: [
              _TimerBar(key: ValueKey('timer-$_questionIndex')),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.duelSurface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 148,
                        width: double.infinity,
                        child: Image.asset(
                          _question.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    QuizupText(
                      _question.text,
                      size: 18,
                      weight: FontWeight.w700,
                      color: colors.onDuel,
                      height: 1.25,
                    ),
                    const SizedBox(height: 14),
                    for (var index = 0;
                        index < _question.answers.length;
                        index++) ...[
                      _AnswerTile(
                        index: index,
                        label: _question.answers[index],
                        selected: _selectedIndex == index,
                        correct: index == _question.correctIndex,
                        revealed: _selectedIndex != null,
                        onTap: () => _select(index),
                      ),
                      if (index < _question.answers.length - 1)
                        const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
              if (_selectedIndex != null) ...[
                const SizedBox(height: 14),
                _FeedbackBanner(correct: _isCorrect),
                const SizedBox(height: 10),
                AdaptiveButton(
                  label: _isLast ? 'Voir le résultat' : 'Question suivante',
                  size: QuizupButtonSize.lg,
                  expand: true,
                  icon: _isLast ? Icons.emoji_events_rounded : Icons.arrow_forward_rounded,
                  onPressed: _next,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResult(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final win = _score > widget.fixture.opponent.score;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      children: [
        const SizedBox(height: 24),
        Center(
          child: Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (win ? colors.win : colors.loss).withValues(alpha: 0.14),
              border: Border.all(
                color: (win ? colors.win : colors.loss).withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              win ? Icons.emoji_events_rounded : Icons.favorite_rounded,
              color: win ? colors.win : colors.loss,
              size: 44,
            ),
          ),
        ),
        const SizedBox(height: 18),
        QuizupText(
          win ? 'Victoire !' : 'Bien joué !',
          size: 30,
          weight: FontWeight.w800,
          color: colors.onDuel,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        QuizupText(
          win
              ? 'Tu as battu ${widget.fixture.opponent.name}.'
              : '${widget.fixture.opponent.name} garde l’avantage cette fois.',
          size: 13,
          color: colors.mutedOnDuel,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colors.duelSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ResultPlayer(
                    name: 'Toi',
                    score: _score,
                    color: colors.primary,
                    highlight: win,
                  ),
                  QuizupText(
                    'VS',
                    size: 12,
                    weight: FontWeight.w700,
                    color: colors.mutedOnDuel,
                  ),
                  _ResultPlayer(
                    name: widget.fixture.opponent.name,
                    score: widget.fixture.opponent.score,
                    color: widget.fixture.opponent.color,
                    highlight: !win,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bolt_rounded, size: 16, color: colors.duelAccent),
                  const SizedBox(width: 4),
                  QuizupText(
                    '+${compactNumber(_score)} XP',
                    size: 14,
                    weight: FontWeight.w700,
                    color: colors.duelAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        AdaptiveButton(
          label: 'Rejouer',
          icon: Icons.refresh_rounded,
          size: QuizupButtonSize.lg,
          expand: true,
          onPressed: _replay,
        ),
        const SizedBox(height: 10),
        AdaptiveButton(
          label: 'Retour au sujet',
          variant: QuizupButtonVariant.ghost,
          size: QuizupButtonSize.lg,
          expand: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _TimerBar extends StatelessWidget {
  const _TimerBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    return Row(
      children: [
        Expanded(
          child: QuizupProgressBar(
            value: 0.72,
            height: 6,
            color: colors.duelAccent,
            backgroundColor: Colors.white.withValues(alpha: 0.12),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 28,
          child: QuizupText(
            '13s',
            size: 10,
            weight: FontWeight.w600,
            color: colors.mutedOnDuel,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _AnswerTile extends StatelessWidget {
  const _AnswerTile({
    required this.index,
    required this.label,
    required this.selected,
    required this.correct,
    required this.revealed,
    required this.onTap,
  });

  final int index;
  final String label;
  final bool selected;
  final bool correct;
  final bool revealed;
  final VoidCallback onTap;

  static const _letters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;

    final showCorrect = revealed && correct;
    final showWrong = revealed && selected && !correct;
    final background = showCorrect
        ? colors.win.withValues(alpha: 0.16)
        : showWrong
            ? colors.loss.withValues(alpha: 0.16)
            : Colors.white.withValues(alpha: 0.05);
    final border = showCorrect
        ? colors.win.withValues(alpha: 0.6)
        : showWrong
            ? colors.loss.withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.1);
    final foreground = showCorrect
        ? colors.win
        : showWrong
            ? colors.loss
            : colors.onDuel;

    return PressableScale(
      onTap: revealed ? null : onTap,
      semanticLabel: '$label, réponse ${_letters[index]}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              child: Text(
                _letters[index],
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: foreground,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: QuizupText(
                label,
                size: 14,
                weight: FontWeight.w500,
                color: foreground,
                height: 1.25,
              ),
            ),
            if (showCorrect)
              Icon(Icons.check_circle_rounded, size: 18, color: colors.win),
            if (showWrong)
              Icon(Icons.cancel_rounded, size: 18, color: colors.loss),
          ],
        ),
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({required this.correct});

  final bool correct;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final color = correct ? colors.win : colors.loss;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(
            correct ? Icons.check_circle_rounded : Icons.info_rounded,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: QuizupText(
              correct ? 'Bonne réponse ! +100 points' : 'Ce n’est pas la bonne réponse.',
              size: 12,
              weight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultPlayer extends StatelessWidget {
  const _ResultPlayer({
    required this.name,
    required this.score,
    required this.color,
    required this.highlight,
  });

  final String name;
  final int score;
  final Color color;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return Column(
      children: [
        QuizupAvatar(
          name: name,
          color: color,
          size: 48,
          showBorder: highlight,
          borderColor: tokens.colors.duelAccent,
        ),
        const SizedBox(height: 6),
        QuizupText(
          name,
          size: 12,
          weight: FontWeight.w600,
          color: tokens.colors.onDuel,
        ),
        QuizupText(
          '$score',
          size: 22,
          weight: FontWeight.w800,
          color: highlight ? tokens.colors.duelAccent : tokens.colors.onDuel,
        ),
      ],
    );
  }
}
