<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Inscription</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding-top: 40px;
        }

        form {
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 15px;
            color: #444;
            font-weight: 500;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-top: 5px;
            font-size: 15px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #1976d2;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #125ca1;
        }

        .message {
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
        }

        .message.success { color: green; }
        .message.error { color: red; }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #1976d2;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .adherent-only {
            display: block;
        }

        @media (max-width: 600px) {
            form {
                padding: 20px;
            }
        }
    </style>

    <script>
        function toggleFields() {
            const type = document.getElementById("type").value;
            const adherentFields = document.querySelectorAll(".adherent-only");
            adherentFields.forEach(field => {
                field.style.display = (type === "bibliothecaire") ? "none" : "block";
            });
        }

        window.addEventListener("DOMContentLoaded", () => {
            document.getElementById("type").addEventListener("change", toggleFields);
            toggleFields();
        });
    </script>
</head>
<body>
<form action="/signup" method="post">
    <h2>Créer un compte</h2>

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <label>Nom:
        <input type="text" name="nom" required>
    </label>

    <label>Prénom:
        <input type="text" name="prenom" required>
    </label>

    <label>Email:
        <input type="email" name="email" required>
    </label>

    <label>Mot de passe:
        <input type="password" name="mdp" required>
    </label>

    <div class="adherent-only">
        <label>Téléphone:
            <input type="text" name="telephone">
        </label>
    </div>

    <div class="adherent-only">
        <label>Date de naissance:
            <input type="date" name="datenaissance">
        </label>
    </div>

    <div class="adherent-only">
        <label>Profil :
            <select name="idProfilAdherent">
                <option value="1">Étudiant</option>
                <option value="2">Professeur</option>
                <option value="3">Chercheur</option>
                <option value="4">Personnel administratif</option>
                <option value="5">Visiteur</option>
            </select>
        </label>
    </div>

    <label>Type :
        <select name="type" id="type">
            <option value="adherent">Adhérent</option>
            <option value="bibliothecaire">Bibliothécaire</option>
        </select>
    </label>

    <button type="submit">S'inscrire</button>

    <div class="message success">${message}</div>
    <div class="message error">${error}</div>

    <a href="/login">Déjà inscrit ? Se connecter</a>
</form>
</body>
</html>
