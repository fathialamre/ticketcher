import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class AnimationShowcase extends StatefulWidget {
  const AnimationShowcase({super.key});

  @override
  State<AnimationShowcase> createState() => _AnimationShowcaseState();
}

class _AnimationShowcaseState extends State<AnimationShowcase> {
  Key _fadeKey = UniqueKey();
  Key _slideKey = UniqueKey();
  Key _scaleKey = UniqueKey();
  Key _flipKey = UniqueKey();

  void _replayAnimation(String type) {
    setState(() {
      switch (type) {
        case 'fade':
          _fadeKey = UniqueKey();
          break;
        case 'slide':
          _slideKey = UniqueKey();
          break;
        case 'scale':
          _scaleKey = UniqueKey();
          break;
        case 'flip':
          _flipKey = UniqueKey();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Effects'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Fade In Animation', 'fade'),
            _buildFadeInTicket(),
            const SizedBox(height: 28),
            _buildSectionHeader('Slide Animation', 'slide'),
            _buildSlideTicket(),
            const SizedBox(height: 28),
            _buildSectionHeader('Scale Animation', 'scale'),
            _buildScaleTicket(),
            const SizedBox(height: 28),
            _buildSectionHeader('Flip Animation', 'flip'),
            _buildFlipTicket(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () => _replayAnimation(type),
            icon: const Icon(Icons.replay),
            tooltip: 'Replay Animation',
            style: IconButton.styleFrom(
              backgroundColor: Colors.deepOrange.withAlpha(26),
              foregroundColor: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFadeInTicket() {
    return AnimatedTicketcher(
      key: _fadeKey,
      animation: TicketAnimation.fadeIn(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
      ),
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Colors.white,
        shadow: BoxShadow(
          color: Colors.blue.withAlpha(51),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
        divider: TicketDivider.dashed(
          color: Colors.blue.withAlpha(128),
          thickness: 1,
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.visibility,
                  color: Colors.blue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fade In',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Smooth opacity transition from 0 to 1',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnimationInfo('Duration', '800ms'),
              _buildAnimationInfo('Curve', 'easeOut'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSlideTicket() {
    return AnimatedTicketcher(
      key: _slideKey,
      animation: TicketAnimation.slideUp(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutBack,
      ),
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        gradient: LinearGradient(
          colors: [Colors.green[400]!, Colors.teal[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shadow: BoxShadow(
          color: Colors.green.withAlpha(77),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
        divider: TicketDivider.dashed(color: Colors.white38, thickness: 1),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.swipe_up,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slide Animation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Slides in from bottom',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnimationInfoLight('Direction', 'Up'),
              _buildAnimationInfoLight('Curve', 'easeOutBack'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScaleTicket() {
    return AnimatedTicketcher(
      key: _scaleKey,
      animation: TicketAnimation.scale(
        duration: const Duration(milliseconds: 500),
        curve: Curves.elasticOut,
      ),
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Colors.white,
        shadow: BoxShadow(
          color: Colors.purple.withAlpha(51),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
        divider: TicketDivider.circles(
          color: Colors.purple.withAlpha(128),
          circleRadius: 3,
          circleSpacing: 8,
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple[400]!, Colors.pink[400]!],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.zoom_in, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scale Animation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Grows from small to full size',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnimationInfo('Initial', '0x'),
              _buildAnimationInfo('Curve', 'elasticOut'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlipTicket() {
    return AnimatedTicketcher(
      key: _flipKey,
      animation: TicketAnimation.flip(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      ),
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        gradient: LinearGradient(
          colors: [Colors.indigo[700]!, Colors.purple[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shadow: BoxShadow(
          color: Colors.indigo.withAlpha(77),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),

        divider: TicketDivider.dashed(color: Colors.white24, thickness: 1),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'PREMIUM',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.verified, color: Colors.amber, size: 24),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'VIP Experience',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '3D flip animation effect',
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildVIPInfo('ACCESS', 'All Areas'),
              _buildVIPInfo('VALID', 'Lifetime'),
              _buildVIPInfo('STATUS', 'Active'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimationInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[500],
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAnimationInfoLight(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white54,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildVIPInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white54,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
