import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';

/// Steps shown on the sign-in splash, in order.
enum LoginSplashStep {
  checking('Checking your details'),
  access('Loading your access'),
  opening('Opening Nucleus');

  const LoginSplashStep(this.label);
  final String label;
}

/// Current sign-in step; null hides the splash.
/// Set by `LoginFormProvider.submit()`.
final loginSplashStepProvider = StateProvider<LoginSplashStep?>((ref) => null);

/// Full-screen splash shown after "Sign In or Login" is pressed, until the
/// dashboard opens or sign-in fails. DiBold teal gradient, pulsing logo,
/// the three sign-in steps with a tick as each finishes, and a slim
/// progress bar. Same look in light and dark mode (it is a brand screen).
class LoginSplash extends StatefulWidget {
  const LoginSplash({super.key, required this.step});

  final LoginSplashStep step;

  @override
  State<LoginSplash> createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.step.index;

    return Semantics(
      liveRegion: true,
      label: 'Signing in. ${widget.step.label}',
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [DbColors.primary500, DbColors.primary700, DbColors.primary900],
          ),
        ),
        child: Stack(
          children: [
            // Soft rings in the background.
            Positioned(right: -120, top: -120, child: _ring(360)),
            Positioned(left: -90, bottom: -140, child: _ring(300)),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ScaleTransition(
                      scale: Tween(begin: 0.96, end: 1.04)
                          .animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut)),
                      child: Container(
                        width: 180,
                        height: 88,
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                        decoration: BoxDecoration(
                          color: DbColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 30,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/logologinpdb.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Text(
                              'Nucleus',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: DbColors.primary700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Nucleus Portal',
                      style: TextStyle(
                        color: DbColors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Signing you in…',
                      style: TextStyle(color: DbColors.white.withValues(alpha: 0.8), fontSize: 15),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: 260,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          minHeight: 4,
                          backgroundColor: DbColors.white.withValues(alpha: 0.18),
                          color: DbColors.primary200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    for (final s in LoginSplashStep.values)
                      _StepRow(
                        label: s.label,
                        done: s.index < current,
                        active: s.index == current,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ring(double size) => IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: DbColors.white.withValues(alpha: 0.08), width: 40),
          ),
        ),
      );
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.label, required this.done, required this.active});

  final String label;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = done || active ? DbColors.white : DbColors.white.withValues(alpha: 0.45);
    return SizedBox(
      width: 260,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: done
                    ? const Icon(Icons.check_circle, key: ValueKey('done'), size: 20, color: DbColors.primary200)
                    : active
                        ? const Padding(
                            key: ValueKey('active'),
                            padding: EdgeInsets.all(3),
                            child: CircularProgressIndicator(strokeWidth: 2, color: DbColors.white),
                          )
                        : Icon(Icons.radio_button_unchecked, key: const ValueKey('todo'), size: 20, color: color),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: active ? FontWeight.w700 : FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
