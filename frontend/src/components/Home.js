import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import CircularProgress from '@mui/material/CircularProgress';
import Skeleton from '@mui/material/Skeleton';
import {
  Typography,
  Card,
  CardContent,
  CardMedia,
  Grid,
  Container,
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
    <Container sx={{ marginTop: '8vh' }}>
      <Typography variant="h4" component="h1" sx={{ marginBottom: '2rem' }}>
        Choisissez une catégorie
      </Typography>
      {loading ? (
        <Grid container spacing={2} justifyContent="center">
          {Array.from({ length: 8 }, (_, i) => (
            <Grid item key={i} xs={12} sm={6} md={4} lg={3}>
              <Card sx={{ maxWidth: 300, boxShadow: 3, margin: '1rem 0' }}>
                <Skeleton variant="rectangular" height={180} />
                <CardContent>
                  <Skeleton variant="text" height={40} />
                  <Skeleton variant="text" height={80} />
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
      ) : (
        <Grid container spacing={2} justifyContent="center">
          {categories.map((category) => (
            <Grid item key={category.idcat} xs={12} sm={6} md={4} lg={3}>
              <Card sx={{
                maxWidth: 300,
                boxShadow: 3,
                transition: 'transform 0.3s ease',
                '&:hover': {
                  transform: 'scale(1.05)',
                  boxShadow: 5,
                  cursor: 'pointer',
                },
                margin: '1rem 0',
              }} onClick={() => handleCategorySelect(category.title)}>
                <CardMedia
                  component="img"
                  height="180"
                  image={category.image}
                  alt={category.title}
                />
                <CardContent>
                  <Typography gutterBottom variant="h5" component="div">
                    {category.title}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    {category.description}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
      )}
    </Container>
  );

};

export default CategoriesPage;
