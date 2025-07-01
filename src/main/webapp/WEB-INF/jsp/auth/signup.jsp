<!DOCTYPE html>
<html>
<head>
    <title>Inscription</title>
</head>
<body>
    <h2>Inscription</h2>
    <form action="/signup" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <label>Nom: <input type="text" name="nom" required></label><br>
        <label>Prenom: <input type="text" name="prenom" required></label><br>
        <label>Email: <input type="email" name="email" required></label><br>
        <label>Mot de passe: <input type="password" name="mdp" required></label><br>
        <label>Telephone: <input type="text" name="telephone"></label><br>
        <label>Date de naissance: <input type="date" name="datenaissance"></label><br>
        <label>
            Type:
            <select name="type">
                <option value="adherent">Adherent</option>
                <option value="bibliothecaire">Bibliothecaire</option>
            </select>
        </label><br>
        <button type="submit">S'inscrire</button>
    </form>
    <div style="color:green">${message}</div>
    <div style="color:red">${error}</div>
    <a href="/login">Deja inscrit ? Se connecter</a>
</body>
</html>
