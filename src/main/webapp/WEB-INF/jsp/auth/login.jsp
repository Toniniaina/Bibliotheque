<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Connexion</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
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
            max-width: 400px;
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
        input {
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
        .error-message {
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
            color: red;
        }
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
        @media (max-width: 600px) {
            form {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<form action="/login" method="post">
    <h2>Connexion</h2>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

    <label>Email:
        <input type="email" name="email" required />
    </label>

    <label>Mot de passe:
        <input type="password" name="mdp" required />
    </label>

    <button type="submit">Se connecter</button>

    <div class="error-message">${error}</div>

    <a href="/signup">Créer un compte</a>
</form>
</body>
</html>
