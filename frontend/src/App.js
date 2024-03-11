import logo from './logo.svg';
import './App.css';
import Login from './components/Login';
import Signup from './components/SignUp';
import Quiz from './components/QuizH';
import Navbar from './components/Navbar';
import Home from './components/Home';
import {Routes , Route} from 'react-router-dom';

function App() {
  return (
    <div>
      <Navbar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/signin" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/quiz" element={<Quiz />} />

      </Routes>
    </div>
    
    
  );
}

export default App;
