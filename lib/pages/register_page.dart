import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _step = 1;
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _showPass = false;
  bool _isLoading = false;
  double _weight = 70;
  String _activity = 'moderate';
  String _wakeUp = '07:00';
  String _bedTime = '23:00';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _showSnack(String msg, {bool isError = false, bool isSuccess = false}) {
    final c = context.colors;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? c.danger : isSuccess ? c.success : c.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ));
  }

  String get _passwordStrength {
    if (_passCtrl.text.isEmpty) return '';
    if (_passCtrl.text.length < 6) return 'Weak';
    if (_passCtrl.text.length < 10) return 'Medium';
    return 'Strong';
  }

  Color get _strengthColor {
    switch (_passwordStrength) {
      case 'Weak':
        return const Color(0xFFF87171);
      case 'Medium':
        return const Color(0xFFFBBF24);
      case 'Strong':
        return const Color(0xFF34D399);
      default:
        return Colors.transparent;
    }
  }

  double get _strengthFraction {
    switch (_passwordStrength) {
      case 'Weak':
        return 0.33;
      case 'Medium':
        return 0.66;
      case 'Strong':
        return 1.0;
      default:
        return 0.0;
    }
  }

  int get _recommendedGoal {
    switch (_activity) {
      case 'low':
        return 1750;
      case 'high':
        return 2500;
      default:
        return 2000;
    }
  }

  void _nextStep() {
    if (_nameCtrl.text.isEmpty || _emailCtrl.text.isEmpty ||
        _passCtrl.text.isEmpty || _confirmPassCtrl.text.isEmpty) {
      _showSnack('Please fill in all fields', isError: true);
      return;
    }
    if (_passCtrl.text != _confirmPassCtrl.text) {
      _showSnack('Passwords do not match', isError: true);
      return;
    }
    if (_passCtrl.text.length < 6) {
      _showSnack('Password must be at least 6 characters', isError: true);
      return;
    }
    setState(() => _step = 2);
  }

  void _submit() async {
    setState(() => _isLoading = true);
    final error = await context.read<AppProvider>().register(
      name: _nameCtrl.text,
      email: _emailCtrl.text,
      password: _passCtrl.text,
      weight: _weight,
      goal: _recommendedGoal,
      wakeUpTime: _wakeUp,
      bedTime: _bedTime,
    );
    if (!mounted) return;
    if (error != null) {
      _showSnack(error, isError: true);
    } else {
      _showSnack("Account created! Let's get hydrated! 💧", isSuccess: true);
    }
    setState(() => _isLoading = false);
  }

  Widget _buildInput({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffix,
    void Function(String)? onChanged,
  }) {
    final c = context.colors;
    return Container(
      decoration: BoxDecoration(
          color: c.inputBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: c.border)),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: TextStyle(color: c.textDark, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: c.textFaint, size: 20),
          suffixIcon: suffix != null
              ? Padding(padding: const EdgeInsets.all(12), child: suffix)
              : null,
          hintText: hint,
          hintStyle: TextStyle(color: c.textFaint),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: AppTheme.primaryButtonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isLoading
              ? [const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))]
              : [
                  Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: c.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _step == 2 ? setState(() => _step = 1) : context.go('/login'),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.chevron_left_rounded, color: c.textLight, size: 24),
                    Text('Back', style: TextStyle(color: c.textLight, fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                ),
                const SizedBox(height: 20),
                // Progress bar
                Row(children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: c.primaryGradient,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: _step == 2 ? c.primaryGradient : null,
                        color: _step == 2 ? null : c.borderLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 28),
                if (_step == 1) _buildStep1() else _buildStep2(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create Account', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: c.textDark, letterSpacing: -0.5)),
        const SizedBox(height: 6),
        Text('Start your hydration journey today', style: TextStyle(fontSize: 14, color: c.textMuted)),
        const SizedBox(height: 28),
        _buildInput(controller: _nameCtrl, icon: Icons.person_outline_rounded, hint: 'Full name'),
        const SizedBox(height: 14),
        _buildInput(controller: _emailCtrl, icon: Icons.mail_outline_rounded, hint: 'Email address', keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 14),
        _buildInput(
          controller: _passCtrl,
          icon: Icons.lock_outline_rounded,
          hint: 'Password',
          obscure: !_showPass,
          onChanged: (_) => setState(() {}),
          suffix: GestureDetector(
            onTap: () => setState(() => _showPass = !_showPass),
            child: Icon(_showPass ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: c.textFaint, size: 20),
          ),
        ),
        if (_passCtrl.text.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: c.borderLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  widthFactor: _strengthFraction,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        color: _strengthColor,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(_passwordStrength, style: TextStyle(fontSize: 10, color: _strengthColor, fontWeight: FontWeight.w500)),
          ]),
        ],
        const SizedBox(height: 14),
        _buildInput(controller: _confirmPassCtrl, icon: Icons.lock_outline_rounded, hint: 'Confirm password', obscure: true),
        const SizedBox(height: 24),
        _buildPrimaryButton(label: 'Continue', isLoading: false, onTap: _nextStep),
        const SizedBox(height: 20),
        Center(
          child: GestureDetector(
            onTap: () => context.go('/login'),
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(color: c.textMuted, fontSize: 14),
                children: [TextSpan(text: 'Sign In', style: TextStyle(color: c.primary, fontWeight: FontWeight.w600))],
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildStep2() {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About You', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: c.textDark, letterSpacing: -0.5)),
        const SizedBox(height: 6),
        Text('Help us personalize your water goal', style: TextStyle(fontSize: 14, color: c.textMuted)),
        const SizedBox(height: 24),
        Text('WEIGHT (KG)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: c.inputBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.border)),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => setState(() => _weight = double.tryParse(v) ?? 70),
            style: TextStyle(color: c.textDark),
            decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
            controller: TextEditingController(text: _weight.toStringAsFixed(0))..selection = TextSelection.collapsed(offset: _weight.toStringAsFixed(0).length),
          ),
        ),
        const SizedBox(height: 16),
        Text('ACTIVITY LEVEL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
        const SizedBox(height: 8),
        Row(children: ['low', 'moderate', 'high'].map((level) {
          final isSelected = _activity == level;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: level == 'low' ? 0 : 8),
              child: GestureDetector(
                onTap: () => setState(() => _activity = level),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isSelected ? c.primaryGradient : null,
                    color: isSelected ? null : c.inputBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSelected ? Colors.transparent : c.border),
                    boxShadow: isSelected ? [BoxShadow(color: c.primary.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 4))] : null,
                  ),
                  child: Center(
                    child: Text(
                      level[0].toUpperCase() + level.substring(1),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : c.textLight),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList()),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('WAKE UP', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: c.inputBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.border)),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: _wakeUp),
                style: TextStyle(color: c.textDark, fontSize: 14),
                decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
              ),
            ),
          ])),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('BED TIME', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: c.inputBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.border)),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: _bedTime),
                style: TextStyle(color: c.textDark, fontSize: 14),
                decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
              ),
            ),
          ])),
        ]),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: c.isDark ? [const Color(0xFF1E293B), const Color(0xFF1E2340)] : [const Color(0xFFEFF6FF), const Color(0xFFEEF2FF)]),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: c.isDark ? const Color(0xFF334155) : const Color(0xFFBFDBFE)),
          ),
          child: Row(children: [
            Icon(Icons.water_drop, color: c.primary, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Recommended Daily Goal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.primary)),
                const SizedBox(height: 4),
                Text('$_recommendedGoal ml', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: c.textDark)),
                Text('Based on your weight and activity level', style: TextStyle(fontSize: 10, color: c.textMuted)),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 20),
        _buildPrimaryButton(label: 'Create Account', isLoading: _isLoading, onTap: _submit),
        const SizedBox(height: 32),
      ],
    );
  }
}
