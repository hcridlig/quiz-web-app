// RegisterComponent.js
import React from "react";
import "./classement.css";
import "./nav.css";

const RegisterComponent = () => {
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
        <h1>Inscription</h1>
        {/* Ajoutez le formulaire d'inscription ici */}
      </main>
    </div>
  );
};

export default RegisterComponent;
