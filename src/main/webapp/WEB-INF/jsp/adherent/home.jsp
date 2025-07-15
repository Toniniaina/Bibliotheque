<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Accueil Adhérent</title>
    <!-- Utilisation d'un CSS local -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css" />
    <script src="${pageContext.request.contextPath}/static/js/lucide.min.js"></script>
</head>
<body>
<div class="dashboard">
    <aside class="sidebar">
        <h2><i data-lucide="user"></i> Espace adhérent</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/adherent/home" class="active"><i data-lucide="home"></i> Tableau de bord</a>
            <a href="${pageContext.request.contextPath}/resa/create?adherentId=${user.id}"><i data-lucide="bookmark"></i> Réserver un exemplaire</a>
            <a href="${pageContext.request.contextPath}/prolongement/create"><i data-lucide="bookmark"></i> Prolonger un pret</a>
            <!-- Ajoutez d'autres liens si besoin -->
        </nav>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit" class="logout"><i data-lucide="log-out"></i> Déconnexion</button>
        </form>
    </aside>
    <main class="main-content">
        <c:choose>
            <c:when test="${empty pageName || pageName == 'Dashboard'}">
                <div class="header">
                    <h1>Bonjour, <c:out value="${user.prenom}"/> !</h1>
                    <p>Bienvenue sur votre tableau de bord personnel.</p>
                </div>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i data-lucide="book"></i></div>
                        <div class="stat-number">${stats.empruntsEnCours != null ? stats.empruntsEnCours : '0'}</div>
                        <div class="stat-label">Emprunts en cours</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i data-lucide="bookmark"></i></div>
                        <div class="stat-number">${stats.reservations != null ? stats.reservations : '0'}</div>
                        <div class="stat-label">Réservations</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i data-lucide="calendar"></i></div>
                        <div class="stat-number">${stats.abonnements != null ? stats.abonnements : '0'}</div>
                        <div class="stat-label">Abonnements actifs</div>
                    </div>
                </div>
                <div class="section">
                    <h2 class="section-title"><i data-lucide="activity"></i> Actions rapides</h2>
                    <ul class="links">
                        <li><a href="${pageContext.request.contextPath}/pret/create">Faire un nouvel emprunt</a></li>
                        <li><a href="${pageContext.request.contextPath}/resa/create?adherentId=${user.id}">Déposer une réservation</a></li>
                    </ul>
                </div>
                <div class="section">
                    <h2 class="section-title"><i data-lucide="info"></i> Infos personnelles</h2>
                    <ul class="links">
                        <li>Nom : <b>${user.nom}</b></li>
                        <li>Prénom : <b>${user.prenom}</b></li>
                        <li>Date de naissance : <b>${user.dateNaissance}</b></li>
                        <li>Date d'inscription : <b>${user.dateInscription}</b></li>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <jsp:include page="${pageName}.jsp" />
            </c:otherwise>
        </c:choose>
    </main>
</div>
<script>
    window.addEventListener('DOMContentLoaded', () => {
        if (window.lucide && lucide.createIcons) {
            lucide.createIcons();
        }
    });
</script>
</body>
</html>
