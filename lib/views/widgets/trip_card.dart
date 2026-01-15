import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_texts.dart';
import '../../core/app_theme.dart';
import '../../models/trip_model.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  final bool highlighted;
  final VoidCallback? onDetails;
  final VoidCallback? onNavigate;

  const TripCard({
    super.key,
    required this.trip,
    this.highlighted = false,
    this.onDetails,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final statusUi = _statusUi(trip.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: highlighted ? AppColors.cardBorder : Colors.transparent,
          width: highlighted ? 1.4 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.pillShadow,
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StatusPill(
                label: statusUi.label,
                bg: statusUi.bg,
                textColor: statusUi.text,
                showDot: statusUi.dot,
                dotColor: statusUi.dotColor,
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE5E7EB),
                child: Icon(Icons.person, color: Colors.black54, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            trip.timeLabel,
            style: AppTheme.tripTime,
          ),
          const SizedBox(height: 12),
          _StopRow(
            icon: Icons.radio_button_unchecked,
            titleLabel: AppTexts.pickup,
            title: trip.pickupTitle,
            subtitle: trip.pickupSubtitle,
            showConnector: true,
          ),
          const SizedBox(height: 12),
          _StopRow(
            icon: Icons.location_on_outlined,
            titleLabel: AppTexts.dropOff,
            title: trip.dropoffTitle,
            subtitle: trip.dropoffSubtitle,
            showConnector: false,
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.divider, height: 24),
          Row(
            children: [
              Text(
                trip.passengerName,
                style: AppTheme.passengerName,
              ),
              const Spacer(),
              _ActionButton(
                label: highlighted ? AppTexts.navigate : AppTexts.details,
                icon: highlighted ? Icons.navigation_outlined : null,
                filled: highlighted,
                onTap: highlighted ? onNavigate : onDetails,
              ),
            ],
          ),
          if (highlighted) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                _Meta(icon: Icons.groups_outlined, text: '${trip.pax} Pax'),
                const SizedBox(width: 14),
                _Meta(icon: Icons.work_outline, text: '${trip.bags} Bags'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTheme.metaText,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool filled;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    this.icon,
    required this.filled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: filled ? AppColors.portalOlive : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: filled
                  ? AppTheme.buttonText
                  : AppTheme.buttonTextSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _StopRow extends StatelessWidget {
  final IconData icon;
  final String titleLabel;
  final String title;
  final String subtitle;
  final bool showConnector;

  const _StopRow({
    required this.icon,
    required this.titleLabel,
    required this.title,
    required this.subtitle,
    required this.showConnector,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 28,
          child: Column(
            children: [
              Icon(icon, color: AppColors.textSecondary),
              if (showConnector) ...[
                const SizedBox(height: 2),
                Container(
                  width: 2,
                  height: 34,
                  color: AppColors.divider,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleLabel,
                style: AppTheme.locationLabel,
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: AppTheme.locationTitle,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTheme.locationSubtitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color bg;
  final Color textColor;
  final bool showDot;
  final Color dotColor;

  const _StatusPill({
    required this.label,
    required this.bg,
    required this.textColor,
    required this.showDot,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: AppTheme.statusPill.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

class _StatusUi {
  final String label;
  final Color bg;
  final Color text;
  final bool dot;
  final Color dotColor;

  const _StatusUi({
    required this.label,
    required this.bg,
    required this.text,
    required this.dot,
    required this.dotColor,
  });
}

_StatusUi _statusUi(TripStatus status) {
  switch (status) {
    case TripStatus.inProgress:
      return const _StatusUi(
        label: AppTexts.inProgress,
        bg: AppColors.statusInProgressBg,
        text: AppColors.textPrimary,
        dot: true,
        dotColor: AppColors.statusInProgressDot,
      );
    case TripStatus.pending:
      return const _StatusUi(
        label: AppTexts.pending,
        bg: AppColors.statusPendingBg,
        text: AppColors.statusPendingText,
        dot: false,
        dotColor: Colors.transparent,
      );
    case TripStatus.completed:
      return const _StatusUi(
        label: AppTexts.completed,
        bg: AppColors.statusCompletedBg,
        text: AppColors.statusCompletedText,
        dot: false,
        dotColor: Colors.transparent,
      );
    case TripStatus.canceled:
      return const _StatusUi(
        label: AppTexts.canceled,
        bg: AppColors.statusCanceledBg,
        text: AppColors.statusCanceledText,
        dot: false,
        dotColor: Colors.transparent,
      );
  }
}

