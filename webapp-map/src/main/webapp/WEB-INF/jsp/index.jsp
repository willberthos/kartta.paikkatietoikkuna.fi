<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:useBean id="props" class="fi.nls.oskari.util.PropertyUtil"/>

<!DOCTYPE html>
<html lang="${language}" xmlns:og="http://ogp.me/ns#" >
<head>
    <title>${viewName}</title>
    <link rel="shortcut icon" href="/static/img/pti_icon.png" type="image/png" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:if test="${language == 'fi'}">
        <meta name="Description" CONTENT="Paikkatietoikkuna on kansallinen paikkatietoportaali, joka esittelee paikkatietoaineistoja ja -palveluja sekä niiden hyödyntämismahdollisuuksia." />
    </c:if>
    <c:if test="${language == 'sv'}">
        <meta name="Description" CONTENT="Paikkatietoikkuna är vår nationella geodataportal som presenterar geodatamaterial och relaterade tjänster samt hur man kan utnyttja dem." />
    </c:if>
    <c:if test="${language == 'en'}">
        <meta name="Description" CONTENT="Paikkatietoikkuna is the national geoportal presenting spatial data and related services and the ways these can be used." />
    </c:if>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="keywords" content="Paikkatieto, kartat, maps, GIS, geoportal, Oskari" />
    <meta property="og:image" content="${props.getOptional('oskari.domain')}/static/paikkis.png" />
    <meta property="og:image:width" content="1140" />
    <meta property="og:image:height" content="1140" />


    <!-- ############# css ################# -->
    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/icons.css"/>

    <style type="text/css">
        @media screen {
            body {
                margin: 0;
                padding: 0;
            }

            #content {
                position: relative;
            }

            #sidebar {
                background-color: #FFDE00;
                width: 40px;
                position: fixed;
                display: block;
                z-index: 3;
                height: 100%;
                margin-left: -40px;
            }

            #pti-icon {
                height: 25px;
                margin-top: 25px;
                margin-left: 10px;
            }

            #pti-name {
                width: 135px;
                margin-top: 15px;
                margin-left: 15px;
                margin-bottom: 7px;
            }

            #mapContainer {
                display: block;
            }

            #mapdiv {
                width: 100%;
            }

            #maptools {
                background-color: #333438;
                height: 100%;
                position: absolute;
                top: 0;
                width: 153px;
                z-index: 2;
            }

            #contentMap {
                height: 100%;
                margin-left: 170px;
            }

            #oskari-system-messages {
                bottom: 1em;
                position: fixed;
                display: table;
                padding-left: 0.3em;
            }

            #language, #pti-feedback {
                padding: 0px 10px 0px 16px;
                color: #CCC;
            }

            #language a, #pti-feedback a {
                color: #FFDE00;
                font-size: 12px;
                cursor: pointer;
                text-decoration: underline;
            }

            #language {
                margin-bottom: 8px;
            }

        }
    </style>
    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/oskari.min.css"/>
    <!-- ############# /css ################# -->
</head>
<body class="mml-map">

<div id="wrapper">
    <div id="sidebar">
        <c:if test="${not empty language}">
            <c:set var="langParam" value="/?lang=${language}"/>
        </c:if>
        <a href="https://www.paikkatietoikkuna.fi${langParam}">
            <img id="pti-icon" src="/static/img/ikkuna.svg">
        </a>
    </div>
    <section id="content" class="floatleft">
        <nav id="maptools">
            <div id="logobar">
                <img id="pti-name" src="/static/img/paikkatietoikkuna_138px.svg">
            </div>
            <div id="menubar">
            </div>
            <div id="divider">
            </div>
            <div id="loginbar">
            </div>
            <div id="language">
                <c:if test="${language == 'fi'}">
                    <a href="javascript:void(0)" onclick="ptiUtil.changeLang('sv')">På svenska</a> -
                    <a href="javascript:void(0)" onclick="ptiUtil.changeLang('en')">In English</a>
                </c:if>
                <c:if test="${language == 'sv'}">
                    <a href="javascript:void(0)" onclick="ptiUtil.changeLang('fi')">Suomeksi</a> -
                    <a href="javascript:void(0)" onclick="ptiUtil.changeLang('en')">In English</a>
                </c:if>
                <c:if test="${language == 'en'}">
                    <a href="javascript:void(0)" onclick="ptiUtil.changeLang('fi')">Suomeksi</a> -
                    <a href="javascript:void(0)" onclick="ptiUtil.changeLang('sv')">På svenska</a>
                </c:if>
            </div>
            <div id="pti-feedback">

                <c:set var="feedbackURL" scope="page" value="${props.getWithOptionalModifier('pti.feedback.url', language)}" />
                <c:if test="${language == 'fi'}">
                    <a target="_blank" href="${feedbackURL}">Palaute tai tukipyyntö</a>
                </c:if>
                <c:if test="${language == 'sv'}">
                    <a target="_blank" href="${feedbackURL}">Respons</a>
                </c:if>
                <c:if test="${language == 'en'}">
                    <a target="_blank" href="${feedbackURL}">Feedback</a>
                </c:if>
            </div>
            <div id="toolbar">
            </div>
            <div id="oskari-system-messages"></div>
        </nav>
        <div id="contentMap" class="oskariui container-fluid">
            <div id="menutoolbar" class="container-fluid"></div>
            <div class="row-fluid oskariui-mode-content" style="height: 100%; background-color:white;">
                <div class="oskariui-left"></div>
                <div class="span12 oskariui-center" style="height: 100%; margin: 0;">
                    <div id="mapdiv"></div>
                </div>
                <div class="oskari-closed oskariui-right">
                    <div id="mapdivB"></div>
                </div>
            </div>
        </div>
    </section>
</div>


<!-- ############# Javascript ################# -->

<!--  OSKARI -->

<script type="text/javascript">
    var ajaxUrl = '${ajaxUrl}';
    var controlParams = ${controlParams};

    var ptiUtil = (function (){
        function changeLang (langCode) {
            var oldSearch = window.location.search;
            var newLang = 'lang=' + langCode;
            if (oldSearch === '') {
                return redirect('?' + newLang);
            }
            if (oldSearch.indexOf('lang=') > -1) {
                return redirect(oldSearch.replace(/lang=[^&]+/, newLang));
            }
            return redirect(oldSearch + '&' + newLang);
        };
        function redirect(search) {
            var hash = window.location.hash || '';
            window.location.href = (window.location.pathname + search + window.location.hash);
        };
        return {
            changeLang: changeLang
        }
    }());
</script>

<c:if test="${preloaded}">
    <!-- Pre-compiled application JS, empty unless created by build job -->
    <script type="text/javascript"
            src="/Oskari${path}/oskari.min.js">
    </script>
    <%--language files --%>
    <script type="text/javascript"
            src="/Oskari${path}/oskari_lang_${language}.js">
    </script>
</c:if>

<!-- ############# /Javascript ################# -->
<c:set var="ribbon" scope="page" value="${props.getOptional('page.ribbon')}" />

<c:if test="${!empty ribbon}">
    <style type="text/css">

        #demoribbon
        {
            color:white;
            background-color: red;
            z-index: 100000;
            top: 0px;
            left: 0px;
            position: fixed;
            <%--  left side --%>
            padding-left: 40px;
            margin-top: 20px;
            margin-left: -30px;
            padding-right: 40px;
            -webkit-transform: rotate(-45deg);
            -moz-transform: rotate(-45deg);
            transform: rotate(-45deg);
            <%--  right side --%>
            <%--
            margin-right: -30px;
            padding-left: 40px;
            padding-right: 40px;
            margin-top: 20px;
            -webkit-transform: rotate(45deg);
            -moz-transform: rotate(45deg);
            transform: rotate(45deg);
             --%>
        }
        #demoribbon:hover {
            display:none;
        }
    </style>
    <div id="demoribbon">${ribbon}</div>
</c:if>
</body>
</html>
