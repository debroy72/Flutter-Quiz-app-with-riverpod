const bodyParser = require('body-parser');
const cors = require('cors');
const express = require('express');
const mongoose = require('mongoose');
const Question = require('./question.js'); // Adjust the path as necessary

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());

mongoose.connect('mongodb://localhost:27017/myApp', {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => console.log("MongoDB successfully connected"))
.catch(err => console.log(err));

app.get('/questions/:level', async (req, res) => {
  try {
    const level = parseInt(req.params.level, 10);
    const questions = await Question.find({ level: level });
    res.json(questions);
  } catch (error) {
    res.status(400).json('Error: ' + error);
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
