import React from 'react';

const CategoriesPage = () => {
  const categories = [
    { id: 1, name: 'Sports', image: 'https://example.com/sports.jpg' },
    { id: 2, name: 'Histoire', image: 'https://example.com/histoire.jpg' },
    { id: 3, name: 'Musique', image: 'https://example.com/musique.jpg' },
    // Ajoutez autant de catégories que vous voulez
  ];

  return (
    <div>
      <h1>Choisissez une catégorie</h1>
      <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'center' }}>
        {categories.map((category) => (
          <div key={category.id} style={{ margin: '1rem', textAlign: 'center' }}>
            <img src={category.image} alt={category.name} style={{ width: '200px', height: '200px', objectFit: 'cover' }} />
            <h2>{category.name}</h2>
            <button style={{ backgroundColor: '#4CAF50', color: '#fff', cursor: 'pointer', fontSize: '1rem', padding: '0.5rem 1rem', borderRadius: '5px', transition: 'background-color 0.3s ease' }}>Sélectionner</button>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CategoriesPage;