import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import CircularProgress from '@mui/material/CircularProgress';
import Cookies from 'js-cookie';

const CategoriesPage = () => {
  const navigate = useNavigate();
  const [token, setToken] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const token = Cookies.get('token');
    const timer = setTimeout(() => {
      if (!token) {
        navigate('/signin');
      } else {
        setToken(token);
        setLoading(false);
      }
    }, 500);

    return () => clearTimeout(timer);
  }, [navigate]);

  const categories = [
    { id: 1, name: 'Sports', image: 'https://example.com/sports.jpg' },
    { id: 2, name: 'Histoire', image: 'https://example.com/histoire.jpg' },
    { id: 3, name: 'Musique', image: 'https://example.com/musique.jpg' },
    // Add as many categories as you want
  ];

  if (loading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
        <CircularProgress /> {}
      </div>
    );
  }

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
