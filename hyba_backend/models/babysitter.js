const mongoose = require('mongoose');




const babysitterSchema = new mongoose.Schema({
 
  nom: {
    type: String,
    required: true
  },
  prenom: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true
  },
  password: {
    type: String,
    required: true
  },
  phone: {
    type: String,
    required: true
  },
  description: {
    type: String
  },
  accepte: {
    type: String,
    enum: ['en attente', 'acceptée', 'refusée'],
    default: 'en attente' 
  },
  rendezVous: [{
    nomParent: {
      type : String,
    },
    date: {
      type: Date,
      
    },
    heure: {
      type: String, // Ou vous pouvez utiliser le type Date si vous préférez
      
    }
   
    // Ajoutez d'autres attributs comme nécessaire
  }] // Define rendezVous as an array of rendezVousSchema
});

const Babysitter = mongoose.model('Babysitter', babysitterSchema);

module.exports = Babysitter;
