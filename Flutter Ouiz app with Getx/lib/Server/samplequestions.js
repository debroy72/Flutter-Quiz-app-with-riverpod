const seedQuestions = [
    // Level 1 Questions
    {
        "questionText": "If all dogs are animals, and all animals have four legs, do all dogs have four legs?",
        "options": ["Yes", "No", "Cannot be determined", "None of the above"],
        "answerIndex": 0,
        "level": 1
    },
    {
        "questionText": "If some A are B, and some B are C, are some A definitely C?",
        "options": ["Yes", "No", "Cannot be determined", "None of the above"],
        "answerIndex": 2,
        "level": 1
    },
    {
        "questionText": "Which of the following is the contrapositive of 'If it rains, then they cancel school'?",
        "options": ["If they do not cancel school, then it does not rain", "If it does not rain, then they do not cancel school", "If they cancel school, then it rains", "None of the above"],
        "answerIndex": 1,
        "level": 1
    },
    {
        "questionText": "Choose the conclusion that logically follows: 'All cats are mammals. All mammals have kidneys.'",
        "options": ["All cats have kidneys", "Some cats are mammals", "No cats have kidneys", "None of the above"],
        "answerIndex": 0,
        "level": 1
    },
    {
        "questionText": "'No A are B. All B are C.' Which conclusion follows?",
        "options": ["No A are C", "Some A are not C", "Cannot be determined", "None of the above"],
        "answerIndex": 2,
        "level": 1
    },
    {
        "questionText": "If 'Some A are B' is true, which must also be true?",
        "options": ["Some B are A", "No B are A", "All A are B", "None of the above"],
        "answerIndex": 0,
        "level": 1
    },
    {
        "questionText": "If 'All A are B' and 'All B are C', which is true?",
        "options": ["All A are C", "Some A are not C", "No A are C", "None of the above"],
        "answerIndex": 0,
        "level": 1
    },
    {
        "questionText": "Which statement is the converse of 'If it is raining, then there are clouds in the sky'?",
        "options": ["If there are clouds in the sky, then it is raining", "If it is not raining, then there are no clouds in the sky", "If there are no clouds in the sky, then it is not raining", "None of the above"],
        "answerIndex": 0,
        "level": 1
    },
    {
        "questionText": "'All A are B. No B are C.' Which conclusion follows?",
        "options": ["No A are C", "Some A are not C", "All A are C", "Cannot be determined"],
        "answerIndex": 0,
        "level": 1
    },
    {
        "questionText": "Choose the conclusion that logically follows: 'No animals are plants. All dogs are animals.'",
        "options": ["No dogs are plants", "Some dogs are not plants", "All dogs are plants", "None of the above"],
        "answerIndex": 0,
        "level": 1
    },
    {
        "questionText": "If 'All A are B' and 'All B are C', which statement must be false?",
        "options": ["Some A are C", "No A are C", "All C are A", "Some C are not A"],
        "answerIndex": 2,
        "level": 2
    },
    {
        "questionText": "Which of the following is the inverse of 'If it is hot, then I will swim'?",
        "options": ["If it is not hot, then I will not swim", "If I will swim, then it is hot", "If I will not swim, then it is not hot", "None of the above"],
        "answerIndex": 0,
        "level": 2
    },
    {
        "questionText": "Choose the conclusion that logically follows: 'All squares are rectangles. No rectangles are circles.'",
        "options": ["All squares are circles", "No squares are circles", "Some rectangles are not squares", "None of the above"],
        "answerIndex": 1,
        "level": 2
    },
    {
        "questionText": "If 'Some A are B' and 'All B are C', which statement is necessarily true?",
        "options": ["All A are C", "Some A are C", "No A are C", "None of the above"],
        "answerIndex": 1,
        "level": 2
    },
    {
        "questionText": "'All A are B. Some B are not C.' Which conclusion follows?",
        "options": ["Some A are not C", "No A are C", "All A are C", "Cannot be determined"],
        "answerIndex": 0,
        "level": 2
    },
    {
        "questionText": "If 'No A are B' is true, which must also be true?",
        "options": ["No B are A", "Some A are not B", "All A are B", "None of the above"],
        "answerIndex": 0,
        "level": 2
    },
    {
        "questionText": "'Some A are not B. All B are C.' Which is true?",
        "options": ["Some A are not C", "All A are C", "No A are C", "Cannot be determined"],
        "answerIndex": 3,
        "level": 2
    },
    {
        "questionText": "Which statement is the negation of 'If it snows, then the school is closed'?",
        "options": ["If it does not snow, then the school is not closed", "The school is closed only if it snows", "It snows only if the school is closed", "It does not snow and the school is not closed"],
        "answerIndex": 3,
        "level": 2
    },
    {
        "questionText": "'All A are B. Some C are not B.' Which conclusion follows?",
        "options": ["Some C are not A", "No C are A", "All C are A", "Cannot be determined"],
        "answerIndex": 0,
        "level": 2
    },
    {
        "questionText": "Choose the conclusion that logically follows: 'No birds are mammals. Some animals are birds.'",
        "options": ["Some animals are not mammals", "No animals are mammals", "All animals are mammals", "Cannot be determined"],
        "answerIndex": 0,
        "level": 2
    },
    {
        "questionText": "If 'All A are B' and 'No B are C', which of the following must be true?",
        "options": ["No A are C", "Some A are not C", "All A are C", "Cannot be determined"],
        "answerIndex": 0,
        "level": 3
    },
    {
        "questionText": "Which of the following is an example of modus tollens?",
        "options": ["If P then Q. P. Therefore, Q.", "If P then Q. Not Q. Therefore, not P.", "If P then Q. Q. Therefore, P.", "None of the above"],
        "answerIndex": 1,
        "level": 3
    },
    {
        "questionText": "Choose the conclusion that logically follows: 'No primes are even. Some numbers are primes.'",
        "options": ["Some numbers are not even", "No numbers are even", "All numbers are even", "Cannot be determined"],
        "answerIndex": 0,
        "level": 3
    },
    {
        "questionText": "'All A are B. All B are C. No C are D.' Which conclusion follows?",
        "options": ["No A are D", "Some A are not D", "All A are D", "Cannot be determined"],
        "answerIndex": 0,
        "level": 3
    },
    {
        "questionText": "If 'Some A are B' and 'No B are C', which statement is necessarily false?",
        "options": ["Some A are C", "No A are C", "Some A are not C", "All of the above"],
        "answerIndex": 0,
        "level": 3
    },
    {
        "questionText": "In a room, there are four people. Each person can either tell the truth always (a truth-teller) or lie always (a liar). Person A says 'All of us are liars.', Person B says 'Exactly one of us is a truth-teller.', Person C says 'I am the only liar here.', and Person D remains silent. Based on these statements, who is the truth-teller?",
        "options": ["Person A", "Person B", "Person C", "Person D"],
        "answerIndex": 3,
        "level": 3
    }
];
module.exports = seedQuestions;