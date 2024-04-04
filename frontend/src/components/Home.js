import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import CircularProgress from '@mui/material/CircularProgress';
import {
  TextField,
  Button,
  Container,
  Typography,
  Box,
} from '@mui/material';

const CategoriesPage = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const navigate = useNavigate();
  const [token, setToken] = useState('');
  const [loading, setLoading] = useState(true);
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const response = await fetch(`${apiUrl}/categories`, {
          headers: {
            Authorization: `Bearer ${token}` // Include token in the Authorization header
          }
        });
        if (!response.ok) {
          throw new Error('Failed to fetch categories');
        }
        const data = await response.json();
        setCategories(data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching categories:', error);
        // Handle error
        setLoading(false);
      }
    };

    fetchCategories();
  }, []);

  const handleCategorySelect = (category) => {    
    // Redirect to the waiting room
    navigate('/waiting-room', { state: { category: category } });
  };

  return (
    <div style={{ marginTop: '8vh' }}> {/* Ajoutez la marge supérieure ici */}
      <Typography variant="h4" component="h1" style={{ marginLeft: '1%' }}>
        Choisissez une catégorie
      </Typography>
      {loading ? (
        <div style={{ display: 'flex', justifyContent: 'center' }}>
          <CircularProgress />
        </div>
      ) : (
        <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'center' }}>
          {categories.map((category) => (
            <div key={category.idcat} style={{ flexBasis: '23%', margin: '1rem 0.5rem', textAlign: 'center' }}>
              <img src={category.image} alt={category.title} style={{ width: '200px', height: '200px', objectFit: 'cover' }} />
              <h2>{category.title}</h2>
              <p>{category.description}</p>
              <button
                style={{ backgroundColor: '#4CAF50', color: '#fff', cursor: 'pointer', fontSize: '1rem', padding: '0.5rem 1rem', borderRadius: '5px', transition: 'background-color 0.3s ease' }}
                onClick={() => handleCategorySelect(category.title)}
              >
                Sélectionner
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );

};

export default CategoriesPage;
