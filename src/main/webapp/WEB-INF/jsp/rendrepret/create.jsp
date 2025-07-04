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
    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 2rem;">
        <c:forEach var="e" items="${emprunts}" varStatus="status">
            <div class="exemplaire-card" style="background: #23272f; border-radius: 1rem; padding: 1.5rem; border: 1px solid #27272a;">
                <div style="font-size: 1.1rem; font-weight: 600; color: #60a5fa; margin-bottom: 0.5rem;">
                    Emprunt #${e.id} - Livre: ${e.livreTitre}
                </div>
                <div style="margin-bottom: 0.5rem;">
                    Adhérent : <b>${e.adherentNom} ${e.adherentPrenom}</b>
                </div>
                <button type="button" class="action-btn" onclick="toggleRetourForm(${status.index})">
                    <i data-lucide="check-circle"></i> Rendre
                </button>
                <form action="${pageContext.request.contextPath}/rendrepret/save" method="post" class="retour-form" id="retour-form-${status.index}" style="display:none; margin-top: 0.5rem;">
                    <input type="hidden" name="empruntId" value="${e.id}" />
                    <div style="margin-bottom: 0.5rem;">
                        <label for="dateMouvement-${status.index}" style="color: #a1a1aa;">Date de retour effective :</label>
                        <input type="datetime-local" id="dateMouvement-${status.index}" name="dateMouvement" class="search-bar" required style="margin-top: 0.3rem;" />
                    </div>
                    <button type="submit" class="action-btn" style="width:100%;">
                        <i data-lucide="save"></i> Valider le retour
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    function toggleRetourForm(idx) {
        // Ferme tous les autres formulaires
        document.querySelectorAll('.retour-form').forEach(f => f.style.display = 'none');
        // Ouvre le formulaire du bon emprunt
        var form = document.getElementById('retour-form-' + idx);
        if (form) {
            form.style.display = 'block';
        }
    }
    window.addEventListener('DOMContentLoaded', () => {
        if (window.lucide && lucide.createIcons) {
            lucide.createIcons();
        }
    });
</script>
