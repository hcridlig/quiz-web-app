import logo from './logo.svg';
import './App.css';
import Login from './components/Login';
import Signup from './components/SignUp';
import Quiz from './components/QuizH';
import Navbar from './components/Navbar';
import Home from './components/Home';
import WaitingRoom from './components/WaitingRoom';
import Account from './components/EditUser';
import AddQuestions from './components/AddQuestion';
import UserManagement from './components/UserManagement';
import AddUser from './components/AddUser';
import Accueil from './components/Accueil';
import Ranking from './components/Ranking';
import GameHistory from './components/GameHistory';
import ResultPage from './components/ResultPage';
import { Routes , Route, useLocation } from 'react-router-dom';
import { Category } from '@mui/icons-material';

function App() {
  const location = useLocation();

  // Check if current route is signin or signup
  const hideNavbar = location.pathname === '/signin' || location.pathname === '/signup';

  return (
    <div>
      {!hideNavbar && <Navbar />}
      <Routes>
        <Route path="/category" element={<Categories />} />
        <Route path="/signin" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/game" element={<Quiz />} />
        <Route path="/waiting-room/:roomId" element={<WaitingRoom />} />
        <Route path="/account" element={<Account />} />
        <Route path="/add-question" element={<AddQuestions />} />
        <Route path="/user-management" element={<UserManagement />} />
        <Route path="/add-user" element={<AddUser />} />
        <Route path="/" element={<Accueil />} />
        <Route path="/ranking" element={<Ranking />} />
        <Route path="/history" element={<GameHistory />} />
        <Route path="/result" element={<ResultPage />} />
      </Routes>
    </div>
  );
}

export default App;
