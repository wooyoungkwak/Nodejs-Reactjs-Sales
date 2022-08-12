import logo from './logo.svg';
import 'bootstrap/dist/css/bootstrap.min.css';
import { BrowserRouter, Route, Routes } from "react-router-dom";

import Login from './layout/login';
import Register from './layout/register';
import Header from './component/header';
import Footer from './component/footer';
import {Bootstrap, AddScript} from './js/dependencies';

import './App.css';

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Header />
        <Routes>
          <Route exact path='/login' element={<Login />} />
          <Route exact path='/register' element={<Register />} />
        </Routes>
        <Footer />
      </BrowserRouter>
      <AddScript />
      <Bootstrap />
    </div>
  );
}

export default App;
