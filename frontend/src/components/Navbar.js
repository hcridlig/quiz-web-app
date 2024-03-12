import React from 'react';

const Navbar = () => {
  return (
    <nav style={{ backgroundColor: 'rgba(230, 230, 230, 0.5)', display: 'flex', justifyContent: 'flex-end', padding: '1rem', position: 'fixed', top: 0, left: 0, right: 0 }}>
      <ul style={{ listStyle: 'none', margin: 0, padding: 0, display: 'flex' }}>
        <li><button style={{ backgroundColor: 'transparent', border: 'none', color: '#444', cursor: 'pointer', fontSize: '1rem', marginLeft: '1rem', padding: '0.5rem 1rem', transition: 'background-color 0.3s ease' }}>S'enregistrer</button></li>
        <li><button style={{ backgroundColor: 'transparent', border: 'none', color: '#444', cursor: 'pointer', fontSize: '1rem', marginLeft: '1rem', padding: '0.5rem 1rem', transition: 'background-color 0.3s ease' }}>Se connecter</button></li>
        <li><button style={{ backgroundColor: '#4CAF50', color: '#fff', cursor: 'pointer', fontSize: '1rem', marginLeft: '0', padding: '0.5rem 1rem', borderRadius: '5px', transition: 'background-color 0.3s ease' }}>Lancer un quizz</button></li>
      </ul>
    </nav>
  );
};

export default Navbar;