<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${pageName != null ? pageName : 'Dashboard'} - BiblioSys</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lucide/0.263.1/umd/lucide.js"></script>
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #121212;
            color: #eee;
            min-height: 100vh;
        }

        .dashboard {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background-color: #1e1e1e;
            border-right: 1px solid #333;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.8);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 24px;
            background-color: #000;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .sidebar-header h1 {
            font-size: 1.5rem;
            font-weight: 700;
        }

        .user-info {
            padding: 20px 24px;
            border-bottom: 1px solid #333;
        }

        .user-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background-color: #444;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ddd;
            font-weight: 600;
            font-size: 1.2rem;
            margin-bottom: 12px;
        }

        .user-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 4px;
            color: #ddd;
        }

        .user-role {
            color: #aaa;
            font-size: 0.9rem;
        }

        .nav-menu {
            padding: 20px 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 24px;
            color: #bbb;
            text-decoration: none;
            border-left: 3px solid transparent;
            transition: all 0.3s ease;
        }

        .nav-item:hover, .nav-item.active {
            background-color: #333;
            border-left-color: #eee;
            color: #eee;
        }

        .nav-item i {
            width: 20px;
            height: 20px;
            stroke: #bbb;
        }

        .nav-item:hover i,
        .nav-item.active i {
            stroke: #eee;
        }

        .logout {
            position: absolute;
            bottom: 24px;
            left: 24px;
            right: 24px;
            background-color: #bb2222;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
            justify-content: center;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .logout:hover {
            background-color: #991919;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 24px;
            background-color: #181818;
            color: #ddd;
        }

        .header {
            background-color: #222;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.8);
        }

        .header-title {
            font-size: 2rem;
            font-weight: 700;
            color: #eee;
            margin-bottom: 8px;
        }

        .header-subtitle {
            color: #aaa;
            font-size: 1.1rem;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #888;
            margin-bottom: 16px;
            font-size: 0.9rem;
        }

        .breadcrumb a {
            color: #ccc;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }

        .stat-card {
            background-color: #222;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.8);
            transition: transform 0.3s ease;
            color: #ddd;
        }

        .stat-card:hover {
            transform: translateY(-2px);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
            color: #fff;
            background-color: #555;
        }

        .stat-icon.books {}
        .stat-icon.users {}
        .stat-icon.loans {}
        .stat-icon.returns {}

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #eee;
            margin-bottom: 8px;
        }

        .stat-label {
            color: #aaa;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }

        .section {
            background-color: #222;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.8);
            color: #ddd;
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #eee;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .recent-item {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 16px;
            border-radius: 12px;
            transition: background 0.3s ease;
            border-left: 4px solid transparent;
            color: #ddd;
        }

        .recent-item:hover {
            background-color: #333;
            border-left-color: #eee;
        }

        .recent-item:not(:last-child) {
            border-bottom: 1px solid #333;
        }

        .item-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background-color: #555;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .item-details h4 {
            font-weight: 600;
            color: #eee;
            margin-bottom: 4px;
        }

        .item-details p {
            color: #aaa;
            font-size: 0.9rem;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }

        .action-btn {
            background-color: #444;
            color: white;
            border: none;
            border-radius: 12px;
            padding: 16px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-weight: 500;
        }

        .action-btn:hover {
            background-color: #666;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 255, 255, 0.2);
        }

        .search-bar {
            background-color: #333;
            border-radius: 12px;
            padding: 16px;
            border: 1px solid #555;
            width: 100%;
            font-size: 1rem;
            color: #eee;
            margin-bottom: 20px;
        }

        .search-bar::placeholder {
            color: #aaa;
        }

        .search-bar:focus {
            outline: none;
            border-color: #ccc;
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
            background-color: #444;
            color: #fff;
        }

        .alert {
            background-color: #333;
            border: 1px solid #555;
            color: #eee;
            padding: 16px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert.success {
            background-color: #1a3d1a;
            border-color: #2d6a2d;
            color: #b2f2b2;
        }

        .alert.error {
            background-color: #4a1a1a;
            border-color: #6a2d2d;
            color: #f2b2b2;
        }

        .alert.info {
            background-color: #1a1a4a;
            border-color: #2d2d6a;
            color: #b2b2f2;
        }

        .page-content {
            min-height: 400px;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                transform: translateX(-100%);
            }

            .main-content {
                margin-left: 0;
            }

            .content-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <i data-lucide="library"></i>
            <h1>BiblioSys</h1>
        </div>

        <div class="user-info">
            <div class="user-avatar">
                <c:choose>
                    <c:when test="${not empty user.nom && not empty user.prenom}">
                        ${user.nom.charAt(0)}${user.prenom.charAt(0)}
                    </c:when>
                    <c:otherwise>
                        U
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="user-name">
                <c:choose>
                    <c:when test="${not empty user.nom && not empty user.prenom}">
                        ${user.prenom} ${user.nom}
                    </c:when>
                    <c:otherwise>
                        Utilisateur
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="user-role">
                <c:choose>
                    <c:when test="${not empty user.nom}">
                        ${user.nom}
                    </c:when>
                    <c:otherwise>
                        Bibliothécaire
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <nav class="nav-menu">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item ${pageName == 'Dashboard' ? 'active' : ''}">
                <i data-lucide="home"></i>
                Tableau de bord
            </a>
            <a href="${pageContext.request.contextPath}/catalogue" class="nav-item ${pageName == 'Catalogue' ? 'active' : ''}">
                <i data-lucide="book"></i>
                Catalogue
            </a>
            <a href="${pageContext.request.contextPath}/adherents" class="nav-item ${pageName == 'Adherents' ? 'active' : ''}">
                <i data-lucide="users"></i>
                Adhérents
            </a>
            <a href="${pageContext.request.contextPath}/emprunts" class="nav-item ${pageName == 'Emprunts' ? 'active' : ''}">
                <i data-lucide="bookmark"></i>
                Emprunts
            </a>
            <a href="${pageContext.request.contextPath}/retours" class="nav-item ${pageName == 'Retours' ? 'active' : ''}">
                <i data-lucide="clock"></i>
                Retours
            </a>
            <a href="${pageContext.request.contextPath}/acquisitions" class="nav-item ${pageName == 'Acquisitions' ? 'active' : ''}">
                <i data-lucide="plus-circle"></i>
                Acquisitions
            </a>
            <a href="${pageContext.request.contextPath}/statistiques" class="nav-item ${pageName == 'Statistiques' ? 'active' : ''}">
                <i data-lucide="bar-chart"></i>
                Statistiques
            </a>
            <a href="${pageContext.request.contextPath}/parametres" class="nav-item ${pageName == 'Parametres' ? 'active' : ''}">
                <i data-lucide="settings"></i>
                Paramètres
            </a>
        </nav>

        <form action="${pageContext.request.contextPath}/logout" method="post" style="position: absolute; bottom: 24px; left: 24px; right: 24px;">
            <button type="submit" class="logout" onclick="return confirm('Êtes-vous sûr de vouloir vous déconnecter ?')">
                <i data-lucide="log-out"></i>
                Déconnexion
            </button>
        </form>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/dashboard">Accueil</a>
                <i data-lucide="chevron-right"></i>
                <span>${pageName != null ? pageName : 'Dashboard'}</span>
            </div>
            <h1 class="header-title">
                <c:choose>
                    <c:when test="${pageName == 'Dashboard'}">
                        Bonjour <c:out value="${user.prenom != null ? user.prenom : 'Utilisateur'}" /> !
                    </c:when>
                    <c:otherwise>
                        ${pageName}
                    </c:otherwise>
                </c:choose>
            </h1>
            <p class="header-subtitle">
                <c:choose>
                    <c:when test="${pageName == 'Dashboard'}">
                        Voici un aperçu de l'activité de votre bibliothèque aujourd'hui
                    </c:when>
                    <c:when test="${not empty pageSubtitle}">
                        ${pageSubtitle}
                    </c:when>
                    <c:otherwise>
                        Gestion de la bibliothèque
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

        <!-- Messages d'alerte -->
        <c:if test="${not empty message}">
        <div class="alert ${messageType != null ? messageType : 'info'}">
            <i data-lucide="info"></i>
            <div>${message}</div>
        </div>
        </c:if>

        <c:if test="${not empty error}">
        <div class="alert error">
            <i data-lucide="alert-circle"></i>
            <div>${error}</div>
        </div>
        </c:if>

        <c:if test="${not empty success}">
        <div class="alert success">
            <i data-lucide="check-circle"></i>
            <div>${success}</div>
        </div>
        </c:if>

        <!-- Contenu spécifique à la page Dashboard -->
        <c:if test="${pageName == 'Dashboard' || pageName == null}">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon books">
                    <i data-lucide="book"></i>
                </div>
                <div class="stat-number">${stats.totalOuvrages != null ? stats.totalOuvrages : '12,847'}</div>
                <div class="stat-label">Ouvrages au catalogue</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon users">
                    <i data-lucide="users"></i>
                </div>
                <div class="stat-number">${stats.totalAdherents != null ? stats.totalAdherents : '1,234'}</div>
                <div class="stat-label">Adhérents actifs</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon loans">
                    <i data-lucide="bookmark"></i>
                </div>
                <div class="stat-number">${stats.empruntsEnCours != null ? stats.empruntsEnCours : '156'}</div>
                <div class="stat-label">Emprunts en cours</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon returns">
                    <i data-lucide="clock"></i>
                </div>
                <div class="stat-number">${stats.retoursRecents != null ? stats.retoursRecents : '98'}</div>
                <div class="stat-label">Retours récents</div>
            </div>
        </div>

            <div class="content-grid">
                <section class="section">
                    <h2 class="section-title">
                        <i data-lucide="clock"></i>
                        Emprunts récents
                    </h2>
                    <c:if test="${not empty recentEmprunts}">
                        <c:forEach var="emprunt" items="${recentEmprunts}">
                            <div class="recent-item">
                                <div class="item-icon">
                                    <i data-lucide="book-open"></i>
                                </div>
                                <div class="item-details">
                                    <h4>${emprunt.ouvrage.titre}</h4>
                                    <p>
                                        Par <strong>${emprunt.adherent.nom}</strong> -
                                        <fmt:formatDate value="${emprunt.dateEmprunt}" pattern="dd/MM/yyyy" />
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty recentEmprunts}">
                        <p>Aucun emprunt récent.</p>
                    </c:if>
                </section>

                <section class="section">
                    <h2 class="section-title">
                        <i data-lucide="user-check"></i>
                        Nouveaux adhérents
                    </h2>
                    <c:if test="${not empty newAdherents}">
                        <c:forEach var="adherent" items="${newAdherents}">
                            <div class="recent-item">
                                <div class="item-icon">
                                    <i data-lucide="user"></i>
                                </div>
                                <div class="item-details">
                                    <h4>${adherent.prenom} ${adherent.nom}</h4>
                                    <p>
                                        Inscrit le <fmt:formatDate value="${adherent.dateInscription}" pattern="dd/MM/yyyy" />
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty newAdherents}">
                        <p>Aucun nouvel adhérent.</p>
                    </c:if>
                </section>
            </div>
        </c:if>

        <!-- Ici tu peux ajouter d'autres sections ou contenu pour d'autres pages -->

    </div>
</div>

<script>
    window.addEventListener('DOMContentLoaded', () => {
        lucide.replace();
    });
</script>
</body>
</html>


