<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="section">
    <h2 class="section-title"><i data-lucide="bookmark-check"></i> Réservations à valider</h2>
    <c:if test="${empty reservations}">
        <div class="alert info">Aucune réservation à valider.</div>
    </c:if>
    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 2rem;">
        <c:forEach var="resa" items="${reservations}">
            <div class="exemplaire-card" style="background: #23272f; border-radius: 1rem; padding: 1.5rem; border: 1px solid #27272a;">
                <div style="font-size: 1.1rem; font-weight: 600; color: #60a5fa; margin-bottom: 0.5rem;">
                    Livre : ${resa.idLivre.titre}
                </div>
                <div style="margin-bottom: 0.5rem;">
                    Adhérent : <b>${resa.idAdherent.prenom} ${resa.idAdherent.nom}</b>
                </div>
                <div style="margin-bottom: 0.5rem;">
                    Date demande : <b>${resa.dateDemande}</b>
                </div>
                <div style="margin-bottom: 0.5rem;">
                    Date réservée : <b>${resa.dateExpiration}</b>
                </div>
                <form action="${pageContext.request.contextPath}/resa/valider" method="post" style="display:inline;">
                    <input type="hidden" name="idReservation" value="${resa.id}" />
                    <button type="submit" class="action-btn" style="margin-right: 0.5rem;">
                        <i data-lucide="check-circle"></i> Valider
                    </button>
                </form>
                <form action="${pageContext.request.contextPath}/resa/annuler" method="post" style="display:inline;">
                    <input type="hidden" name="idReservation" value="${resa.id}" />
                    <button type="submit" class="action-btn" style="background:#ef4444; color:white;">
                        <i data-lucide="x-circle"></i> Annuler
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    window.addEventListener('DOMContentLoaded', () => {
        if (window.lucide && lucide.createIcons) {
            lucide.createIcons();
        }
    });
</script>
