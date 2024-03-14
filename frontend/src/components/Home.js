import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import CircularProgress from '@mui/material/CircularProgress';
import Cookies from 'js-cookie';

const CategoriesPage = () => {
  const navigate = useNavigate();
  const [token, setToken] = useState('');
  const [loading, setLoading] = useState(true);
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    const token = Cookies.get('token');
    if (!token) {
      navigate('/signin');
    } else {
      setToken(token);
      setLoading(false);
    }

    fetch('https://quiz-web-app-five.vercel.app/categories')
    .then((response) => response.json())
    .then((data) => setCategories(data));

  }, [navigate]);


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
          <div key={category.idcat} style={{ flexBasis: '23%', margin: '1rem 0.5rem', textAlign: 'center' }}>
            <img src={category.image} alt={category.title} style={{ width: '200px', height: '200px', objectFit: 'cover' }} />
            <h2>{category.title}</h2>
            <p>{category.description}</p>
            <button style={{ backgroundColor: '#4CAF50', color: '#fff', cursor: 'pointer', fontSize: '1rem', padding: '0.5rem 1rem', borderRadius: '5px', transition: 'background-color 0.3s ease' }}>Sélectionner</button>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CategoriesPage;
