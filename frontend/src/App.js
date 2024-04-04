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
import SocketProvider from './components/SocketProvider';
import {Routes , Route} from 'react-router-dom';

function App() {
  return (
    <div>
      <Navbar />
      <SocketProvider>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/signin" element={<Login />} />
          <Route path="/signup" element={<Signup />} />
          <Route path="/game" element={<Quiz />} />
          <Route path="/waiting-room" element={<WaitingRoom />} />
          <Route path="/account" element={<Account />} />
          <Route path="/add-question" element={<AddQuestions />} />
          <Route path="/user-management" element={<UserManagement />} />
          <Route path="/add-user" element={<AddUser />} />
        </Routes>
      </SocketProvider>
    </div>

    
  );
}

export default App;
