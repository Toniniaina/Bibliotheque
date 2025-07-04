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
    <form action="${pageContext.request.contextPath}/resa/save" method="post" class="form-style">
        <input type="hidden" name="adherentId" value="${adherentId}" />
        <div class="form-group">
            <label for="idExemplaire">Exemplaire :</label>
            <select id="idExemplaire" name="idExemplaire" required class="search-bar">
                <option value="">-- Sélectionner un exemplaire --</option>
                <c:forEach var="ex" items="${exemplaires}">
                    <option value="${ex.id}">
                        ${ex.livreTitre} (Exemplaire #${ex.id}) - Stock: ${ex.quantite}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="dateExpiration">Date d'expiration :</label>
            <input type="date" id="dateExpiration" name="dateExpiration" class="search-bar" required />
        </div>
        <div style="margin-top: 20px;">
            <button type="submit" class="action-btn">
                <i data-lucide="save"></i>
                Déposer la réservation
            </button>
        </div>
    </form>
</div>
