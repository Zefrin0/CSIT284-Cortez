import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            final isCorrect = data['is_correct'] as bool;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: isCorrect ? Colors.lightBlue : Colors.pink,
                    radius: 15,
                    child: Text(
                      ((data['question_index'] as int) + 1).toString(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['question'] as String,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 234, 220, 247),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data['user_answer'] as String,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 234, 220, 247)
                              .withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data['correct_answer'] as String,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 234, 220, 247),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
