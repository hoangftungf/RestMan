<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- System Header - Common for all pages -->
<style>
    /* System Header - Blue background with logo */
    .system-header {
        background: #0066cc;
        padding: 30px 20px;
        text-align: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .system-header .logo {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
        margin-bottom: 15px;
    }

    .system-header .logo-icon {
        font-size: 3em;
    }

    .system-header .logo h1 {
        color: white;
        font-size: 3em;
        font-weight: 700;
        margin: 0;
    }

    .system-header .tagline {
        color: rgba(255, 255, 255, 0.95);
        font-size: 1.1em;
        margin: 0;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .system-header .logo {
            flex-direction: column;
            gap: 10px;
        }

        .system-header .logo h1 {
            font-size: 2em;
        }

        .system-header .tagline {
            font-size: 0.95em;
        }
    }
</style>

<header class="system-header">
    <div class="logo">
        <span class="logo-icon">🍽️</span>
        <h1>RestMan</h1>
    </div>
    <p class="tagline">Hệ Thống Quản Lý Nhà Hàng Chuyên Nghiệp</p>
</header>
