<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="section">
    <h2 class="section-title"><i data-lucide="check-circle"></i> Rendre un emprunt</h2>
    <c:if test="${not empty error}">
        <div class="alert error"><span>${error}</span></div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert success"><span>${success}</span></div>
    </c:if>
    <form action="${pageContext.request.contextPath}/rendrepret/save" method="post" class="form-style">
        <div class="form-group">
            <label for="empruntId">Sélectionner l'emprunt à rendre :</label>
            <select id="empruntId" name="empruntId" required class="search-bar">
                <option value="">-- Sélectionner un emprunt --</option>
                <c:forEach var="e" items="${emprunts}">
                    <option value="${e.id}">
                        Emprunt #${e.id} - Livre: ${e.livreTitre} - Adhérent: ${e.adherentNom} ${e.adherentPrenom}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="dateMouvement">Date de retour effective :</label>
            <input type="datetime-local" id="dateMouvement" name="dateMouvement" class="search-bar" required />
        </div>
        <div style="margin-top: 20px;">
            <button type="submit" class="action-btn">
                <i data-lucide="save"></i>
                Valider le retour
            </button>
        </div>
    </form>
</div>
<script>
    window.addEventListener('DOMContentLoaded', () => {
        if (window.lucide && lucide.createIcons) {
            lucide.createIcons();
        }
    });
</script>
