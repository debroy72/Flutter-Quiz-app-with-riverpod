// userModel.js
const mongoose = require('mongoose');
const { v4: uuidv4 } = require('uuid'); // Import UUID to generate unique identifiers

const userSchema = new mongoose.Schema({
  username: { type: String, default: () => uuidv4(), unique: true }, // Generate a UUID as username
  password: { type: String, required: true } // Still hash passwords for security
});

module.exports = mongoose.model('User', userSchema);
