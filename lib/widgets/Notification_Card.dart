import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  final String date;
  final String dayTime;
  final String title;
  final String description;

  const NotificationCard({
    super.key,
    required this.date,
    required this.dayTime,
    required this.title,
    required this.description,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,  // 🔥 makes card full width always
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DATE
            Text(
              widget.date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 4),

            // DAY + TIME
            Text(
              widget.dayTime,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 12),

            // TITLE
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 6),

            // DESCRIPTION + Read More
            LayoutBuilder(
              builder: (context, constraints) {
                final text = TextSpan(
                  text: widget.description,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                );

                final tp = TextPainter(
                  text: text,
                  maxLines: 2,
                  textDirection: TextDirection.ltr,
                );

                tp.layout(maxWidth: constraints.maxWidth);

                final isLong = tp.didExceedMaxLines;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.description,
                      maxLines: isExpanded ? null : 2,
                      overflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      style:
                      const TextStyle(fontSize: 13, color: Colors.black87),
                    ),

                    if (isLong) ...[
                      const SizedBox(height: 6),

                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded ? "Read less" : "Read more",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ]
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
