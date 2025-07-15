<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Liste des adhérents</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 2rem; }
        th, td { border: 1px solid #ccc; padding: 0.7rem; text-align: left; }
        th { background: #23272f; color: #60a5fa; }
        tr:nth-child(even) { background: #f3f4f6; }
        tr:nth-child(odd) { background: #e5e7eb; }
        button.info-btn { background: #60a5fa; color: #fff; border: none; padding: 0.5rem 1rem; border-radius: 0.5rem; cursor: pointer; transition: background 0.2s; }
        button.info-btn:hover { background: #2563eb; }
        #json-modal { display: none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.5); align-items: center; justify-content: center; z-index: 1000; }
        #json-modal .modal-content { background: #fff; color: #222; padding: 2rem; border-radius: 1rem; max-width: 600px; max-height: 80vh; overflow: auto; }
        #json-modal .close-btn { float: right; background: #ef4444; color: #fff; border: none; border-radius: 0.5rem; padding: 0.3rem 0.8rem; cursor: pointer; }
        pre { background: #23272f; color: #60a5fa; padding: 1rem; border-radius: 0.5rem; overflow-x: auto; }
        .switch-btns { margin-bottom: 1rem; }
        .switch-btns button { margin-right: 0.5rem; background: #23272f; color: #60a5fa; border: none; border-radius: 0.5rem; padding: 0.3rem 1rem; cursor: pointer; }
        .switch-btns button.active { background: #60a5fa; color: #fff; }
        #html-content { display: none; }
        #json-content { display: block; }
        .html-table { width: 100%; border-collapse: collapse; }
        .html-table th, .html-table td { border: 1px solid #ccc; padding: 0.5rem; }
        .html-table th { background: #23272f; color: #60a5fa; }
    </style>
</head>
<body>
<h1>Liste des adhérents</h1>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Date de naissance</th>
        <th>Date inscription</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="adherent" items="${adherents}">
        <tr>
            <td>${adherent.id}</td>
            <td>${adherent.nom}</td>
            <td>${adherent.prenom}</td>
            <td>${adherent.dateNaissance}</td>
            <td>${adherent.dateInscription}</td>
            <td><button class="info-btn" onclick="showInfo(${adherent.id})">Infos</button></td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div id="json-modal">
    <div class="modal-content">
        <button class="close-btn" onclick="closeModal()">Fermer</button>
        <h2>Informations Adhérent</h2>
        <div class="switch-btns">
            <button id="btn-json" class="active" onclick="switchView('json')">JSON</button>
            <button id="btn-html" onclick="switchView('html')">HTML</button>
        </div>
        <pre id="json-content">Chargement...</pre>
        <div id="html-content"></div>
    </div>
</div>

<script>
let lastData = null;
function showInfo(id) {
    document.getElementById('json-modal').style.display = 'flex';
    document.getElementById('json-content').textContent = 'Chargement...';
    document.getElementById('html-content').innerHTML = '';
    switchView('json');
    fetch('/adherent/info/' + id)
        .then(resp => resp.json())
        .then(data => {
            lastData = data;
            document.getElementById('json-content').textContent = JSON.stringify(data, null, 2);
            document.getElementById('html-content').innerHTML = renderHtml(data);
        })
        .catch(() => {
            document.getElementById('json-content').textContent = 'Erreur lors du chargement des données.';
            document.getElementById('html-content').innerHTML = '<span style="color:red">Erreur lors du chargement des données.</span>';
        });
}
function closeModal() {
    document.getElementById('json-modal').style.display = 'none';
}
function switchView(view) {
    if(view === 'json') {
        document.getElementById('json-content').style.display = 'block';
        document.getElementById('html-content').style.display = 'none';
        document.getElementById('btn-json').classList.add('active');
        document.getElementById('btn-html').classList.remove('active');
    } else {
        document.getElementById('json-content').style.display = 'none';
        document.getElementById('html-content').style.display = 'block';
        document.getElementById('btn-json').classList.remove('active');
        document.getElementById('btn-html').classList.add('active');
    }
}
function renderHtml(data) {
    if(!data || typeof data !== 'object') return '<em>Aucune donnée</em>';
    let html = '<div style="font-family:Inter,Arial,sans-serif;max-width:500px;">';
    html += '<h3 style="color:#2563eb;margin-bottom:0.5em;">Fiche Adhérent</h3>';
    html += '<div style="margin-bottom:1em;">';
    html += '<b>Abonnement :</b><br/>';
    html += 'Début : <span>' + (data.dateDebutAbonnement || '-') + '</span><br/>';
    html += 'Fin : <span>' + (data.dateFinAbonnement || '-') + '</span>';
    html += '</div>';
    html += '<div style="margin-bottom:1em;">';
    html += '<b>Quota :</b> ' + (data.quota != null ? data.quota : '-') + '<br/>';
    html += '<b>Quota restant :</b> ' + (data.quotaRestant != null ? data.quotaRestant : '-') + '<br/>';
    html += '</div>';
    html += '<div style="margin-bottom:1em;">';
    html += '<b>Pénalité :</b> ' + (data.penalise ? '<span style="color:#ef4444">Oui</span>' : 'Non') + '<br/>';
    if(data.penalise) {
        html += 'Du <span>' + (data.dateDebutPenalite || '-') + '</span> au <span>' + (data.dateFinPenalite || '-') + '</span><br/>';
    }
    html += '</div>';
    html += '<div style="margin-bottom:1em;">';
    html += '<b>Exemplaires prêtés :</b>';
    if(Array.isArray(data.exemplairesPretes) && data.exemplairesPretes.length > 0) {
        html += '<ul style="margin:0.5em 0 0 1em;">';
        data.exemplairesPretes.forEach(function(ex) {
            html += '<li>'; 
            if(ex.livreTitre) html += '<b>' + ex.livreTitre + '</b>'; 
            if(ex.livreId) html += ' (ID livre: ' + ex.livreId + ')';
            if(Array.isArray(ex.exemplaires)) {
                ex.exemplaires.forEach(function(e) {
                    html += '<br/><span style="font-size:0.95em;color:#666;">Exemplaire ID: ' + (e.id || '-') + ', Quantité: ' + (e.quantite || '-') + '</span>';
                });
            }
            html += '</li>';
        });
        html += '</ul>';
    } else {
        html += ' Aucun exemplaire en cours.';
    }
    html += '</div>';
    html += '</div>';
    return html;
}
</script>
</body>
</html> 