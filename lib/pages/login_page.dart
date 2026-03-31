import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _showPassword = false;
  bool _isLoading = false;

  late AnimationController _fadeCtrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, -0.15), end: Offset.zero)
        .animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    final l = AppLocalizations.of(context)!;
    if (_emailCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
      _showSnack(l.fillAllFields, isError: true);
      return;
    }
    setState(() => _isLoading = true);
    final error = await context.read<AppProvider>().login(_emailCtrl.text, _passwordCtrl.text);
    if (!mounted) return;
    if (error != null) {
      _showSnack(error, isError: true);
    }
    setState(() => _isLoading = false);
  }

  void _showSnack(String msg, {bool isError = false}) {
    final c = context.colors;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? c.danger : c.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: c.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    SlideTransition(
                      position: _slide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Column(
                          children: [
                            Container(
                              width: 68, height: 68,
                              decoration: BoxDecoration(
                                gradient: c.primaryGradient,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [BoxShadow(color: c.primary.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
                              ),
                              child: const Icon(Icons.water_drop, color: Colors.white, size: 32),
                            ),
                            const SizedBox(height: 20),
                            Text(l.welcomeBack, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: c.textDark, letterSpacing: -0.5)),
                            const SizedBox(height: 6),
                            Text(l.signInSubtitle, style: TextStyle(fontSize: 14, color: c.textMuted)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FadeTransition(
                      opacity: _fade,
                      child: Column(
                        children: [
                          _buildInput(controller: _emailCtrl, icon: Icons.mail_outline_rounded, hint: l.emailAddress, keyboardType: TextInputType.emailAddress),
                          const SizedBox(height: 14),
                          _buildInput(
                            controller: _passwordCtrl,
                            icon: Icons.lock_outline_rounded,
                            hint: l.password,
                            obscure: !_showPassword,
                            suffix: GestureDetector(
                              onTap: () => setState(() => _showPassword = !_showPassword),
                              child: Icon(_showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: c.textFaint, size: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(alignment: Alignment.centerRight, child: Text(l.forgotPassword, style: TextStyle(fontSize: 12, color: c.primary, fontWeight: FontWeight.w500))),
                          const SizedBox(height: 20),
                          _buildPrimaryButton(label: l.signIn, icon: Icons.arrow_forward_rounded, isLoading: _isLoading, onTap: _submit),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(children: [
                      Expanded(child: Divider(color: c.borderLight)),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(l.or, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: c.textFaint))),
                      Expanded(child: Divider(color: c.borderLight)),
                    ]),
                    const SizedBox(height: 16),
                    Row(children: [
                      Expanded(child: _socialButton(l.google, Icons.g_mobiledata_rounded)),
                      const SizedBox(width: 12),
                      Expanded(child: _socialButton(l.apple, Icons.apple_rounded)),
                    ]),
                    if (kDebugMode) ...[
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () => context.read<AppProvider>().debugLogin(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: c.warning.withOpacity(0.6), width: 1.5),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Icon(Icons.bug_report_rounded, color: c.warning, size: 18),
                            const SizedBox(width: 8),
                            Text(l.debugLogin, style: TextStyle(color: c.warning, fontSize: 14, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24, top: 32),
                      child: GestureDetector(
                        onTap: () => context.go('/register'),
                        child: RichText(
                          text: TextSpan(
                            text: l.noAccount,
                            style: TextStyle(color: c.textMuted, fontSize: 14),
                            children: [TextSpan(text: l.signUp, style: TextStyle(color: c.primary, fontWeight: FontWeight.w600))],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput({required TextEditingController controller, required IconData icon, required String hint, bool obscure = false, TextInputType keyboardType = TextInputType.text, Widget? suffix}) {
    final c = context.colors;
    return Container(
      decoration: BoxDecoration(color: c.inputBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.border)),
      child: TextField(
        controller: controller, obscureText: obscure, keyboardType: keyboardType,
        style: TextStyle(color: c.textDark, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: c.textFaint, size: 20),
          suffixIcon: suffix != null ? Padding(padding: const EdgeInsets.all(12), child: suffix) : null,
          hintText: hint, hintStyle: TextStyle(color: c.textFaint),
          border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({required String label, required IconData icon, required bool isLoading, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: AppTheme.primaryButtonDecoration,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: isLoading
            ? [const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))]
            : [Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(width: 8), Icon(icon, color: Colors.white, size: 18)]),
      ),
    );
  }

  Widget _socialButton(String label, IconData icon) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: c.inputBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.border)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 22, color: c.textMid), const SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: c.textMid)),
      ]),
    );
  }
}
