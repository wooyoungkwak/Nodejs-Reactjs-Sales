import logo from './logo.svg';
import 'bootstrap/dist/css/bootstrap.min.css';
import './css/styles.css';
import './css/base.css';

import { BrowserRouter, Route, Routes } from "react-router-dom";

import Footer from './component/frame/footer';

import Login from './component/page/login';
import Register from './component/page/register';
import Electron from './component/page/electrons';
import Book from './component/page/books';
import Cloth from './component/page/cloths';
import Food from './component/page/foods';

import { Bootstrap, AddScript } from './js/dependencies';

import './App.css';

function App() {
  return (
    <div className="App">
          <BrowserRouter>
            <Routes>
              <Route exact path='/' element={<Login />} />
              <Route exact path='/login' element={<Login />} />
              <Route exact path='/register' element={<Register />} />
              <Route exact path='/electrons' element={<Electron />} />
              <Route exact path='/foods' element={<Food />} />
              <Route exact path='/cloths' element={<Cloth />} />
              <Route exact path='/books' element={<Book />} />
            </Routes>
          </BrowserRouter>
      <AddScript />
      <Bootstrap />
    </div>
  );
}

export default App;
