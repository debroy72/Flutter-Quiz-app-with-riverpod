const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bcrypt = require('bcryptjs');

// Replace './userservice' and './usermodel' with the correct paths
const { registerUser } = require('./userservice'); 
const User = require('./usermodel'); 

const app = express();
const PORT = process.env.PORT || 5001;

// MongoDB connection string
const mongoURI = 'mongodb://localhost:27017/myQuizApp';

// Connect to MongoDB
mongoose.connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
.then(() => console.log('Connected to MongoDB...'))
.catch(err => console.error('Could not connect to MongoDB...', err));

app.use(cors());
app.use(express.json());

// Route to handle user registration
app.post('/register', async (req, res) => {
    try {
        const { username, password } = req.body;
        const user = await registerUser(username, password);
        res.status(201).json(user);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Route to handle user login
app.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;
        // Find the user by username
        const user = await User.findOne({ username });

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Compare submitted password with stored hash
        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        // Successful login
        res.json(user);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
