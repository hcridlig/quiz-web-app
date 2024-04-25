import React, { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { Button, Menu, MenuItem, IconButton } from '@mui/material';
import {
  ExitToApp as ExitToAppIcon,
  ManageAccounts as ManageAccountsIcon,
  SupervisorAccount as SupervisorAccountIcon,
  Add as AddIcon,
  EmojiEventsIcon as RankIcon
} from '@mui/icons-material';
import EmojiEventsIcon from '@mui/icons-material/EmojiEvents';
import HistoryIcon from '@mui/icons-material/History';
import { maxHeight } from '@mui/system';

const Navbar = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const navigate = useNavigate();
  const [anchorEl, setAnchorEl] = useState(null);
  const [authenticated, setAuthenticated] = useState(false);
  const [username, setUsername] = useState('');
  const [isAdmin, setIsAdmin] = useState(false);
  const [loading, setLoading] = useState(true); // Add loading state

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
          const response = await fetch(`${apiUrl}/users/get-player-infos`, {
            method: 'GET',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${getTokenFromCookie()}`,
            },
          });
          if (response.ok) {
            const data = await response.json();
            setUsername(data.playerName);
            setIsAdmin(data.playerRole);
            localStorage.setItem('playerId', data.playerId);
            localStorage.setItem('playerName', data.playerName);
            setAuthenticated(true);
          } else {
            setAuthenticated(false);
          }
        } catch (error) {
          console.error('Error checking authentication:', error);
          setAuthenticated(false);
        } finally {
          setLoading(false); // Set loading to false once the authentication check is complete
        }
      } else {
        setLoading(false); // Set loading to false if no token found
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

  const handleSignin = () => {
    navigate('/signin');
  };

  const handleRegister = () => {
    navigate('/signup');
  };

  const handleLogout = () => {
    // Clear authentication status
    setAuthenticated(false);
    // Clear any user-related data
    setUsername('');
    // Clear token cookie
    document.cookie = 'token=;expires=Thu, 01 Jan 1970 00:00:00 GMT;';
    localStorage.removeItem('playerId');
    localStorage.removeItem('playerName');
    localStorage.clear();
  };

  const handleProfile = () => {
    handleClose();
    navigate('/account');
  }

  const handleClassement = () => {
    handleClose();
    navigate('/ranking');
  }

  const handleHistory = () => {
    handleClose();
    navigate('/history');
  }

  const handleAdminAction = () => {
    handleClose();
    navigate('/user-management');
  };

  const handleAddQuestion = () => {
    handleClose();
    navigate('/add-question');
  };

  if (loading) {
    return <div></div>; // Render loading indicator while checking authentication
  }

  return (
    <nav style={{ backgroundColor: 'rgba(230, 230, 230, 0.5)', display: 'flex', justifyContent: 'space-between', padding: '1rem', position: 'fixed', top: 0, left: 0, right: 0, }}>
      <Link to="/">
        <IconButton>
          <img src="logo-squizzy.png" alt="Squizzy" style={{ width: '5.5em', height: '2em' }} />
        </IconButton>
      </Link>
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
                <MenuItem onClick={handleProfile}>
                  <ManageAccountsIcon style={{ marginRight: '0.5rem' }} /> 
                  Profile
                </MenuItem>
                <MenuItem onClick={handleClassement}>
                  <EmojiEventsIcon style={{ marginRight: '0.5rem' }} /> 
                  Classement
                </MenuItem>
                <MenuItem onClick={handleHistory}>
                  <HistoryIcon style={{ marginRight: '0.5rem' }} /> 
                  Historique
                </MenuItem>
                {isAdmin && [
                  <MenuItem key="admin-action" onClick={handleAdminAction}>
                    <SupervisorAccountIcon style={{ marginRight: '0.5rem' }} />
                    Admin Action
                  </MenuItem>,
                  <MenuItem key="add-question" onClick={handleAddQuestion}>
                    <AddIcon style={{ marginRight: '0.5rem' }} />
                    Ajouter une question
                  </MenuItem>,
                ]}
                <MenuItem onClick={handleLogout}>
                  <ExitToAppIcon style={{ marginRight: '0.5rem', color: 'red' }} />
                  <span style={{ color: 'red' }}>Logout</span>
                </MenuItem>
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
                onClick={handleRegister}
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
                onClick={handleSignin}
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
