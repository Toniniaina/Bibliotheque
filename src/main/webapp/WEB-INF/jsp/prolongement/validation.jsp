<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="section">
    <h2 class="section-title">
        <i data-lucide="check-circle"></i> Validation des prolongements
    </h2>

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

    <table class="min-w-full border-collapse border border-gray-300">
        <thead>
            <tr>
                <th class="border px-4 py-2">ID Prolongement</th>
                <th class="border px-4 py-2">Emprunt #</th>
                <th class="border px-4 py-2">Date demande</th>
                <th class="border px-4 py-2">Date fin proposée</th>
                <th class="border px-4 py-2">Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="prolongement" items="${prolongementsNonValides}">
                <tr>
                    <td class="border px-4 py-2">${prolongement.id}</td>
                    <td class="border px-4 py-2">${prolongement.idEmprunt.id}</td>
                    <td class="border px-4 py-2">${prolongement.dateProlongement}</td>
                    <td class="border px-4 py-2">${prolongement.dateFin}</td>
                    <td class="border px-4 py-2">
                        <div class="flex gap-2">
                            <form action="${pageContext.request.contextPath}/prolongement/valider" method="post" style="display: inline;">
                                <input type="hidden" name="idProlongement" value="${prolongement.id}">
                                <input type="hidden" name="valide" value="true">
                                <button type="submit" class="action-btn success">
                                    <i data-lucide="check"></i> Accepter
                                </button>
                            </form>
                            <form action="${pageContext.request.contextPath}/prolongement/valider" method="post" style="display: inline;">
                                <input type="hidden" name="idProlongement" value="${prolongement.id}">
                                <input type="hidden" name="valide" value="false">
                                <button type="submit" class="action-btn danger">
                                    <i data-lucide="x"></i> Refuser
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

