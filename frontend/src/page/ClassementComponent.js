// ClassementComponent.js
import React from "react";
import "./classement.css";
import "./nav.css";

const ClassementComponent = () => {
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
        <h1>Classement</h1>
        <table>
          <tr>
            <th>Classement</th>
            <th>Nom</th>
            <th>Score</th>
          </tr>
          <tr>
            <td>1</td>
            <td>John Doe</td>
            <td>100</td>
          </tr>
          <tr>
            <td>2</td>
            <td>Jane Doe</td>
            <td>90</td>
          </tr>
          {/* Ajoutez plus de lignes pour afficher plus de joueurs dans le classement */}
        </table>
      </main>
    </div>
  );
};

export default ClassementComponent;
