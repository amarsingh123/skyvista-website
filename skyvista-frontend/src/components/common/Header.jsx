import { useState } from "react";
import { Link, NavLink } from "react-router-dom";
import { useTranslation } from "react-i18next";
import "./Header.css";

export default function Header() {
  const { t, i18n } = useTranslation();
  const [menuOpen, setMenuOpen] = useState(false);
  const [servicesOpen, setServicesOpen] = useState(false);

  const isHindi = i18n.language && i18n.language.startsWith("hi");

  const toggleLang = () => {
    const nextLang = isHindi ? "en" : "hi";
    i18n.changeLanguage(nextLang);
  };

  const services = [
    { label: t("servicesMenu.customSoftware"), path: "/services/custom-software-development" },
    { label: t("servicesMenu.enterprise"), path: "/services/enterprise-solutions" },
    { label: t("servicesMenu.cloud"), path: "/services/cloud-devops" },
    { label: t("servicesMenu.ai"), path: "/services/ai-automation" },
    { label: t("servicesMenu.consulting"), path: "/services/it-consulting-support" },
  ];

  return (
    <header className="header">
      <div className="container header-inner">
        <Link to="/" className="logo">
         <img src="/src/assets/logo.svg" alt="SKYVISTA" style={{ height: "36px" }} />
        </Link>


        <nav className={`nav ${menuOpen ? "nav-open" : ""}`}>
          <NavLink to="/" end>{t("nav.home")}</NavLink>
          <NavLink to="/about">{t("nav.about")}</NavLink>

          <div
            className="nav-dropdown"
            onMouseEnter={() => setServicesOpen(true)}
            onMouseLeave={() => setServicesOpen(false)}
          >
            <NavLink to="/services">{t("nav.services")} ▾</NavLink>
            {servicesOpen && (
              <div className="dropdown-menu">
                {services.map((s) => (
                  <Link key={s.path} to={s.path}>{s.label}</Link>
                ))}
              </div>
            )}
          </div>

          <NavLink to="/portfolio">{t("nav.portfolio")}</NavLink>
          <NavLink to="/insights">{t("nav.insights")}</NavLink>
          <NavLink to="/faq">{t("nav.faq")}</NavLink>
          <NavLink to="/contact">{t("nav.contact")}</NavLink>
        </nav>

        <button className="lang-toggle" onClick={toggleLang} title="Switch Language">
          {isHindi ? "English" : "हिन्दी"}
        </button>

        <button className="menu-toggle" onClick={() => setMenuOpen(!menuOpen)}>
          ☰
        </button>
      </div>
    </header>
  );
}