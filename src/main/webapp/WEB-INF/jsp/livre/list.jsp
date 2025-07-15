<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Liste des livres</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h1>Liste des livres</h1>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Titre</th>
            <th>ISBN</th>
            <th>Année</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${livres}" var="livre">
            <tr>
                <td><c:out value="${livre.titre}"/></td>
                <td><c:out value="${livre.isbn}"/></td>
                <td><c:out value="${livre.anneePublication}"/></td>
                <td>
                    <a href="${pageContext.request.contextPath}/api/exemplaire/livre/${livre.id}"
                       target="_blank"
                       class="btn btn-info btn-sm">
                        <i class="fas fa-info-circle"></i> Infos
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
