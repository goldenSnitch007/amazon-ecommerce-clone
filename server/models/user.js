const mongoose = require('mongoose');
const { productSchema } = require('./product'); // Import productSchema

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },

  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: value => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),
      message: "Please enter a valid email",
    }
  },

  password: {
    type: String,
    required: true,
    validate: {
      validator: value => value.length > 6,
      message: "Please enter a password longer than 6 characters",
    }
  },

  address: {
    type: String,
    default: ''
  },

  type: {
    type: String,
    default: 'user'
  },

  // ADD THE CART
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

module.exports = mongoose.model('User', userSchema);