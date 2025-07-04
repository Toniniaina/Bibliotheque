<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="section">
    <h2 class="section-title"><i data-lucide="plus-circle"></i> Nouvelle réservation</h2>
    <c:if test="${not empty error}">
        <div class="alert error"><span>${error}</span></div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert success"><span>${success}</span></div>
    </c:if>
    <input type="hidden" id="adherentId" value="${adherentId}" />
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 2rem;">
        <c:forEach var="ex" items="${exemplaires}" varStatus="status">
            <div class="exemplaire-card" style="background: #23272f; border-radius: 1rem; padding: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.08); border: 1px solid #27272a;">
                <div style="font-size: 1.1rem; font-weight: 600; color: #60a5fa; margin-bottom: 0.5rem;">
                    ${ex.livreTitre}
                </div>
                <div style="color: #a1a1aa; margin-bottom: 0.5rem;">
                    <b>Exemplaire #${ex.id}</b>
                </div>
                <div style="margin-bottom: 0.5rem;">
                    <span style="color: #a1a1aa;">Stock :</span> <b>${ex.quantite}</b>
                </div>
                <button type="button" class="action-btn" style="margin-bottom: 0.5rem;" onclick="toggleResaForm(${status.index})">
                    <i data-lucide="bookmark-plus"></i> Réserver
                </button>
                <form action="${pageContext.request.contextPath}/resa/save" method="post" class="resa-form" id="resa-form-${status.index}" style="display:none; margin-top: 0.5rem;">
                    <input type="hidden" name="idExemplaire" value="${ex.id}" />
                    <input type="hidden" name="adherentId" value="${adherentId}" />
                    <div style="margin-bottom: 0.5rem;">
                        <label for="dateExpiration-${status.index}" style="color: #a1a1aa;">Date d'expiration :</label>
                        <input type="date" id="dateExpiration-${status.index}" name="dateExpiration" class="search-bar" required style="margin-top: 0.3rem;" />
                    </div>
                    <button type="submit" class="action-btn" style="width:100%;">
                        <i data-lucide="save"></i> Valider la réservation
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    function toggleResaForm(idx) {
        // Ferme tous les autres formulaires
        document.querySelectorAll('.resa-form').forEach(f => f.style.display = 'none');
        // Ouvre le formulaire du bon exemplaire
        var form = document.getElementById('resa-form-' + idx);
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
