import React, { useState, useEffect } from 'react';
import Button from '@mui/material/Button';
import Menu from '@mui/material/Menu';
import MenuItem from '@mui/material/MenuItem';

const Navbar = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const [anchorEl, setAnchorEl] = useState(null);
  const [authenticated, setAuthenticated] = useState(false);
  const [username, setUsername] = useState('');

  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  useEffect(() => {
    const tokenCookie = document.cookie.split(';').find(cookie => cookie.trim().startsWith('token='));

    const checkAuthentication = async () => {
      if (tokenCookie) {
        try {
          const response = await fetch(`${apiUrl}/users/get-player-name`, {
            method: 'GET',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${getTokenFromCookie()}`,
            },
          });
          if (response.ok) {
            const data = await response.json();
            setUsername(data.playerName);
            setAuthenticated(true);
          } else {
            setAuthenticated(false);
          }
        } catch (error) {
          console.error('Error checking authentication:', error);
          setAuthenticated(false);
        }
      }
    };

    checkAuthentication();
  }, []);

  const getTokenFromCookie = () => {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i].trim();
      if (cookie.startsWith('token=')) {
        return cookie.substring('token='.length, cookie.length);
      }
    }
    return null;
  };

  return (
    <nav style={{ backgroundColor: 'rgba(230, 230, 230, 0.5)', display: 'flex', justifyContent: 'flex-end', padding: '1rem', position: 'fixed', top: 0, left: 0, right: 0 }}>
      <ul style={{ listStyle: 'none', margin: 0, padding: 0, display: 'flex', alignItems: 'center' }}>
        {authenticated ? (
          <>
            <li style={{ display: 'flex', alignItems: 'center' }}>
              <span style={{ marginRight: '1rem' }}>Bonjour {username}</span>
            </li>
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
                <MenuItem onClick={handleClose}>Logout</MenuItem>
              </Menu>
            </li>
          </>
        ) : (
          <>
            <li>
              <Button
                style={{ marginLeft: '1rem', display: authenticated ? 'none' : 'inline-block' }}
                variant="contained"
                color="primary"
                aria-controls="simple-menu"
                aria-haspopup="true"
                onClick={handleClick}
              >
                S'enregistrer
              </Button>
            </li>
            <li>
              <Button
                style={{ marginLeft: '1rem', display: authenticated ? 'none' : 'inline-block' }}
                variant="contained"
                color="primary"
                aria-controls="simple-menu"
                aria-haspopup="true"
                onClick={handleClick}
              >
                Se connecter
              </Button>
            </li>
          </>
        )}
      </ul>
    </nav>
  );
};

export default Navbar;
