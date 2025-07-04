<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="section">
    <h2 class="section-title"><i data-lucide="home"></i> Tableau de bord adhérent</h2>
    <p>
        Bienvenue sur votre espace adhérent.<br>
        Ici vous pouvez consulter vos emprunts, réservations, et informations personnelles.
    </p>
    <!-- Ajoutez ici des liens ou des widgets pour l'adhérent -->
    <ul>
        <li><a href="${pageContext.request.contextPath}/pret/create">Faire un nouvel emprunt</a></li>
        <li><a href="${pageContext.request.contextPath}/resa/create?adherentId=${user.id}">Déposer une réservation</a></li>
        <!-- Ajoutez d'autres liens utiles -->
    </ul>
</div>
