<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="section">
    <h2 class="section-title"><i data-lucide="plus-circle"></i> Emprunts en retard à pénaliser</h2>

    <c:if test="${not empty error}">
        <div class="alert error">
            <i data-lucide="alert-circle"></i>
            <span>${error}</span>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert success">
            <i data-lucide="check-circle"></i>
            <span>${success}</span>
        </div>
    </c:if>

    <table class="min-w-full border-collapse border border-gray-300 mb-4">
        <thead>
        <tr>
            <th class="border px-4 py-2">Emprunt #</th>
            <th class="border px-4 py-2">Livre</th>
            <th class="border px-4 py-2">Adhérent</th>
            <th class="border px-4 py-2">Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="e" items="${emprunts}" varStatus="status">
            <tr>
                <td class="border px-4 py-2">${e.id}</td>
                <td class="border px-4 py-2">
                    <c:forEach var="ex" items="${e.exemplaires}">
                        ${ex.idLivre.titre} (ID: ${ex.idLivre.id})<br/>
                    </c:forEach>
                </td>
                <td class="border px-4 py-2">${e.adherentNom} ${e.adherentPrenom} (ID: ${e.adherentId})</td>
                <td class="border px-4 py-2">
                    <c:choose>
                        <c:when test="${fn:contains(penalisedEmpruntIdsAsString, e.id)}">
                            <button class="action-btn" disabled style="opacity: 0.6; cursor: not-allowed;">
                                <i data-lucide="x-circle"></i> Déjà pénalisé
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="action-btn" onclick="openPenalModal(${status.index})">
                                <i data-lucide="save"></i> Pénaliser
                            </button>
                            <!-- Modal -->
                            <div class="modal-bg" id="modal-bg-${status.index}" style="display:none; position:fixed; top:0; left:0; width:100vw; height:100vh; background:rgba(0,0,0,0.4); z-index:1000;">
                                <div class="modal-content" style="background:white; color:#222; max-width:400px; margin:10vh auto; padding:30px 20px; border-radius:10px; position:relative;">
                                    <button type="button" onclick="closePenalModal(${status.index})" style="position:absolute; top:10px; right:15px; background:none; border:none; font-size:22px; color:#888; cursor:pointer;">&times;</button>
                                    <h3 style="margin-bottom:20px;">Pénaliser l'emprunt #${e.id}</h3>
                                    <p style="margin-bottom:15px; font-size:14px; color:#666;">
                                        La date de début de pénalité sera automatiquement la date de retour effectif du livre.
                                    </p>
                                    <form action="${pageContext.request.contextPath}/penalite/save" method="post">
                                        <input type="hidden" name="emprunt.id" value="${e.id}" />
                                        <input type="hidden" name="adherent.id" value="${e.adherentId}" />
                                        <div style="margin-bottom:12px;">
                                            <label>Durée (jours) :</label>
                                            <input type="number" name="jour" min="1" required class="search-bar" />
                                        </div>
                                        <div style="margin-bottom:12px;">
                                            <label>Raison :</label>
                                            <input type="text" name="raison" class="search-bar" placeholder="Raison" />
                                        </div>
                                        <button type="submit" class="action-btn" style="width:100%;">
                                            <i data-lucide="save"></i> Enregistrer la pénalité
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    function openPenalModal(idx) {
        document.getElementById('modal-bg-' + idx).style.display = 'block';
    }
    function closePenalModal(idx) {
        document.getElementById('modal-bg-' + idx).style.display = 'none';
    }
    document.addEventListener('click', function(e) {
        document.querySelectorAll('.modal-bg').forEach(function(bg, idx) {
            if (bg.style.display === 'block' && e.target === bg) {
                closePenalModal(idx);
            }
        });
    });
</script>
