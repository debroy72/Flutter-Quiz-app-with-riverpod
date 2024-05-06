const mongoose = require('mongoose');

const questionSchema = new mongoose.Schema({
questionText: String,
options: [String],
answerIndex: Number,
level: Number
});

const Question = mongoose.model('Question', questionSchema);

module.exports = Question;
