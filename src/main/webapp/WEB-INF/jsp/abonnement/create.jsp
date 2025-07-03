<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="section">
    <h2 class="section-title"><i data-lucide="plus-circle"></i> Nouvel abonnement</h2>
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

    <form action="${pageContext.request.contextPath}/abonnement/save" method="post" class="form-style">
        <div class="form-group">
            <label for="adherent">Adhérent :</label>
            <select id="adherent" name="adherent" required class="search-bar">
                <option value="">-- Sélectionner un adhérent --</option>
                <c:forEach var="a" items="${adhe}">
                    <option value="${a.id}">${a.nom} ${a.prenom}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="dateDebut">Date de début :</label>
            <input type="date" id="dateDebut" name="dateDebut" class="search-bar" required />
        </div>

        <div class="form-group">
            <label for="dateFin">Date de fin :</label>
            <input type="date" id="dateFin" name="dateFin" class="search-bar" required />
        </div>

        <div style="margin-top: 20px;">
            <button type="submit" class="action-btn">
                <i data-lucide="save"></i>
                Enregistrer l'abonnement
            </button>
        </div>
    </form>
</div>
