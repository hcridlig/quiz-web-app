// IndexComponent.js
import React from "react";
import "./IndexComponent.css";
//import "./nav.css";

const IndexComponent = () => {
  return (
    <div>
      <header>
        <nav>
          <ul>
            <li><a href="/" id="accueil">Accueil</a></li>
            <li><a href="/classement">Classement</a></li>
            <li><a href="#">Contact</a></li>
            <li><a href="/login" id="se-connecter">Se connecter</a></li>
            <li><a href="/register" id="sinscrire">S'inscrire</a></li>
            <li><a href="/quizz" id="lancer-quizz">Lancer un quizz</a></li>
          </ul>
        </nav>
      </header>
      <main>
        <h1>Bienvenue sur notre Quizz de Culture Générale !</h1>
        <p>Découvrez notre sélection de quizz et testez vos connaissances en vous amusant !</p>
      </main>
    </div>
  );
};

export default IndexComponent;
