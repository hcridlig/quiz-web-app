import React, { useState } from 'react';
import Button from '@mui/material/Button';
import Menu from '@mui/material/Menu';
import MenuItem from '@mui/material/MenuItem';

const Navbar = () => {
  const [anchorEl, setAnchorEl] = useState(null);

  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  return (
    <nav style={{ backgroundColor: 'rgba(230, 230, 230, 0.5)', display: 'flex', justifyContent: 'flex-end', padding: '1rem', position: 'fixed', top: 0, left: 0, right: 0 }}>
      <ul style={{ listStyle: 'none', margin: 0, padding: 0, display: 'flex' }}>
        <li><button style={{ backgroundColor: 'transparent', border: 'none', color: '#444', cursor: 'pointer', fontSize: '1rem', marginLeft: '1rem', padding: '0.5rem 1rem', transition: 'background-color 0.3s ease' }}>S'enregistrer</button></li>
        <li><button style={{ backgroundColor: 'transparent', border: 'none', color: '#444', cursor: 'pointer', fontSize: '1rem', marginLeft: '1rem', padding: '0.5rem 1rem', transition: 'background-color 0.3s ease' }}>Se connecter</button></li>
        <li><button style={{ backgroundColor: '#4CAF50', color: '#fff', cursor: 'pointer', fontSize: '1rem', marginLeft: '1rem', padding: '0.5rem 1rem', borderRadius: '5px', transition: 'background-color 0.3s ease' }}>Lancer un quizz</button></li>
        <li>
          <Button
            variant="contained"
            color="primary"
            aria-controls="simple-menu"
            aria-haspopup="true"
            onClick={handleClick}
            style={{ marginLeft: '1rem' }}
          >
            Menu
          </Button>
          <Menu
            id="simple-menu"
            anchorEl={anchorEl}
            open={Boolean(anchorEl)}
            onClose={handleClose}
          >
            <MenuItem onClick={handleClose}>Option 1</MenuItem>
            <MenuItem onClick={handleClose}>Option 2</MenuItem>
            <MenuItem onClick={handleClose}>Option 3</MenuItem>
          </Menu>
        </li>
      </ul>
    </nav>
  );
};

export default Navbar;
