<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="section">
    <h2 class="section-title"><i data-lucide="plus-circle"></i> Nouveau prêt</h2>
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
    <form action="${pageContext.request.contextPath}/pret/save" method="post" class="form-style">
        <div class="form-group">
            <label for="adherent">Adhérent :</label>
            <select id="adherent" name="adherentId" required class="search-bar">
                <option value="">-- Sélectionner un adhérent --</option>
                <c:forEach var="a" items="${adherents}">
                    <option value="${a.id}">${a.nom} ${a.prenom}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="exemplaire">Exemplaire :</label>
            <select id="exemplaire" name="exemplaires[0].id" required class="search-bar">
                <option value="">-- Sélectionner un exemplaire --</option>
                <c:forEach var="ex" items="${exemplaires}">
                    <option value="${ex.id}">
                        <c:choose>
                            <c:when test="${not empty ex.livreTitre}">
                                ${ex.livreTitre} (ID: ${ex.livreId}) - Stock: ${ex.quantite}
                            </c:when>
                            <c:otherwise>
                                Exemplaire #${ex.id} - Stock: ${ex.quantite}
                            </c:otherwise>
                        </c:choose>
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="idTypeEmprunt">Type d'emprunt :</label>
            <select id="idTypeEmprunt" name="idTypeEmprunt" required class="search-bar">
                <option value="">-- Sélectionner un type --</option>
                <c:forEach var="t" items="${typesEmprunt}">
                    <option value="${t.id}">${t.nomType}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="datePret">Date du prêt :</label>
            <input type="datetime-local" id="datePret" name="datePret" class="search-bar" required />
        </div>
        <div class="form-group">
            <label for="dateRetourPrevue">Date de retour prévue :</label>
            <input type="datetime-local" id="dateRetourPrevue" name="dateRetourPrevue" class="search-bar" required />
        </div>
        <!-- Ajoute ici d'autres champs nécessaires (type, etc.) -->
        <div style="margin-top: 20px;">
            <button type="submit" class="action-btn">
                <i data-lucide="save"></i>
                Enregistrer le prêt
            </button>
        </div>
    </form>
</div>
