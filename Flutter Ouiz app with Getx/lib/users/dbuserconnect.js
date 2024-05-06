const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const { registerUser } = require('./userservice'); // Make sure this path is correct

const app = express();
const PORT = process.env.PORT || 5001;

app.use(cors());
app.use(bodyParser.json());

mongoose.connect('mongodb://localhost:27017/myQuizApp', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log("MongoDB successfully connected"))
.catch(err => console.log(err));

app.post('/register', async (req, res) => {
  try {
    const user = await registerUser(req.body.password);
    res.status(201).json({ username: user.username }); // Return the UUID to the client
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Additional routes here...

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
