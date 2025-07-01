<!DOCTYPE html>
<html>
<head>
    <title>Connexion</title>
</head>
<body>
    <h2>Connexion</h2>
    <form action="/login" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <label>Email: <input type="email" name="email" required></label><br>
        <label>Mot de passe: <input type="password" name="mdp" required></label><br>
        <button type="submit">Se connecter</button>
    </form>
    <div style="color:red">${error}</div>
    <a href="/signup">Creer un compte</a>
</body>
</html>
