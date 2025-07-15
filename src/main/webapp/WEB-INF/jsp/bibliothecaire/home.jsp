<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${pageName != null ? pageName : 'Dashboard'} - BiblioSys</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css" />
    <script src="${pageContext.request.contextPath}/static/js/lucide.min.js"></script>
    <style>
        :root {
            --primary-50: #eff6ff;
            --primary-100: #dbeafe;
            --primary-500: #3b82f6;
            --primary-600: #2563eb;
            --primary-700: #1d4ed8;

            --success-50: #ecfdf5;
            --success-100: #d1fae5;
            --success-500: #10b981;
            --success-600: #059669;

            --warning-50: #fffbeb;
            --warning-100: #fef3c7;
            --warning-500: #f59e0b;
            --warning-600: #d97706;

            --error-50: #fef2f2;
            --error-100: #fee2e2;
            --error-500: #ef4444;
            --error-600: #dc2626;

            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-400: #9ca3af;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --gray-950: #0a0a0a;

            --surface-primary: #0f0f0f;
            --surface-secondary: #1a1a1a;
            --surface-tertiary: #2a2a2a;
            --surface-elevated: #333333;

            --text-primary: #ffffff;
            --text-secondary: #d1d5db;
            --text-tertiary: #9ca3af;

            --border-primary: #333333;
            --border-secondary: #404040;

            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            --shadow-2xl: 0 25px 50px -12px rgb(0 0 0 / 0.25);

            --radius-sm: 0.375rem;
            --radius-md: 0.5rem;
            --radius-lg: 0.75rem;
            --radius-xl: 1rem;
            --radius-2xl: 1.5rem;

            --transition-fast: 150ms cubic-bezier(0.4, 0, 0.2, 1);
            --transition-normal: 300ms cubic-bezier(0.4, 0, 0.2, 1);
            --transition-slow: 500ms cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        *::before,
        *::after {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: linear-gradient(135deg, var(--gray-950) 0%, var(--gray-900) 100%);
            color: var(--text-primary);
            min-height: 100vh;
            font-weight: 400;
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .dashboard {
            display: flex;
            min-height: 100vh;
            position: relative;
        }

        /* Mobile Menu Toggle */
        .mobile-menu-toggle {
            display: none;
            position: fixed;
            top: 1rem;
            left: 1rem;
            z-index: 1100;
            background: var(--surface-tertiary);
            border: 1px solid var(--border-primary);
            border-radius: var(--radius-lg);
            padding: 0.75rem;
            color: var(--text-primary);
            cursor: pointer;
            transition: all var(--transition-fast);
            backdrop-filter: blur(10px);
        }

        .mobile-menu-toggle:hover {
            background: var(--surface-elevated);
            transform: scale(1.05);
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, var(--surface-primary) 0%, var(--surface-secondary) 100%);
            border-right: 1px solid var(--border-primary);
            box-shadow: var(--shadow-2xl);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            overflow-x: hidden;
            z-index: 1000;
            transition: transform var(--transition-normal);
            backdrop-filter: blur(20px);
        }

        .sidebar::-webkit-scrollbar {
            width: 4px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: transparent;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: var(--border-secondary);
            border-radius: 2px;
        }

        .sidebar::-webkit-scrollbar-thumb:hover {
            background: var(--text-tertiary);
        }

        .sidebar-header {
            padding: 2rem 1.5rem;
            background: linear-gradient(135deg, var(--primary-600) 0%, var(--primary-700) 100%);
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            position: relative;
            overflow: hidden;
        }

        .sidebar-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent 30%, rgba(255, 255, 255, 0.1) 50%, transparent 70%);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        .sidebar-header h1 {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: -0.025em;
        }

        .sidebar-header i {
            width: 28px;
            height: 28px;
            stroke-width: 2;
        }

        .user-info {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-primary);
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.05) 0%, transparent 100%);
        }

        .user-avatar {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-500) 0%, var(--primary-600) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 0.75rem;
            box-shadow: var(--shadow-lg);
            border: 2px solid rgba(59, 130, 246, 0.2);
            transition: all var(--transition-normal);
        }

        .user-avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 0 30px rgba(59, 130, 246, 0.3);
        }

        .user-name {
            font-weight: 600;
            font-size: 1.125rem;
            margin-bottom: 0.25rem;
            color: var(--text-primary);
        }

        .user-role {
            color: var(--text-tertiary);
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .user-role::before {
            content: '';
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--success-500);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .nav-menu {
            padding: 1.5rem 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.875rem 1.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            border-left: 3px solid transparent;
            transition: all var(--transition-fast);
            position: relative;
            margin: 0.25rem 0.75rem;
            border-radius: var(--radius-lg);
            font-weight: 500;
        }

        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.1) 0%, transparent 100%);
            border-radius: var(--radius-lg);
            opacity: 0;
            transition: opacity var(--transition-fast);
        }

        .nav-item:hover::before,
        .nav-item.active::before {
            opacity: 1;
        }

        .nav-item:hover,
        .nav-item.active {
            color: var(--text-primary);
            background: rgba(59, 130, 246, 0.1);
            border-left-color: var(--primary-500);
            transform: translateX(4px);
        }

        .nav-item i {
            width: 20px;
            height: 20px;
            stroke: currentColor;
            transition: all var(--transition-fast);
        }

        .nav-item:hover i,
        .nav-item.active i {
            transform: scale(1.1);
        }

        .logout {
            position: absolute;
            bottom: 1.5rem;
            left: 1.5rem;
            right: 1.5rem;
            background: linear-gradient(135deg, var(--error-500) 0%, var(--error-600) 100%);
            color: white;
            padding: 0.875rem;
            border: none;
            border-radius: var(--radius-xl);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            justify-content: center;
            cursor: pointer;
            transition: all var(--transition-normal);
            font-weight: 500;
            box-shadow: var(--shadow-lg);
        }

        .logout:hover {
            background: linear-gradient(135deg, var(--error-600) 0%, #b91c1c 100%);
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
        }

        .logout:active {
            transform: translateY(0);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
            background: var(--surface-primary);
            min-height: 100vh;
            transition: margin-left var(--transition-normal);
        }

        .header {
            background: linear-gradient(135deg, var(--surface-secondary) 0%, var(--surface-tertiary) 100%);
            border-radius: var(--radius-2xl);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--border-primary);
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-500) 0%, var(--primary-600) 50%, var(--primary-500) 100%);
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-tertiary);
            margin-bottom: 1rem;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .breadcrumb a {
            color: var(--text-secondary);
            text-decoration: none;
            transition: color var(--transition-fast);
        }

        .breadcrumb a:hover {
            color: var(--primary-500);
        }

        .breadcrumb i {
            width: 16px;
            height: 16px;
        }

        .header-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            letter-spacing: -0.025em;
            background: linear-gradient(135deg, var(--text-primary) 0%, var(--text-secondary) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header-subtitle {
            color: var(--text-secondary);
            font-size: 1.125rem;
            font-weight: 400;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: linear-gradient(135deg, var(--surface-secondary) 0%, var(--surface-tertiary) 100%);
            border-radius: var(--radius-xl);
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-primary);
            transition: all var(--transition-normal);
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.05) 0%, transparent 100%);
            opacity: 0;
            transition: opacity var(--transition-normal);
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-card:hover {
            transform: translateY(-4px) scale(1.02);
            box-shadow: var(--shadow-2xl);
            border-color: var(--primary-500);
        }

        .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: var(--radius-xl);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            color: white;
            transition: all var(--transition-normal);
        }

        .stat-icon.books {
            background: linear-gradient(135deg, var(--primary-500) 0%, var(--primary-600) 100%);
            box-shadow: 0 8px 32px rgba(59, 130, 246, 0.3);
        }

        .stat-icon.users {
            background: linear-gradient(135deg, var(--success-500) 0%, var(--success-600) 100%);
            box-shadow: 0 8px 32px rgba(16, 185, 129, 0.3);
        }

        .stat-icon.loans {
            background: linear-gradient(135deg, var(--warning-500) 0%, var(--warning-600) 100%);
            box-shadow: 0 8px 32px rgba(245, 158, 11, 0.3);
        }

        .stat-icon.returns {
            background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
            box-shadow: 0 8px 32px rgba(139, 92, 246, 0.3);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            letter-spacing: -0.025em;
            background: linear-gradient(135deg, var(--text-primary) 0%, var(--text-secondary) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-label {
            color: var(--text-tertiary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-weight: 600;
        }

        /* Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .section {
            background: linear-gradient(135deg, var(--surface-secondary) 0%, var(--surface-tertiary) 100%);
            border-radius: var(--radius-xl);
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-primary);
            position: relative;
            overflow: hidden;
        }

        .section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent 0%, var(--primary-500) 50%, transparent 100%);
        }

        .section-title {
            font-size: 1.375rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            width: 24px;
            height: 24px;
            color: var(--primary-500);
        }

        .recent-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.25rem;
            border-radius: var(--radius-lg);
            transition: all var(--transition-fast);
            border-left: 4px solid transparent;
            margin-bottom: 0.75rem;
            background: rgba(59, 130, 246, 0.02);
            cursor: pointer;
        }

        .recent-item:hover {
            background: rgba(59, 130, 246, 0.08);
            border-left-color: var(--primary-500);
            transform: translateX(4px);
        }

        .recent-item:not(:last-child) {
            border-bottom: 1px solid var(--border-primary);
        }

        .item-icon {
            width: 44px;
            height: 44px;
            border-radius: var(--radius-lg);
            background: linear-gradient(135deg, var(--surface-elevated) 0%, var(--border-secondary) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-500);
            transition: all var(--transition-fast);
            flex-shrink: 0;
        }

        .recent-item:hover .item-icon {
            background: linear-gradient(135deg, var(--primary-500) 0%, var(--primary-600) 100%);
            color: white;
            transform: scale(1.1);
        }

        .item-details {
            flex: 1;
            min-width: 0;
        }

        .item-details h4 {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
            font-size: 1rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .item-details p {
            color: var(--text-tertiary);
            font-size: 0.875rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .action-btn {
            background: linear-gradient(135deg, var(--surface-elevated) 0%, var(--border-secondary) 100%);
            color: var(--text-primary);
            border: 1px solid var(--border-primary);
            border-radius: var(--radius-xl);
            padding: 1.25rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            cursor: pointer;
            transition: all var(--transition-normal);
            text-decoration: none;
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, var(--primary-500) 0%, var(--primary-600) 100%);
            opacity: 0;
            transition: opacity var(--transition-normal);
        }

        .action-btn:hover::before {
            opacity: 0.1;
        }

        .action-btn:hover {
            border-color: var(--primary-500);
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
        }

        .action-btn i {
            width: 20px;
            height: 20px;
            transition: transform var(--transition-fast);
        }

        .action-btn:hover i {
            transform: scale(1.1);
        }

        /* Search Bar */
        .search-bar {
            background: var(--surface-tertiary);
            border-radius: var(--radius-xl);
            padding: 1rem 1.25rem;
            border: 1px solid var(--border-primary);
            width: 100%;
            font-size: 1rem;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            transition: all var(--transition-fast);
            font-family: inherit;
        }

        .search-bar::placeholder {
            color: var(--text-tertiary);
        }

        .search-bar:focus {
            outline: none;
            border-color: var(--primary-500);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            background: var(--surface-elevated);
        }

        /* Alerts */
        .alert {
            background: var(--surface-tertiary);
            border: 1px solid var(--border-primary);
            color: var(--text-primary);
            padding: 1.25rem;
            border-radius: var(--radius-xl);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            position: relative;
            overflow: hidden;
        }

        .alert::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--primary-500);
        }

        .alert.success::before {
            background: var(--success-500);
        }

        .alert.error::before {
            background: var(--error-500);
        }

        .alert.info::before {
            background: var(--primary-500);
        }

        .alert.warning::before {
            background: var(--warning-500);
        }

        .alert.success {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.1) 0%, rgba(16, 185, 129, 0.05) 100%);
            border-color: rgba(16, 185, 129, 0.2);
            color: #a7f3d0;
        }

        .alert.error {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.1) 0%, rgba(239, 68, 68, 0.05) 100%);
            border-color: rgba(239, 68, 68, 0.2);
            color: #fca5a5;
        }

        .alert.info {
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.1) 0%, rgba(59, 130, 246, 0.05) 100%);
            border-color: rgba(59, 130, 246, 0.2);
            color: #93c5fd;
        }

        .alert.warning {
            background: linear-gradient(135deg, rgba(245, 158, 11, 0.1) 0%, rgba(245, 158, 11, 0.05) 100%);
            border-color: rgba(245, 158, 11, 0.2);
            color: #fcd34d;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .mobile-menu-toggle {
                display: block;
            }

            .sidebar {
                transform: translateX(-100%);
                width: 100%;
                max-width: 320px;
            }

            .sidebar.mobile-open {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
                padding: 1rem;
            }

            .header {
                padding: 1.5rem;
                margin-top: 4rem;
            }

            .header-title {
                font-size: 2rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .stat-card {
                padding: 1.5rem;
            }

            .content-grid {
                gap: 1.5rem;
            }

            .section {
                padding: 1.5rem;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }
        }

        /* Loading Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Focus States */
        *:focus-visible {
            outline: 2px solid var(--primary-500);
            outline-offset: 2px;
        }

        /* Print Styles */
        @media print {
            .sidebar,
            .mobile-menu-toggle {
                display: none;
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
<!-- Mobile Menu Toggle -->
<button class="mobile-menu-toggle" onclick="toggleMobileMenu()">
    <i data-lucide="menu" id="menu-icon"></i>
    <i data-lucide="x" id="close-icon" style="display: none;"></i>
</button>

<div class="dashboard">
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <i data-lucide="library"></i>
            <h1>BiblioSys</h1>
        </div>

        <div class="user-info">
            <div class="user-avatar">
                <c:choose>
                    <c:when test="${not empty user.nom && not empty user.prenom}">
                        ${user.nom.charAt(0)}${user.prenom.charAt(0)}
                    </c:when>
                    <c:otherwise>
                        U
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="user-name">
                <c:choose>
                    <c:when test="${not empty user.nom && not empty user.prenom}">
                        ${user.prenom} ${user.nom}
                    </c:when>
                    <c:otherwise>
                        Utilisateur
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="user-role">
                <c:choose>
                    <c:when test="${not empty user.prenom}">
                        ${user.prenom}
                    </c:when>
                    <c:otherwise>
                        Bibliothécaire
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div>
        <nav class="nav-menu">

            <a href="${pageContext.request.contextPath}/abonnement/create" class="nav-item ${pageName == 'abonnement/create' ? 'active' : ''}" onclick="closeMobileMenu()">
                <i data-lucide="calendar"></i>
                Abonnements
            </a>
            <a href="${pageContext.request.contextPath}/penalite/create" class="nav-item ${pageName == 'penalite/create' ? 'active' : ''}" onclick="closeMobileMenu()">
                <i data-lucide="calendar"></i>
                Penalites
            </a>
            <a href="${pageContext.request.contextPath}/prolongement/validation" class="nav-item ${pageName == 'Catalogue' ? 'active' : ''}" onclick="closeMobileMenu()">
                <i data-lucide="book"></i>
                Prolongement
            </a>
            <a href="${pageContext.request.contextPath}/pret/create" class="nav-item ${pageName == 'pret/create' ? 'active' : ''}" onclick="closeMobileMenu()">
                <i data-lucide="bookmark"></i>
                Emprunts
            </a>
            <a href="${pageContext.request.contextPath}/resa/a_valider" class="nav-item ${pageName == '/resa/a_valider' ? 'active' : ''}" onclick="closeMobileMenu()">
                <i data-lucide="bookmark"></i>
                Reservations
            </a>
            <a href="${pageContext.request.contextPath}/rendrepret/create" class="nav-item ${pageName == 'rendrepret/create' ? 'active' : ''}" onclick="closeMobileMenu()">
                <i data-lucide="clock"></i>
                Retours
            </a>


        </nav>
        </div>
        <div>
            <form action="${pageContext.request.contextPath}/logout" method="post" style="position: absolute; bottom: 1.5rem; left: 1.5rem; right: 1.5rem;">
            <button type="submit" class="logout" onclick="return confirm('Êtes-vous sûr de vouloir vous déconnecter ?')">
                <i data-lucide="log-out"></i>
                Déconnexion
            </button>
            </form>
        </div>
    </div>
    <

    <!-- Main Content -->
    <div class="main-content">
        <div class="header fade-in">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/dashboard">Accueil</a>
                <c:if test="${not empty pageName && pageName != 'Dashboard' && pageName != null}">
                    <i data-lucide="chevron-right"></i>
                    <span>
                        <c:choose>
                            <c:when test="${pageName == '../rendrepret/create' || pageName == 'rendrepret/create'}">
                                Gestion des retours
                            </c:when>
                            <c:when test="${pageName == '../abonnement/create' || pageName == 'abonnement/create'}">
                                Abonnement
                            </c:when>
                            <c:when test="${pageName == '../penalite/create' || pageName == 'penalite/create'}">
                                Penalites
                            </c:when>
                            <c:when test="${pageName == '../prolongement/create' || pageName == 'prolongement/create'}">
                                Prolongement
                            </c:when>
                            <c:when test="${pageName == '../pret/create' || pageName == 'pret/create'}">
                                Emprunts
                            </c:when>
                            <c:when test="${pageName == '../resa/valider' || pageName == 'resa/valider' || pageName == '/resa/a_valider'}">
                                Reservations
                            </c:when>
                            <c:otherwise>
                                <c:out value="${pageName}" />
                            </c:otherwise>
                        </c:choose>
                    </span>
                </c:if>
            </div>
            <h1 class="header-title">
                <c:choose>
                    <c:when test="${pageName == 'Dashboard' || pageName == null}">
                        Bonjour <c:out value="${user.prenom != null ? user.prenom : 'Utilisateur'}" />!
                    </c:when>
                    <c:when test="${pageName == '../rendrepret/create' || pageName == 'rendrepret/create'}">
                        Gestion des retours
                    </c:when>
                    <c:when test="${pageName == '../abonnement/create' || pageName == 'abonnement/create'}">
                        Abonnement
                    </c:when>
                    <c:when test="${pageName == '../penalite/create' || pageName == 'penalite/create'}">
                        Penalites
                    </c:when>
                    <c:when test="${pageName == '../prolongement/create' || pageName == 'prolongement/create'}">
                        Prolongement
                    </c:when>
                    <c:when test="${pageName == '../pret/create' || pageName == 'pret/create'}">
                        Emprunts
                    </c:when>
                    <c:when test="${pageName == '../resa/valider' || pageName == 'resa/valider' || pageName == '/resa/a_valider'}">
                        Reservations
                    </c:when>
                    <c:otherwise>
                        <c:out value="${pageName}" />
                    </c:otherwise>
                </c:choose>
            </h1>
            <p class="header-subtitle">
                <c:choose>
                    <c:when test="${pageName == 'Dashboard' || pageName == null}">
                        Voici un aperçu de l'activité de votre bibliothèque aujourd'hui
                    </c:when>
                    <c:when test="${pageName == '../rendrepret/create'}">
                        Gestion des retours d'emprunts
                    </c:when>
                    <c:when test="${pageName == '../abonnement/create'}">
                        Gestion des abonnements
                    </c:when>
                    <c:when test="${not empty pageSubtitle}">
                        ${pageSubtitle}
                    </c:when>
                    <c:otherwise>
                        Gestion de la bibliothèque
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

        <!-- Messages d'alerte -->
        <c:if test="${not empty message}">
            <div class="alert ${messageType != null ? messageType : 'info'} fade-in">
                <i data-lucide="info"></i>
                <div>${message}</div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert error fade-in">
                <i data-lucide="alert-circle"></i>
                <div>${error}</div>
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert success fade-in">
                <i data-lucide="check-circle"></i>
                <div>${success}</div>
            </div>
        </c:if>

        <!-- Contenu spécifique à la page Dashboard -->
        <c:if test="${pageName == 'Dashboard' || pageName == null}">
            <!-- Barre de recherche -->
            <input type="text" class="search-bar fade-in" placeholder="Rechercher un livre, un adhérent..." style="animation-delay: 0.1s;">

            <!-- Actions rapides -->
            <div class="quick-actions fade-in" style="animation-delay: 0.2s;">
                <a href="${pageContext.request.contextPath}/emprunts/nouveau" class="action-btn">
                    <i data-lucide="plus-circle"></i>
                    Nouvel emprunt
                </a>
                <a href="${pageContext.request.contextPath}/adherents/nouveau" class="action-btn">
                    <i data-lucide="user-plus"></i>
                    Nouvel adhérent
                </a>
                <a href="${pageContext.request.contextPath}/rendrepret/create" class="action-btn">
                    <i data-lucide="book-minus"></i>
                    Gérer les retours
                </a>
            </div>

            <!-- Statistiques -->
            <div class="stats-grid fade-in" style="animation-delay: 0.3s;">
                <div class="stat-card">
                    <div class="stat-icon books">
                        <i data-lucide="book"></i>
                    </div>
                    <div class="stat-number">${stats.totalOuvrages != null ? stats.totalOuvrages : '12,847'}</div>
                    <div class="stat-label">Ouvrages au catalogue</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon users">
                        <i data-lucide="users"></i>
                    </div>
                    <div class="stat-number">${stats.totalAdherents != null ? stats.totalAdherents : '1,234'}</div>
                    <div class="stat-label">Adhérents actifs</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon loans">
                        <i data-lucide="bookmark"></i>
                    </div>
                    <div class="stat-number">${stats.empruntsEnCours != null ? stats.empruntsEnCours : '156'}</div>
                    <div class="stat-label">Emprunts en cours</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon returns">
                        <i data-lucide="clock"></i>
                    </div>
                    <div class="stat-number">${stats.retoursRecents != null ? stats.retoursRecents : '98'}</div>
                    <div class="stat-label">Retours récents</div>
                </div>
            </div>

            <!-- Contenu principal -->
            <div class="content-grid fade-in" style="animation-delay: 0.4s;">
                <section class="section">
                    <h2 class="section-title">
                        <i data-lucide="clock"></i>
                        Emprunts récents
                    </h2>
                    <c:choose>
                        <c:when test="${not empty recentEmprunts}">
                            <c:forEach var="emprunt" items="${recentEmprunts}" varStatus="status">
                                <div class="recent-item" style="animation-delay: ${0.5 + status.index * 0.1}s;">
                                    <div class="item-icon">
                                        <i data-lucide="book-open"></i>
                                    </div>
                                    <div class="item-details">
                                        <h4>${emprunt.ouvrage.titre}</h4>
                                        <p>
                                            Par <strong>${emprunt.adherent.nom}</strong> -
                                            <fmt:formatDate value="${emprunt.dateEmprunt}" pattern="dd/MM/yyyy" />
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="recent-item">
                                <div class="item-icon">
                                    <i data-lucide="info"></i>
                                </div>
                                <div class="item-details">
                                    <h4>Aucun emprunt récent</h4>
                                    <p>Commencez par ajouter des emprunts à votre système</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>

                <section class="section">
                    <h2 class="section-title">
                        <i data-lucide="user-check"></i>
                        Nouveaux adhérents
                    </h2>
                    <c:choose>
                        <c:when test="${not empty newAdherents}">
                            <c:forEach var="adherent" items="${newAdherents}" varStatus="status">
                                <div class="recent-item" style="animation-delay: ${0.6 + status.index * 0.1}s;">
                                    <div class="item-icon">
                                        <i data-lucide="user"></i>
                                    </div>
                                    <div class="item-details">
                                        <h4>${adherent.prenom} ${adherent.nom}</h4>
                                        <p>
                                            Inscrit le <fmt:formatDate value="${adherent.dateInscription}" pattern="dd/MM/yyyy" />
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="recent-item">
                                <div class="item-icon">
                                    <i data-lucide="user-plus"></i>
                                </div>
                                <div class="item-details">
                                    <h4>Aucun nouvel adhérent</h4>
                                    <p>Aucune nouvelle inscription récente</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>
            </div>
        </c:if>

        <!-- Inclusion dynamique d'une page si pageName est défini et différent de Dashboard -->
        <c:if test="${not empty pageName && pageName != 'Dashboard'}">
            <jsp:include page="${pageName}.jsp" />
        </c:if>

        <!-- Contenu pour autres pages peut être ajouté ici -->
    </div>
</div>

<script>
    // Initialize Lucide icons
    window.addEventListener('DOMContentLoaded', () => {
        lucide.createIcons();
    });

    // Mobile menu functionality
    function toggleMobileMenu() {
        const sidebar = document.getElementById('sidebar');
        const menuIcon = document.getElementById('menu-icon');
        const closeIcon = document.getElementById('close-icon');

        sidebar.classList.toggle('mobile-open');

        if (sidebar.classList.contains('mobile-open')) {
            menuIcon.style.display = 'none';
            closeIcon.style.display = 'block';
        } else {
            menuIcon.style.display = 'block';
            closeIcon.style.display = 'none';
        }
    }

    function closeMobileMenu() {
        const sidebar = document.getElementById('sidebar');
        const menuIcon = document.getElementById('menu-icon');
        const closeIcon = document.getElementById('close-icon');

        sidebar.classList.remove('mobile-open');
        menuIcon.style.display = 'block';
        closeIcon.style.display = 'none';
    }

    // Close mobile menu when clicking outside
    document.addEventListener('click', (e) => {
        const sidebar = document.getElementById('sidebar');
        const toggleButton = document.querySelector('.mobile-menu-toggle');

        if (window.innerWidth <= 768 &&
            sidebar.classList.contains('mobile-open') &&
            !sidebar.contains(e.target) &&
            !toggleButton.contains(e.target)) {
            closeMobileMenu();
        }
    });

    // Add fade-in animation to elements when they become visible
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all fade-in elements
    document.querySelectorAll('.fade-in').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
        observer.observe(el);
    });

    // Smooth hover effects for stat cards
    document.querySelectorAll('.stat-card').forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.transform = 'translateY(-4px) scale(1.02)';
        });

        card.addEventListener('mouseleave', () => {
            card.style.transform = 'translateY(0) scale(1)';
        });
    });

    // Enhanced search functionality
    const searchBar = document.querySelector('.search-bar');
    if (searchBar) {
        searchBar.addEventListener('input', (e) => {
            const query = e.target.value.toLowerCase();
            // Add your search logic here
            console.log('Recherche:', query);
        });
    }

    // Auto-dismiss alerts after 5 seconds
    document.querySelectorAll('.alert').forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-20px)';
            setTimeout(() => {
                alert.remove();
            }, 300);
        }, 5000);
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', (e) => {
        // Alt + S for search
        if (e.altKey && e.key === 's') {
            e.preventDefault();
            searchBar?.focus();
        }

        // Escape to close mobile menu
        if (e.key === 'Escape') {
            closeMobileMenu();
        }
    });

    // Enhanced visual feedback for interactive elements
    document.querySelectorAll('.nav-item, .action-btn, .recent-item').forEach(item => {
        item.addEventListener('click', (e) => {
            // Create ripple effect
            const ripple = document.createElement('span');
            const rect = item.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: rgba(59, 130, 246, 0.3);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s ease-out;
                    pointer-events: none;
                `;

            item.style.position = 'relative';
            item.style.overflow = 'hidden';
            item.appendChild(ripple);

            setTimeout(() => ripple.remove(), 600);
        });
    });

    // Add ripple animation
    const style = document.createElement('style');
    style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
    document.head.appendChild(style);
</script>
</body>
</html>