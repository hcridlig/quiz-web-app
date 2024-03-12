// LoginComponent.js
import React from "react";
import "./classement.css";
import "./nav.css";

const LoginComponent = () => {
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
        <h1>Connexion</h1>
        {/* Ajoutez le formulaire de connexion ici */}
      </main>
    </div>
  );
};

export default LoginComponent;
