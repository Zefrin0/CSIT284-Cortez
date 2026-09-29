import '../models/quiz_question.dart';

const questions = [
  QuizQuestion(
    'What are the main building blocks of Flutter UIs?',
    ['Widgets', 'Functions', 'Components', 'Blocks'],
  ),
  QuizQuestion(
    'How are Flutter UIs built?',
    [
      'By combining widgets in code',
      'By using XCode for iOS and Android Studio for Android',
      'By dragging and dropping elements in a visual editor',
      'By writing HTML and CSS',
    ],
  ),
  QuizQuestion(
    "What's the purpose of a StatefulWidget?",
    [
      'Update UI as data changes',
      'Render UI that does not depend on data',
      'Ignore data changes',
      'Update data as UI changes',
    ],
  ),
  QuizQuestion(
    'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
    ['StatelessWidget', 'StatefulWidget', 'Both are equally good', 'None of the above'],
  ),
  QuizQuestion(
    'What happens if you change data in a StatelessWidget?',
    [
      'The UI is not updated',
      'The UI is updated automatically',
      'The app crashes',
      'Nothing happens, StatelessWidgets have no data',
    ],
  ),
  QuizQuestion(
    'How should you update data inside of StatefulWidgets?',
    ['By calling setState()', 'By calling updateUI()', 'By calling updateData()', 'By calling updateState()'],
  ),
];