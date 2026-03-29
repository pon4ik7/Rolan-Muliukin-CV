import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/models/profile_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';
import 'glass_card.dart';
import 'section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({required this.profile, super.key});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Contact',
          subtitle: "Let's Build Great Backend Products",
        ),
        const SizedBox(height: 20),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Open to internship and junior backend opportunities. '
                'If you are hiring for Go or backend roles, feel free to reach out.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () => launchExternalLink(profile.links.contactMail),
                    icon: const Icon(Icons.mail_outline),
                    label: Text(profile.contacts.email),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: profile.contacts.email),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email copied to clipboard')),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Email'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => launchExternalLink(profile.links.telegram),
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Telegram'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 14,
                runSpacing: 10,
                children: [
                  _MetaChip(icon: Icons.phone_outlined, text: profile.contacts.phone),
                  _MetaChip(
                    icon: Icons.location_on_outlined,
                    text: profile.contacts.location,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.border.withOpacity(0.65)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppPalette.secondary),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}
