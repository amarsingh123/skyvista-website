import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import "./Footer.css";

export default function Footer() {
  const { t } = useTranslation();

  return (
    <footer className="footer section-dark">
      <div className="container grid grid-5">
        <div>
          <h4>SKYVISTA</h4>
          <p>{t("footer.tagline")}</p>
        </div>
        <div>
          <h4>{t("footer.company")}</h4>
          <ul>
            <li><Link to="/about">{t("nav.about")}</Link></li>
            <li><Link to="/portfolio">{t("nav.portfolio")}</Link></li>
            <li><Link to="/insights">{t("nav.insights")}</Link></li>
            <li><Link to="/contact">{t("nav.contact")}</Link></li>
          </ul>
        </div>
        <div>
          <h4>{t("footer.services")}</h4>
          <ul>
            <li><Link to="/services/custom-software-development">{t("servicesMenu.customSoftware")}</Link></li>
            <li><Link to="/services/enterprise-solutions">{t("servicesMenu.enterprise")}</Link></li>
            <li><Link to="/services/cloud-devops">{t("servicesMenu.cloud")}</Link></li>
            <li><Link to="/services/ai-automation">{t("servicesMenu.ai")}</Link></li>
            <li><Link to="/services/it-consulting-support">{t("servicesMenu.consulting")}</Link></li>
          </ul>
        </div>
        <div>
          <h4>{t("footer.resources")}</h4>
          <ul>
            <li><Link to="/faq">{t("nav.faq")}</Link></li>
            <li><Link to="/privacy-policy">Privacy Policy</Link></li>
            <li><Link to="/terms-conditions">Terms & Conditions</Link></li>
            <li><Link to="/cookie-policy">Cookie Policy</Link></li>
          </ul>
        </div>
        <div>
          <h4>{t("footer.contact")}</h4>
          <p>info@skyvista.com</p>
          <p>+91 90877 65544</p>
          <p>Office No. 10, District Centre, Janakpuri West, New Delhi - 110045</p>
        </div>
      </div>
      <div className="container text-center footer-bottom">
        <p>© 2025 SKYVISTA JOURNEYS LLP. {t("footer.rights")}</p>
      </div>
    </footer>
  );
}