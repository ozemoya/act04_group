// Activity 04: Flutter Widget Wars
// Team: CS Coders
// Team members:
// - Myles Miller | 002753776
// - Zachari Taylor | 002855653
// Submission date: September 22, 2026
import 'package:flutter/material.dart';

void main() => runApp(const ViralContentStudioApp());

class ViralContentStudioApp extends StatefulWidget {
  const ViralContentStudioApp({super.key});
  @override
  State<ViralContentStudioApp> createState() => _ViralContentStudioAppState();
}

class _ViralContentStudioAppState extends State<ViralContentStudioApp> {
  bool isDark = true;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Viral Content Studio',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7454A8)),
      scaffoldBackgroundColor: const Color(0xFFF5F1F8),
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFB7A2E8),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF17131F),
    ),
    themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    home: ContentStudioScreen(
      isDark: isDark,
      onToggleTheme: () => setState(() => isDark = !isDark),
    ),
  );
}

// Stateless widget 1: its content depends only on parent values.
class StudioHeader extends StatelessWidget {
  const StudioHeader({super.key, required this.isTrending});
  final bool isTrending;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'CONTENT CONTROL ROOM',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      const SizedBox(height: 5),
      Text(
        'Make a post move.',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 6),
      Text(
        isTrending
            ? 'Your post crossed the engagement target.'
            : 'Try the actions below to build momentum.',
      ),
    ],
  );
}

// Stateless widget 2: it displays parent-owned data without local state.
class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final int value;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Semantics(
    label: '$label: $value',
    child: ExcludeSemantics(
      child: Container(
        width: 112,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22),
            const SizedBox(height: 5),
            Text('$value', style: Theme.of(context).textTheme.titleLarge),
            Text(label, style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    ),
  );
}

class ContentStudioScreen extends StatefulWidget {
  const ContentStudioScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });
  final bool isDark;
  final VoidCallback onToggleTheme;
  @override
  State<ContentStudioScreen> createState() => _ContentStudioScreenState();
}

class _ContentStudioScreenState extends State<ContentStudioScreen> {
  int likes = 0, comments = 0, shares = 0, saves = 0, streak = 0;
  double boostLevel = 40;
  String lastAction = 'READY';
  String? previousAction;
  int get engagementScore => likes + comments * 2 + shares * 3 + saves * 2;
  bool get isTrending => engagementScore >= 20;

  void performAction(String action) => setState(() {
    switch (action) {
      case 'LIKE':
        likes++;
      case 'COMMENT':
        comments++;
      case 'SHARE':
        shares++;
      case 'SAVE':
        saves++;
    }
    streak = previousAction == action ? streak + 1 : 1;
    previousAction = action;
    lastAction = '$action REGISTERED';
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: isTrending
          ? (widget.isDark ? const Color(0xFF302142) : const Color(0xFFE9DDF6))
          : null,
      appBar: AppBar(
        title: const Text('Viral Content Studio'),
        actions: [
          IconButton(
            key: const Key('theme-toggle'),
            tooltip: widget.isDark
                ? 'Switch to light mode'
                : 'Switch to dark mode',
            onPressed: widget.onToggleTheme,
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StudioHeader(isTrending: isTrending),
                  const SizedBox(height: 20),
                  Card(
                    color: scheme.surfaceContainerLow,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'ENGAGEMENT SCORE',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            '$engagementScore / 20',
                            key: const Key('score'),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: (engagementScore / 20).clamp(0, 1),
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          const SizedBox(height: 12),
                          if (isTrending)
                            Text(
                              'TRENDING NOW',
                              key: const Key('trending-banner'),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: scheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          else
                            const Text('Reach 20 engagement points to trend.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      MetricTile(
                        label: 'Likes',
                        value: likes,
                        icon: Icons.favorite,
                      ),
                      MetricTile(
                        label: 'Comments',
                        value: comments,
                        icon: Icons.chat_bubble,
                      ),
                      MetricTile(
                        label: 'Shares',
                        value: shares,
                        icon: Icons.ios_share,
                      ),
                      MetricTile(
                        label: 'Saves',
                        value: saves,
                        icon: Icons.bookmark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('STATUS: $lastAction', key: const Key('status')),
                  Text('Repeat streak: $streak', key: const Key('streak')),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 18,
                    runSpacing: 18,
                    children: [
                      TactileActionButton(
                        label: 'LIKE',
                        icon: Icons.favorite,
                        accentColor: Colors.pinkAccent,
                        isDark: widget.isDark,
                        onPressed: () => performAction('LIKE'),
                      ),
                      TactileActionButton(
                        label: 'COMMENT',
                        icon: Icons.chat_bubble,
                        accentColor: Colors.tealAccent,
                        isDark: widget.isDark,
                        onPressed: () => performAction('COMMENT'),
                      ),
                      TactileActionButton(
                        label: 'SHARE',
                        icon: Icons.ios_share,
                        accentColor: Colors.amberAccent,
                        isDark: widget.isDark,
                        onPressed: () => performAction('SHARE'),
                      ),
                      TactileActionButton(
                        label: 'SAVE',
                        icon: Icons.bookmark,
                        accentColor: Colors.lightBlueAccent,
                        isDark: widget.isDark,
                        onPressed: () => performAction('SAVE'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Boost calibration: ${boostLevel.round()}%',
                    key: const Key('boost-label'),
                  ),
                  Slider(
                    key: const Key('boost-slider'),
                    value: boostLevel,
                    min: 0,
                    max: 100,
                    // 🐛 BUG #2 (fixed): notify Flutter when slider state changes.
                    onChanged: (value) => setState(() => boostLevel = value),
                  ),
                  Text(
                    'Boost calibration is visual; engagement points come from actions.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TactileActionButton extends StatefulWidget {
  const TactileActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.isDark,
    required this.onPressed,
  });
  final String label;
  final IconData icon;
  final Color accentColor;
  final bool isDark;
  final VoidCallback onPressed;
  @override
  State<TactileActionButton> createState() => _TactileActionButtonState();
}

class _TactileActionButtonState extends State<TactileActionButton> {
  // 🐛 BUG #1 (fixed): each button owns its own pressed state.
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    final base = widget.isDark
        ? const Color(0xFF272332)
        : const Color(0xFFE5E1EA);
    final dark = widget.isDark ? Colors.black87 : const Color(0xFFB1A9BF);
    final light = widget.isDark ? const Color(0xFF3B3449) : Colors.white;
    return Semantics(
      button: true,
      label: widget.label,
      child: GestureDetector(
        // 🐛 BUG #4 (fixed): touch down changes visuals; release fires the action.
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) {
          setState(() => isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => isPressed = false),
        child: AnimatedContainer(
          key: Key('pad-${widget.label.toLowerCase()}'),
          duration: const Duration(milliseconds: 100),
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(24),
            // 🐛 BUG #3 (fixed): pressed shadows are shallow; released are deep.
            boxShadow: isPressed
                ? [
                    BoxShadow(
                      color: dark.withValues(alpha: .5),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: light.withValues(alpha: .5),
                      offset: const Offset(-2, -2),
                      blurRadius: 4,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: dark.withValues(alpha: .7),
                      offset: const Offset(8, 8),
                      blurRadius: 16,
                    ),
                    BoxShadow(
                      color: light.withValues(alpha: .8),
                      offset: const Offset(-8, -8),
                      blurRadius: 16,
                    ),
                  ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: isPressed ? 38 : 44,
                color: isPressed
                    ? widget.accentColor
                    : (widget.isDark ? Colors.white70 : Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPressed
                      ? widget.accentColor
                      : (widget.isDark ? Colors.white70 : Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
