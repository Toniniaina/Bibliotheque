<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="fr">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8" />--%>
<%--    <title>Tableau de bord adhérent</title>--%>
<%--    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">--%>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/lucide/0.263.1/umd/lucide.js"></script>--%>
<%--    <style>--%>
<%--        body {--%>
<%--            background: linear-gradient(135deg, #18181b 0%, #23272f 100%);--%>
<%--            color: #f3f4f6;--%>
<%--            font-family: 'Inter', Arial, sans-serif;--%>
<%--            margin: 0;--%>
<%--            min-height: 100vh;--%>
<%--        }--%>
<%--        .dashboard {--%>
<%--            display: flex;--%>
<%--            min-height: 100vh;--%>
<%--        }--%>
<%--        .sidebar {--%>
<%--            width: 250px;--%>
<%--            background: #18181b;--%>
<%--            border-right: 1px solid #27272a;--%>
<%--            padding: 2rem 1rem 1rem 1rem;--%>
<%--            display: flex;--%>
<%--            flex-direction: column;--%>
<%--            gap: 2rem;--%>
<%--        }--%>
<%--        .sidebar h2 {--%>
<%--            color: #60a5fa;--%>
<%--            font-size: 1.4rem;--%>
<%--            margin-bottom: 2rem;--%>
<%--            letter-spacing: 1px;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 0.5rem;--%>
<%--        }--%>
<%--        .sidebar nav {--%>
<%--            display: flex;--%>
<%--            flex-direction: column;--%>
<%--            gap: 1rem;--%>
<%--        }--%>
<%--        .sidebar a {--%>
<%--            color: #f3f4f6;--%>
<%--            text-decoration: none;--%>
<%--            padding: 0.75rem 1rem;--%>
<%--            border-radius: 0.75rem;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 0.7rem;--%>
<%--            font-weight: 500;--%>
<%--            transition: background 0.2s, color 0.2s;--%>
<%--        }--%>
<%--        .sidebar a.active, .sidebar a:hover {--%>
<%--            background: #27272a;--%>
<%--            color: #60a5fa;--%>
<%--        }--%>
<%--        .sidebar .logout {--%>
<%--            margin-top: auto;--%>
<%--            color: #f87171;--%>
<%--            background: none;--%>
<%--            border: none;--%>
<%--            padding: 0.75rem 1rem;--%>
<%--            border-radius: 0.75rem;--%>
<%--            font-weight: 500;--%>
<%--            cursor: pointer;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 0.7rem;--%>
<%--        }--%>
<%--        .sidebar .logout:hover {--%>
<%--            background: #27272a;--%>
<%--            color: #ef4444;--%>
<%--        }--%>
<%--        .main-content {--%>
<%--            flex: 1;--%>
<%--            padding: 2.5rem 2rem;--%>
<%--            background: #23272f;--%>
<%--            min-height: 100vh;--%>
<%--        }--%>
<%--        .header {--%>
<%--            margin-bottom: 2rem;--%>
<%--        }--%>
<%--        .header h1 {--%>
<%--            font-size: 2.2rem;--%>
<%--            font-weight: 700;--%>
<%--            margin-bottom: 0.5rem;--%>
<%--            color: #f3f4f6;--%>
<%--        }--%>
<%--        .header p {--%>
<%--            color: #a1a1aa;--%>
<%--            font-size: 1.1rem;--%>
<%--        }--%>
<%--        .stats-grid {--%>
<%--            display: grid;--%>
<%--            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));--%>
<%--            gap: 1.5rem;--%>
<%--            margin-bottom: 2.5rem;--%>
<%--        }--%>
<%--        .stat-card {--%>
<%--            background: linear-gradient(135deg, #18181b 0%, #27272a 100%);--%>
<%--            border-radius: 1rem;--%>
<%--            padding: 2rem 1.5rem;--%>
<%--            box-shadow: 0 4px 24px rgba(0,0,0,0.12);--%>
<%--            border: 1px solid #27272a;--%>
<%--            display: flex;--%>
<%--            flex-direction: column;--%>
<%--            align-items: flex-start;--%>
<%--            gap: 1rem;--%>
<%--        }--%>
<%--        .stat-icon {--%>
<%--            background: #60a5fa;--%>
<%--            color: #fff;--%>
<%--            border-radius: 0.75rem;--%>
<%--            width: 44px;--%>
<%--            height: 44px;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--            font-size: 1.5rem;--%>
<%--        }--%>
<%--        .stat-number {--%>
<%--            font-size: 2.2rem;--%>
<%--            font-weight: 700;--%>
<%--            color: #f3f4f6;--%>
<%--        }--%>
<%--        .stat-label {--%>
<%--            color: #a1a1aa;--%>
<%--            font-size: 0.95rem;--%>
<%--            font-weight: 500;--%>
<%--        }--%>
<%--        .quick-actions {--%>
<%--            display: flex;--%>
<%--            gap: 1.5rem;--%>
<%--            margin-bottom: 2.5rem;--%>
<%--            flex-wrap: wrap;--%>
<%--        }--%>
<%--        .action-btn {--%>
<%--            background: #18181b;--%>
<%--            color: #f3f4f6;--%>
<%--            border: 1px solid #27272a;--%>
<%--            border-radius: 0.75rem;--%>
<%--            padding: 1.2rem 1.5rem;--%>
<%--            font-weight: 500;--%>
<%--            text-decoration: none;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 0.7rem;--%>
<%--            transition: background 0.2s, color 0.2s;--%>
<%--        }--%>
<%--        .action-btn:hover {--%>
<%--            background: #27272a;--%>
<%--            color: #60a5fa;--%>
<%--        }--%>
<%--        .section {--%>
<%--            background: #18181b;--%>
<%--            border-radius: 1rem;--%>
<%--            padding: 2rem 1.5rem;--%>
<%--            margin-bottom: 2rem;--%>
<%--            border: 1px solid #27272a;--%>
<%--        }--%>
<%--        .section-title {--%>
<%--            font-size: 1.3rem;--%>
<%--            font-weight: 600;--%>
<%--            color: #60a5fa;--%>
<%--            margin-bottom: 1.2rem;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 0.5rem;--%>
<%--        }--%>
<%--        ul.links {--%>
<%--            list-style: none;--%>
<%--            padding: 0;--%>
<%--            margin: 0;--%>
<%--        }--%>
<%--        ul.links li {--%>
<%--            margin-bottom: 1rem;--%>
<%--        }--%>
<%--        ul.links a {--%>
<%--            color: #60a5fa;--%>
<%--            text-decoration: underline;--%>
<%--            font-weight: 500;--%>
<%--        }--%>
<%--        @media (max-width: 900px) {--%>
<%--            .dashboard { flex-direction: column; }--%>
<%--            .sidebar { width: 100%; flex-direction: row; gap: 1rem; }--%>
<%--            .main-content { margin-left: 0; padding: 1rem; }--%>
<%--        }--%>
<%--        @media (max-width: 600px) {--%>
<%--            .sidebar { flex-direction: column; }--%>
<%--            .main-content { padding: 0.5rem; }--%>
<%--            .stat-card, .section { padding: 1rem; }--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="dashboard">--%>
<%--    <aside class="sidebar">--%>
<%--        <h2><i data-lucide="user"></i> Espace adhérent</h2>--%>
<%--        <nav>--%>
<%--            <a href="${pageContext.request.contextPath}/adherent/home" class="active"><i data-lucide="home"></i> Tableau de bord</a>--%>
<%--            <a href="${pageContext.request.contextPath}/resa/create?adherentId=${user.id}"><i data-lucide="bookmark"></i> Réserver un exemplaire</a>--%>
<%--            <!-- Ajoutez d'autres liens si besoin -->--%>
<%--        </nav>--%>
<%--        <form action="${pageContext.request.contextPath}/logout" method="post">--%>
<%--            <button type="submit" class="logout"><i data-lucide="log-out"></i> Déconnexion</button>--%>
<%--        </form>--%>
<%--    </aside>--%>
<%--    <main class="main-content">--%>
<%--        <div class="header">--%>
<%--            <h1>Bonjour, <c:out value="${user.prenom}"/> !</h1>--%>
<%--            <p>Bienvenue sur votre tableau de bord personnel.</p>--%>
<%--        </div>--%>
<%--        <div class="stats-grid">--%>
<%--            <div class="stat-card">--%>
<%--                <div class="stat-icon"><i data-lucide="book"></i></div>--%>
<%--                <div class="stat-number">${stats.empruntsEnCours != null ? stats.empruntsEnCours : '0'}</div>--%>
<%--                <div class="stat-label">Emprunts en cours</div>--%>
<%--            </div>--%>
<%--            <div class="stat-card">--%>
<%--                <div class="stat-icon"><i data-lucide="bookmark"></i></div>--%>
<%--                <div class="stat-number">${stats.reservations != null ? stats.reservations : '0'}</div>--%>
<%--                <div class="stat-label">Réservations</div>--%>
<%--            </div>--%>
<%--            <div class="stat-card">--%>
<%--                <div class="stat-icon"><i data-lucide="calendar"></i></div>--%>
<%--                <div class="stat-number">${stats.abonnements != null ? stats.abonnements : '0'}</div>--%>
<%--                <div class="stat-label">Abonnements actifs</div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="section">--%>
<%--            <h2 class="section-title"><i data-lucide="activity"></i> Actions rapides</h2>--%>
<%--            <ul class="links">--%>
<%--                <li><a href="${pageContext.request.contextPath}/pret/create">Faire un nouvel emprunt</a></li>--%>
<%--                <li><a href="${pageContext.request.contextPath}/resa/create?adherentId=${user.id}">Déposer une réservation</a></li>--%>
<%--                <!-- Ajoutez d'autres liens utiles -->--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--        <div class="section">--%>
<%--            <h2 class="section-title"><i data-lucide="info"></i> Infos personnelles</h2>--%>
<%--            <ul class="links">--%>
<%--                <li>Nom : <b>${user.nom}</b></li>--%>
<%--                <li>Prénom : <b>${user.prenom}</b></li>--%>
<%--                <li>Date de naissance : <b>${user.dateNaissance}</b></li>--%>
<%--                <li>Date d'inscription : <b>${user.dateInscription}</b></li>--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--    </main>--%>
<%--</div>--%>
<%--<script>--%>
<%--    window.addEventListener('DOMContentLoaded', () => {--%>
<%--        lucide.createIcons();--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
