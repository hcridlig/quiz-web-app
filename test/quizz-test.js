const questions = [
    {
        question: "Quelle est la capitale de la France ?",
        choices: ["Paris", "Lyon", "Marseille", "Toulouse"],
        correctAnswer: 0
    },
    {
        question: "Quel est le plus grand mammifère au monde ?",
        choices: ["Baleine bleue", "Éléphant", "Girafe", "Ours polaire"],
        correctAnswer: 0
    },
    {
        question: "Quel est le plus long fleuve du monde ?",
        choices: ["Amazone", "Nil", "Yangtsé", "Mississippi"],
        correctAnswer: 1
    },
    {
        question: "Qui a peint la Joconde ?",
        choices: ["Vincent van Gogh", "Pablo Picasso", "Leonardo da Vinci", "Claude Monet"],
        correctAnswer: 2
    },
    {
        question: "Qui a découvert l'Amérique en 1492 ?",
        choices: ["Christophe Colomb", "Vasco de Gama", "Marco Polo", "Fernand de Magellan"],
        correctAnswer: 0
    },
    {
        question: "Qui a écrit le roman '1984' ?",
        choices: ["Aldous Huxley", "George Orwell", "Ray Bradbury", "Jules Verne"],
        correctAnswer: 1
    },
    {
        question: "Quel est l'élément chimique le plus abondant dans l'univers ?",
        choices: ["Hydrogène", "Hélium", "Oxygène", "Carbone"],
        correctAnswer: 0
    },    
    // Ajoutez plus de questions si vous le souhaitez
];

// Fonction de mélange de tableau
function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}

let currentQuestion = 0;
let score = 0;

function displayQuestion() {
    const quizzContainer = document.getElementById("quizz-container");
    const questionData = questions[currentQuestion];

    quizzContainer.innerHTML = `
        <h2>${questionData.question}</h2>
        <div>
            ${questionData.choices.map((choice, index) => `<div><input type="radio" name="choice" value="${index}"> ${choice}</div>`).join("")}
        </div>
    `;
}

function displayResult() {
    const resultContainer = document.getElementById("result-container");
    const fireworksContainer = document.getElementById("fireworks-container");

    resultContainer.style.display = "block";
    document.getElementById("result-message").innerHTML = `
        <h2>Votre score : ${score} / ${questions.length}</h2>
    `;
}

document.getElementById("submit-btn").addEventListener("click", () => {
    const selectedChoice = document.querySelector('input[name="choice"]:checked');

    if (selectedChoice) {
        const userAnswer = parseInt(selectedChoice.value);

        if (userAnswer === questions[currentQuestion].correctAnswer) {
            score++;
        }

        currentQuestion++;

        if (currentQuestion < questions.length) {
            displayQuestion();
        } else {
            displayResult();
        }
    } else {
        alert("Veuillez sélectionner une réponse.");
    }
});

document.getElementById("replay-btn").addEventListener("click", () => {
    currentQuestion = 0;
    score = 0;
    displayQuestion();
    document.getElementById("result-container").style.display = "none";
});

//Mélangement des questions
shuffleArray(questions);

displayQuestion();