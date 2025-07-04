<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="section">
    <h2 class="section-title"><i data-lucide="plus-circle"></i> Prolonger un prêt</h2>
    <c:if test="${not empty error}">
        <div class="alert error"><span>${error}</span></div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert success"><span>${success}</span></div>
    </c:if>
    <form action="${pageContext.request.contextPath}/prolongement/save" method="post" class="form-style">
        <div class="form-group">
            <label for="empruntId">Sélectionner le prêt :</label>
            <select id="empruntId" name="empruntId" required class="search-bar" onchange="showDateRetourPrevue(this)">
                <option value="">-- Sélectionner un prêt --</option>
                <c:forEach var="e" items="${emprunts}">
                    <option value="${e.id}"
                        data-date-retour-prevue="<c:out value='${e.dateRetourPrevue != null ? e.dateRetourPrevue : (e.date_retour_prevue != null ? e.date_retour_prevue : "")}'/>">
                        Prêt #${e.id} - Livre: ${e.idExemplaire.idLivre.titre} - Adhérent: ${e.idAdherent.nom} ${e.idAdherent.prenom}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>Date retour prévue originale :</label>
            <span id="dateRetourPrevueInfo" style="font-weight:bold; color:#60a5fa;">Sélectionnez un prêt</span>
        </div>
        <div class="form-group">
            <label for="dateFin">Nouvelle date de retour prévue :</label>
            <input type="date" id="dateFin" name="dateFin" class="search-bar" required />
        </div>
        <div style="margin-top: 20px;">
            <button type="submit" class="action-btn">
                <i data-lucide="save"></i>
                Prolonger le prêt
            </button>
        </div>
    </form>
</div>
<script>
    function showDateRetourPrevue(select) {
        var info = document.getElementById('dateRetourPrevueInfo');
        var selected = select.options[select.selectedIndex];
        var date = selected.getAttribute('data-date-retour-prevue');
        if (date) {
            info.textContent = date;
        } else {
            info.textContent = "Sélectionnez un prêt";
        }
    }
    window.addEventListener('DOMContentLoaded', () => {
        if (window.lucide && lucide.createIcons) {
            lucide.createIcons();
        }
    });
</script>
