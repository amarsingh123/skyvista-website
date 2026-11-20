# =========================================================
# SKYVISTA JOURNEYS LLP - Frontend Setup Script (React + Vite)
# PART 1 of 6
# =========================================================

$root = "skyvista-frontend"
New-Item -ItemType Directory -Force -Path $root | Out-Null
Set-Location $root

$folders = @(
    "src\components\common",
    "src\components\home",
    "src\pages\services",
    "src\locales\en",
    "src\locales\hi",
    "src\services",
    "src\styles",
    "src\data",
    "public"
)
foreach ($f in $folders) { New-Item -ItemType Directory -Force -Path $f | Out-Null }

function Write-File($path, $content) {
    $dir = Split-Path $path
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $path -Value $content -Encoding UTF8
}


# ---------- package.json ----------
Write-File "package.json" @'
{
  "name": "skyvista-frontend",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "react-router-dom": "^6.23.1",
    "axios": "^1.7.2",
    "i18next": "^23.11.5",
    "react-i18next": "^14.1.2",
    "i18next-browser-languagedetector": "^8.0.0",
    "react-helmet-async": "^2.0.5"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.3.1",
    "vite": "^5.3.1"
  }
}
'@

# ---------- vite.config.js ----------
Write-File "vite.config.js" @'
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: { port: 5173 },
  build: { outDir: "dist" },
});
'@

# ---------- .env.example ----------
Write-File ".env.example" @'
VITE_API_BASE_URL=http://localhost:8000/api
'@

# ---------- .gitignore ----------
Write-File ".gitignore" @'
node_modules/
dist/
.env
.DS_Store
'@

# ---------- README.md ----------
Write-File "README.md" @'
# SKYVISTA JOURNEYS LLP - Frontend (React + Vite)

## Setup
1. npm install
2. copy .env.example .env
3. npm run dev

## Build for production
npm run build
(output goes to dist/ folder - upload this to S3/CloudFront or any static host)

## Pages included
- Home, About, 5 Service pages, Portfolio, Insights (Blog), FAQ, Contact
- Privacy Policy, Terms & Conditions, Cookie Policy
- EN/HI language toggle (Hindi content to be added later)
'@

# ---------- index.html ----------
Write-File "index.html" @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SKYVISTA JOURNEYS LLP | Software, Cloud & AI Solutions</title>
  <meta name="description" content="Custom software development, enterprise solutions, cloud services, and AI automation for businesses worldwide - with specialized expertise in travel technology." />
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
  <div id="root"></div>
  <script type="module" src="/src/main.jsx"></script>
</body>
</html>
'@

Write-Host "FRONTEND PART 1 COMPLETE: Folders, package.json, vite.config.js, index.html created." -ForegroundColor Green

# =========================================================
# PART 2 of 6 - main.jsx, i18n, translations, API service
# =========================================================

# ---------- src/main.jsx ----------
Write-File "src\main.jsx" @'
import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import { HelmetProvider } from "react-helmet-async";
import App from "./App.jsx";
import "./i18n";
import "./styles/global.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <HelmetProvider>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </HelmetProvider>
  </React.StrictMode>
);
'@

# ---------- src/i18n.js ----------
Write-File "src\i18n.js" @'
import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import LanguageDetector from "i18next-browser-languagedetector";
import en from "./locales/en/translation.json";
import hi from "./locales/hi/translation.json";

i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    resources: { en: { translation: en }, hi: { translation: hi } },
    fallbackLng: "en",
    interpolation: { escapeValue: false },
  });

export default i18n;
'@

# ---------- src/locales/en/translation.json ----------
Write-File "src\locales\en\translation.json" @'
{
  "nav": {
    "home": "Home",
    "about": "About Us",
    "services": "Services",
    "portfolio": "Portfolio",
    "insights": "Insights",
    "faq": "FAQ",
    "contact": "Contact Us"
  },
  "hero": {
    "heading": "Custom Software, Cloud & AI Solutions for Smarter Businesses",
    "subheading": "SKYVISTA JOURNEYS LLP helps businesses worldwide build scalable software, modernize operations, and automate workflows with AI - backed by specialized expertise in travel technology.",
    "btnPrimary": "Discuss Your Project",
    "btnSecondary": "Explore Our Services"
  },
  "footer": {
    "tagline": "Custom Software, Cloud & AI Solutions for Smarter Businesses",
    "company": "Company",
    "services": "Services",
    "resources": "Resources",
    "contact": "Contact",
    "rights": "All rights reserved."
  }
}
'@

# ---------- src/locales/hi/translation.json (placeholder - same as EN for V1) ----------
Write-File "src\locales\hi\translation.json" @'
{
  "nav": {
    "home": "Home",
    "about": "About Us",
    "services": "Services",
    "portfolio": "Portfolio",
    "insights": "Insights",
    "faq": "FAQ",
    "contact": "Contact Us"
  },
  "hero": {
    "heading": "Custom Software, Cloud & AI Solutions for Smarter Businesses",
    "subheading": "SKYVISTA JOURNEYS LLP helps businesses worldwide build scalable software, modernize operations, and automate workflows with AI - backed by specialized expertise in travel technology.",
    "btnPrimary": "Discuss Your Project",
    "btnSecondary": "Explore Our Services"
  },
  "footer": {
    "tagline": "Custom Software, Cloud & AI Solutions for Smarter Businesses",
    "company": "Company",
    "services": "Services",
    "resources": "Resources",
    "contact": "Contact",
    "rights": "All rights reserved."
  }
}
'@

# ---------- src/services/api.js ----------
Write-File "src\services\api.js" @'
import axios from "axios";

const API_BASE = import.meta.env.VITE_API_BASE_URL || "http://localhost:8000/api";

const api = axios.create({ baseURL: API_BASE, timeout: 10000 });

export const submitEnquiry = (data) => api.post("/enquiries/", data);
export const getBlogPosts = (category = "") =>
  api.get(`/blog/${category ? `?category=${category}` : ""}`);
export const getBlogPost = (slug) => api.get(`/blog/${slug}/`);
export const getCaseStudies = (category = "") =>
  api.get(`/portfolio/${category ? `?service_category=${category}` : ""}`);
export const getFAQs = () => api.get("/faq/");

export default api;
'@

Write-Host "FRONTEND PART 2 COMPLETE: main.jsx, i18n, translations, api.js created." -ForegroundColor Green


# =========================================================
# PART 3 of 6 - Global CSS + Header Component
# =========================================================

# ---------- src/styles/variables.css ----------
Write-File "src\styles\variables.css" @'
:root {
  --color-navy: #0B1F3A;
  --color-sky-blue: #1FA9E5;
  --color-indigo: #4B5CFF;
  --color-white: #FFFFFF;
  --color-bg-light: #F6F9FC;
  --color-slate: #475569;
  --color-slate-light: #94A3B8;
  --color-border: #E2E8F0;
  --color-teal: #14B8A6;
  --color-error: #EF4444;
  --color-success: #22C55E;

  --font-heading: "Sora", sans-serif;
  --font-body: "Inter", sans-serif;

  --text-h1: 48px;
  --text-h2: 36px;
  --text-h3: 24px;
  --text-h4: 20px;
  --text-body: 16px;
  --text-small: 14px;

  --space-xs: 8px;
  --space-sm: 16px;
  --space-md: 24px;
  --space-lg: 40px;
  --space-xl: 64px;
  --space-2xl: 96px;

  --radius: 12px;
  --max-width: 1200px;
}

@media (max-width: 768px) {
  :root {
    --text-h1: 32px;
    --text-h2: 28px;
    --text-h3: 20px;
  }
}
'@

# ---------- src/styles/global.css ----------
Write-File "src\styles\global.css" @'
@import "./variables.css";

* { box-sizing: border-box; margin: 0; padding: 0; }

body {
  font-family: var(--font-body);
  color: var(--color-slate);
  background: var(--color-white);
  line-height: 1.6;
}

h1, h2, h3, h4 {
  font-family: var(--font-heading);
  color: var(--color-navy);
  line-height: 1.2;
}

h1 { font-size: var(--text-h1); font-weight: 700; }
h2 { font-size: var(--text-h2); font-weight: 700; }
h3 { font-size: var(--text-h3); font-weight: 600; }
h4 { font-size: var(--text-h4); font-weight: 600; }

a { text-decoration: none; color: inherit; }
button { font-family: var(--font-body); cursor: pointer; border: none; }
ul { list-style: none; }

.container {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 0 var(--space-md);
}

.section { padding: var(--space-2xl) 0; }
.section-light { background: var(--color-bg-light); }
.section-dark { background: var(--color-navy); color: var(--color-white); }
.section-dark h1, .section-dark h2, .section-dark h3 { color: var(--color-white); }

.text-center { text-align: center; }

.btn-primary {
  display: inline-block;
  background: var(--color-sky-blue);
  color: var(--color-white);
  padding: 14px 28px;
  border-radius: 8px;
  font-weight: 600;
  transition: background 0.2s ease;
}
.btn-primary:hover { background: var(--color-indigo); }

.btn-secondary {
  display: inline-block;
  background: transparent;
  color: var(--color-navy);
  border: 2px solid var(--color-navy);
  padding: 12px 26px;
  border-radius: 8px;
  font-weight: 600;
  transition: all 0.2s ease;
}
.btn-secondary:hover { background: var(--color-navy); color: var(--color-white); }

.section-dark .btn-secondary {
  color: var(--color-white);
  border-color: var(--color-white);
}
.section-dark .btn-secondary:hover {
  background: var(--color-white);
  color: var(--color-navy);
}

.card {
  background: var(--color-white);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  padding: var(--space-md);
  box-shadow: 0 2px 8px rgba(11, 31, 58, 0.06);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.card:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(11, 31, 58, 0.12); }

.grid {
  display: grid;
  gap: var(--space-md);
}
.grid-5 { grid-template-columns: repeat(5, 1fr); }
.grid-3 { grid-template-columns: repeat(3, 1fr); }
.grid-2 { grid-template-columns: repeat(2, 1fr); }

@media (max-width: 1024px) {
  .grid-5, .grid-3 { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 600px) {
  .grid-5, .grid-3, .grid-2 { grid-template-columns: 1fr; }
}

.hero-visual-placeholder {
  width: 100%;
  min-height: 320px;
  background: linear-gradient(135deg, var(--color-sky-blue), var(--color-indigo));
  border-radius: var(--radius);
  opacity: 0.15;
}
'@

# ---------- src/components/common/Header.jsx ----------
Write-File "src\components\common\Header.jsx" @'
import { useState } from "react";
import { Link, NavLink } from "react-router-dom";
import { useTranslation } from "react-i18next";
import "./Header.css";

const SERVICES = [
  { label: "Custom Software Development", path: "/services/custom-software-development" },
  { label: "Enterprise Solutions", path: "/services/enterprise-solutions" },
  { label: "Cloud & DevOps", path: "/services/cloud-devops" },
  { label: "AI & Automation", path: "/services/ai-automation" },
  { label: "IT Consulting & Support", path: "/services/it-consulting-support" },
];

export default function Header() {
  const { t, i18n } = useTranslation();
  const [menuOpen, setMenuOpen] = useState(false);
  const [servicesOpen, setServicesOpen] = useState(false);

  const toggleLang = () => {
    i18n.changeLanguage(i18n.language === "en" ? "hi" : "en");
  };

  return (
    <header className="header">
      <div className="container header-inner">
        <Link to="/" className="logo">SKYVISTA</Link>

        <nav className={`nav ${menuOpen ? "nav-open" : ""}`}>
          <NavLink to="/" end>{t("nav.home")}</NavLink>
          <NavLink to="/about">{t("nav.about")}</NavLink>

          <div
            className="nav-dropdown"
            onMouseEnter={() => setServicesOpen(true)}
            onMouseLeave={() => setServicesOpen(false)}
          >
            <span>{t("nav.services")}</span>
            {servicesOpen && (
              <div className="dropdown-menu">
                {SERVICES.map((s) => (
                  <Link key={s.path} to={s.path}>{s.label}</Link>
                ))}
              </div>
            )}
          </div>

          <NavLink to="/portfolio">{t("nav.portfolio")}</NavLink>
          <NavLink to="/insights">{t("nav.insights")}</NavLink>
          <NavLink to="/faq">{t("nav.faq")}</NavLink>
          <NavLink to="/contact" className="nav-cta">{t("nav.contact")}</NavLink>
        </nav>

        <button className="lang-toggle" onClick={toggleLang}>
          {i18n.language === "en" ? "HI" : "EN"}
        </button>

        <button className="menu-toggle" onClick={() => setMenuOpen(!menuOpen)}>
          Menu
        </button>
      </div>
    </header>
  );
}
'@

# ---------- src/components/common/Header.css ----------
Write-File "src\components\common\Header.css" @'
.header {
  position: sticky;
  top: 0;
  background: var(--color-white);
  border-bottom: 1px solid var(--color-border);
  z-index: 100;
}
.header-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--space-sm) var(--space-md);
}
.logo {
  font-family: var(--font-heading);
  font-weight: 800;
  font-size: 22px;
  color: var(--color-navy);
}
.nav {
  display: flex;
  align-items: center;
  gap: var(--space-md);
}
.nav a { font-weight: 500; color: var(--color-navy); }
.nav-cta {
  background: var(--color-sky-blue);
  color: var(--color-white) !important;
  padding: 10px 20px;
  border-radius: 8px;
}
.nav-dropdown { position: relative; cursor: pointer; }
.dropdown-menu {
  position: absolute;
  top: 100%;
  left: 0;
  background: var(--color-white);
  border: 1px solid var(--color-border);
  border-radius: 8px;
  padding: var(--space-sm);
  min-width: 260px;
  box-shadow: 0 8px 24px rgba(11,31,58,0.1);
  display: flex;
  flex-direction: column;
  gap: 8px;
}
.lang-toggle {
  background: var(--color-bg-light);
  padding: 6px 14px;
  border-radius: 6px;
  font-weight: 600;
  margin-left: var(--space-sm);
}
.menu-toggle { display: none; background: none; font-size: 16px; font-weight: 600; }

@media (max-width: 1024px) {
  .nav { display: none; }
  .nav.nav-open {
    display: flex;
    flex-direction: column;
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: var(--color-white);
    padding: var(--space-md);
    border-bottom: 1px solid var(--color-border);
  }
  .menu-toggle { display: block; }
}
'@

Write-Host "FRONTEND PART 3 COMPLETE: Global CSS design system + Header component created." -ForegroundColor Green

# =========================================================
# PART 4 of 6 - Footer, SEO, EnquiryForm Components
# =========================================================

# ---------- src/components/common/Footer.jsx ----------
Write-File "src\components\common\Footer.jsx" @'
import { Link } from "react-router-dom";
import "./Footer.css";

export default function Footer() {
  return (
    <footer className="footer section-dark">
      <div className="container grid grid-5">
        <div>
          <h4>SKYVISTA</h4>
          <p>Custom Software, Cloud & AI Solutions for Smarter Businesses</p>
        </div>
        <div>
          <h4>Company</h4>
          <ul>
            <li><Link to="/about">About Us</Link></li>
            <li><Link to="/portfolio">Portfolio</Link></li>
            <li><Link to="/insights">Insights</Link></li>
            <li><Link to="/contact">Contact Us</Link></li>
          </ul>
        </div>
        <div>
          <h4>Services</h4>
          <ul>
            <li><Link to="/services/custom-software-development">Custom Software Development</Link></li>
            <li><Link to="/services/enterprise-solutions">Enterprise Solutions</Link></li>
            <li><Link to="/services/cloud-devops">Cloud & DevOps</Link></li>
            <li><Link to="/services/ai-automation">AI & Automation</Link></li>
            <li><Link to="/services/it-consulting-support">IT Consulting & Support</Link></li>
          </ul>
        </div>
        <div>
          <h4>Resources</h4>
          <ul>
            <li><Link to="/faq">FAQs</Link></li>
            <li><Link to="/privacy-policy">Privacy Policy</Link></li>
            <li><Link to="/terms-conditions">Terms & Conditions</Link></li>
            <li><Link to="/cookie-policy">Cookie Policy</Link></li>
          </ul>
        </div>
        <div>
          <h4>Contact</h4>
          <p>info@skyvista.com</p>
          <p>+91 90877 65544</p>
          <p>Office No. 10, District Centre, Janakpuri West, New Delhi - 110045</p>
        </div>
      </div>
      <div className="container text-center footer-bottom">
        <p>(c) 2025 SKYVISTA JOURNEYS LLP. All rights reserved.</p>
      </div>
    </footer>
  );
}
'@

# ---------- src/components/common/Footer.css ----------
Write-File "src\components\common\Footer.css" @'
.footer {
  padding: var(--space-2xl) 0 var(--space-md) 0;
}
.footer h4 {
  color: var(--color-white);
  margin-bottom: var(--space-sm);
  font-size: var(--text-h4);
}
.footer p {
  color: var(--color-slate-light);
  margin-bottom: 8px;
  font-size: var(--text-small);
}
.footer ul li { margin-bottom: 8px; }
.footer ul li a {
  color: var(--color-slate-light);
  font-size: var(--text-small);
  transition: color 0.2s ease;
}
.footer ul li a:hover { color: var(--color-sky-blue); }
.footer-bottom {
  margin-top: var(--space-xl);
  padding-top: var(--space-md);
  border-top: 1px solid rgba(255,255,255,0.1);
}
.footer-bottom p {
  color: var(--color-slate-light);
  font-size: var(--text-small);
}
'@

# ---------- src/components/common/SEO.jsx ----------
Write-File "src\components\common\SEO.jsx" @'
import { Helmet } from "react-helmet-async";

export default function SEO({ title, description }) {
  return (
    <Helmet>
      <title>{title} | SKYVISTA JOURNEYS LLP</title>
      <meta name="description" content={description} />
    </Helmet>
  );
}
'@

# ---------- src/components/common/EnquiryForm.jsx ----------
Write-File "src\components\common\EnquiryForm.jsx" @'
import { useState } from "react";
import { submitEnquiry } from "../../services/api";
import "./EnquiryForm.css";

const SERVICE_OPTIONS = [
  { value: "software_development", label: "Custom Software Development" },
  { value: "enterprise_solutions", label: "Enterprise Solutions" },
  { value: "cloud_devops", label: "Cloud & DevOps" },
  { value: "ai_automation", label: "AI & Automation" },
  { value: "it_consulting", label: "IT Consulting & Support" },
  { value: "travel_technology", label: "Travel Technology" },
  { value: "other", label: "Other / Not Sure" },
];

export default function EnquiryForm() {
  const [form, setForm] = useState({
    full_name: "", email: "", phone: "", company_name: "",
    service_interested: "", message: ""
  });
  const [status, setStatus] = useState({ loading: false, success: "", error: "" });

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setStatus({ loading: true, success: "", error: "" });
    try {
      const res = await submitEnquiry(form);
      setStatus({ loading: false, success: res.data.message, error: "" });
      setForm({ full_name: "", email: "", phone: "", company_name: "", service_interested: "", message: "" });
    } catch (err) {
      setStatus({ loading: false, success: "", error: "Something went wrong. Please try again or email us directly." });
    }
  };

  return (
    <form className="enquiry-form" onSubmit={handleSubmit}>
      <input name="full_name" placeholder="Full Name *" value={form.full_name} onChange={handleChange} required />
      <input name="email" type="email" placeholder="Email Address *" value={form.email} onChange={handleChange} required />
      <input name="phone" placeholder="Phone Number" value={form.phone} onChange={handleChange} />
      <input name="company_name" placeholder="Company Name" value={form.company_name} onChange={handleChange} />
      <select name="service_interested" value={form.service_interested} onChange={handleChange} required>
        <option value="">Service Interested In *</option>
        {SERVICE_OPTIONS.map(opt => (
          <option key={opt.value} value={opt.value}>{opt.label}</option>
        ))}
      </select>
      <textarea name="message" placeholder="Message / Project Details *" rows="5" value={form.message} onChange={handleChange} required />
      <button type="submit" className="btn-primary" disabled={status.loading}>
        {status.loading ? "Submitting..." : "Submit Enquiry"}
      </button>
      {status.success && <p className="form-success">{status.success}</p>}
      {status.error && <p className="form-error">{status.error}</p>}
    </form>
  );
}
'@

# ---------- src/components/common/EnquiryForm.css ----------
Write-File "src\components\common\EnquiryForm.css" @'
.enquiry-form {
  display: flex;
  flex-direction: column;
  gap: var(--space-sm);
  max-width: 600px;
}
.enquiry-form input,
.enquiry-form select,
.enquiry-form textarea {
  padding: 12px 16px;
  border: 1px solid var(--color-border);
  border-radius: 8px;
  font-family: var(--font-body);
  font-size: var(--text-body);
}
.enquiry-form button { align-self: flex-start; }
.form-success { color: var(--color-success); font-weight: 600; }
.form-error { color: var(--color-error); font-weight: 600; }
'@

Write-Host "FRONTEND PART 4 COMPLETE: Footer, SEO, EnquiryForm components created." -ForegroundColor Green


# =========================================================
# PART 5 of 6 - App.jsx, Home.jsx, services data
# =========================================================

# ---------- src/data/services.js ----------
Write-File "src\data\services.js" @'
export const SERVICES_LIST = [
  {
    slug: "custom-software-development",
    title: "Custom Software Development",
    heroSubheading: "We design and build web, mobile, and SaaS applications tailored to your exact business requirements - scalable, secure, and built to last.",
    includes: [
      "Web Application Development - Custom web platforms built around your workflows, not generic templates.",
      "Mobile App Development - Native and cross-platform mobile applications for iOS and Android.",
      "SaaS Product Development - End-to-end product engineering, from concept to a scalable, multi-tenant platform.",
      "UI/UX Design - Interfaces that are intuitive, accessible, and designed around real user behavior.",
      "API & Third-Party Integrations - Connecting your systems with payment gateways, travel APIs, CRMs, and other business tools.",
      "Software Maintenance & Support - Ongoing updates, bug fixes, and performance improvements after launch."
    ],
    whoFor: [
      "Startups building a new digital product from scratch",
      "Growing businesses whose current software cannot keep up with demand",
      "Companies replacing outdated or unsupported legacy systems",
      "Businesses needing a platform that integrates multiple tools and data sources",
      "Travel companies requiring custom booking, supplier, or customer-facing platforms"
    ],
    approach: [
      { step: "Discovery & Requirement Mapping", desc: "We work closely with your team to understand business goals, user needs, and technical constraints before any design begins." },
      { step: "Architecture & Design", desc: "We define the right technical architecture and design user interfaces that are both functional and intuitive." },
      { step: "Agile Development", desc: "Our teams build in iterative sprints, so you see progress regularly and can provide feedback throughout - not just at the end." },
      { step: "Testing & Quality Assurance", desc: "Every feature is tested for functionality, performance, and security before deployment." },
      { step: "Launch & Ongoing Support", desc: "We handle deployment and remain available for maintenance, updates, and future enhancements." }
    ],
    ctaText: "Discuss Your Software Project"
  },
  {
    slug: "enterprise-solutions",
    title: "Enterprise Solutions",
    heroSubheading: "From digital transformation to business process automation, we help enterprises streamline operations and connect disconnected systems.",
    includes: [
      "Digital Transformation - Modernizing legacy processes and systems to support how your business operates today.",
      "ERP / CRM Solutions - Implementing or customizing systems that manage operations, customers, and resources in one place.",
      "Business Process Automation - Replacing manual, repetitive tasks with automated workflows.",
      "System Integration - Connecting disparate software tools so data flows seamlessly across your organization.",
      "Workflow Management Systems - Custom tools that reflect how your teams actually work, reducing bottlenecks.",
      "Data Dashboards & Business Intelligence - Real-time visibility into the metrics that matter most to your business."
    ],
    whoFor: [
      "Enterprises with multiple departments using disconnected tools",
      "Organizations relying on manual processes that slow down operations",
      "Businesses needing better visibility into performance and operations data",
      "Companies undergoing digital transformation initiatives",
      "Travel and hospitality businesses managing suppliers, bookings, and back-office operations across multiple systems"
    ],
    approach: [
      { step: "Operational Assessment", desc: "We map your existing systems, workflows, and pain points to identify where technology can create the most impact." },
      { step: "Solution Design", desc: "We design a solution architecture that fits your organization's scale, compliance needs, and existing infrastructure." },
      { step: "Phased Implementation", desc: "Enterprise systems are rolled out in manageable phases to minimize disruption to daily operations." },
      { step: "Integration & Testing", desc: "We ensure new systems integrate smoothly with your existing tools and that data flows accurately across platforms." },
      { step: "Training & Ongoing Support", desc: "We support your team through adoption and remain available for long-term system support and enhancements." }
    ],
    ctaText: "Discuss Your Enterprise Needs"
  },
  {
    slug: "cloud-devops",
    title: "Cloud & DevOps",
    heroSubheading: "We architect secure, scalable cloud infrastructure and automate deployment pipelines so your systems run reliably, wherever you grow.",
    includes: [
      "Cloud Strategy & Consulting - Helping you choose the right cloud approach for your business and technical needs.",
      "Cloud Migration - Moving existing applications and infrastructure to the cloud with minimal downtime.",
      "Cloud-Native Application Development - Building applications designed specifically to take advantage of cloud scalability.",
      "AWS / Microsoft Azure / Google Cloud Solutions - Infrastructure setup and management across major cloud providers.",
      "DevOps & CI/CD - Automated build, test, and deployment pipelines that speed up and stabilize software releases.",
      "Cloud Security, Monitoring & Optimization - Ongoing monitoring, cost optimization, and security best practices.",
      "Managed Cloud Support - Continuous infrastructure management so your team can focus on the business, not the servers."
    ],
    whoFor: [
      "Businesses still running on-premise infrastructure that limits scalability",
      "Companies experiencing performance issues as user demand grows",
      "Organizations needing to reduce infrastructure costs through optimization",
      "Teams wanting faster, more reliable software deployment processes",
      "Travel platforms requiring infrastructure that can handle real-time booking traffic and seasonal spikes"
    ],
    approach: [
      { step: "Infrastructure Assessment", desc: "We evaluate your current setup, performance bottlenecks, and future scalability needs." },
      { step: "Architecture Planning", desc: "We design a cloud architecture suited to your workload, budget, and compliance requirements." },
      { step: "Migration or Build", desc: "We execute the migration or build cloud-native infrastructure with minimal disruption to live systems." },
      { step: "Automation Setup", desc: "We implement CI/CD pipelines to automate testing and deployment, reducing release friction." },
      { step: "Ongoing Monitoring & Support", desc: "We continuously monitor performance, security, and costs - optimizing as your usage evolves." }
    ],
    ctaText: "Discuss Your Cloud Needs"
  },
  {
    slug: "ai-automation",
    title: "AI & Automation",
    heroSubheading: "We build intelligent workflows, AI-powered chatbots, and automation systems that reduce manual effort and unlock faster decision-making.",
    includes: [
      "Generative AI Solutions - Custom AI tools built on modern language models, tailored to your business use case.",
      "AI-Powered Chatbots - Intelligent virtual assistants for customer support, lead qualification, and internal use.",
      "AI Workflow Automation - Automating multi-step business processes that currently require manual handling.",
      "Intelligent Document Processing - Extracting and processing data from documents, forms, and invoices automatically.",
      "Predictive Analytics - Using historical data to forecast trends, demand, and business outcomes.",
      "Machine Learning Solutions - Custom models built to solve specific business problems.",
      "Customer Support Automation - AI-driven systems that handle routine queries, freeing your team for complex issues.",
      "AI Integration for Existing Software - Adding AI capabilities into systems you already use, without a full rebuild."
    ],
    whoFor: [
      "Businesses spending excessive time on repetitive manual tasks",
      "Companies wanting to improve customer response times without expanding headcount",
      "Organizations sitting on data they are not using to make decisions",
      "Teams looking to integrate AI into existing tools rather than starting over",
      "Travel businesses wanting AI-driven customer interactions, automated quotations, or intelligent booking assistance"
    ],
    approach: [
      { step: "Use Case Identification", desc: "We identify where AI and automation can create the most meaningful impact on your operations." },
      { step: "Feasibility & Data Review", desc: "We assess your existing data and systems to determine the right AI approach for your specific use case." },
      { step: "Solution Development", desc: "We build and train the AI solution, whether it is a chatbot, automation workflow, or predictive model." },
      { step: "Testing & Refinement", desc: "We test extensively to ensure accuracy, reliability, and a smooth user experience before launch." },
      { step: "Deployment & Continuous Improvement", desc: "AI systems improve over time. We monitor performance and refine models as more data becomes available." }
    ],
    ctaText: "Discuss Your Automation Project"
  },
  {
    slug: "it-consulting-support",
    title: "IT Consulting & Support",
    heroSubheading: "Our consultants help you choose the right technology path, then our teams stay engaged to support, maintain, and evolve your systems.",
    includes: [
      "Technology Consulting - Expert guidance on the right technology decisions for your business stage and goals.",
      "Product Discovery & Roadmap - Structured planning for new digital products before development begins.",
      "Dedicated Development Teams - Access to skilled developers who integrate directly with your existing team.",
      "Application Modernization - Upgrading legacy applications to modern, maintainable, and scalable systems.",
      "Ongoing Support & Maintenance - Continued technical support to keep your systems running smoothly long after launch."
    ],
    whoFor: [
      "Businesses unsure which technology approach fits their needs",
      "Companies needing extra development capacity without a full hiring process",
      "Organizations with aging systems that need modernization, not replacement",
      "Teams that need ongoing technical support beyond initial project delivery",
      "Travel businesses needing strategic guidance on evolving their existing platforms"
    ],
    approach: [
      { step: "Initial Consultation", desc: "We start with a conversation to understand your challenges, goals, and current technical landscape." },
      { step: "Assessment & Recommendations", desc: "We provide clear, practical recommendations - not generic advice - based on your specific situation." },
      { step: "Flexible Engagement", desc: "Depending on your needs, we provide dedicated teams, project-based support, or ongoing advisory services." },
      { step: "Implementation Support", desc: "Where needed, our team works alongside yours to execute on the agreed technology roadmap." },
      { step: "Continued Partnership", desc: "We remain available for ongoing support, periodic reviews, and future technology planning." }
    ],
    ctaText: "Talk to Our Consultants"
  }
];

export const getServiceBySlug = (slug) => SERVICES_LIST.find(s => s.slug === slug);
'@

# ---------- src/App.jsx ----------
Write-File "src\App.jsx" @'
import { Routes, Route } from "react-router-dom";
import Header from "./components/common/Header";
import Footer from "./components/common/Footer";

import Home from "./pages/Home";
import About from "./pages/About";
import ServicePage from "./pages/services/ServicePage";
import Portfolio from "./pages/Portfolio";
import Insights from "./pages/Insights";
import BlogPost from "./pages/BlogPost";
import FAQ from "./pages/FAQ";
import Contact from "./pages/Contact";
import PrivacyPolicy from "./pages/PrivacyPolicy";
import Terms from "./pages/Terms";
import CookiePolicy from "./pages/CookiePolicy";
import NotFound from "./pages/NotFound";

export default function App() {
  return (
    <>
      <Header />
      <main>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/about" element={<About />} />
          <Route path="/services/:slug" element={<ServicePage />} />
          <Route path="/portfolio" element={<Portfolio />} />
          <Route path="/insights" element={<Insights />} />
          <Route path="/insights/:slug" element={<BlogPost />} />
          <Route path="/faq" element={<FAQ />} />
          <Route path="/contact" element={<Contact />} />
          <Route path="/privacy-policy" element={<PrivacyPolicy />} />
          <Route path="/terms-conditions" element={<Terms />} />
          <Route path="/cookie-policy" element={<CookiePolicy />} />
          <Route path="*" element={<NotFound />} />
        </Routes>
      </main>
      <Footer />
    </>
  );
}
'@

# ---------- src/pages/Home.jsx ----------
Write-File "src\pages\Home.jsx" @'
import { Link } from "react-router-dom";
import SEO from "../components/common/SEO";

const SERVICE_CARDS = [
  { slug: "custom-software-development", title: "Custom Software Development", desc: "We design and build web, mobile, and SaaS applications tailored to your exact business requirements." },
  { slug: "enterprise-solutions", title: "Enterprise Solutions", desc: "Digital transformation, automation, and system integration for growing businesses." },
  { slug: "cloud-devops", title: "Cloud & DevOps", desc: "Secure, scalable cloud architecture and managed deployment pipelines." },
  { slug: "ai-automation", title: "AI & Automation", desc: "Intelligent workflows, chatbots, and automation that reduce manual work." },
  { slug: "it-consulting-support", title: "IT Consulting & Support", desc: "Expert guidance, dedicated teams, and ongoing technical support." }
];

const TRUST_ITEMS = [
  "Global Clientele", "Custom-Built Solutions", "AI-Driven Automation",
  "Travel-Tech Specialists", "Dedicated Support"
];

const OUTCOMES = [
  "Automate repetitive manual work so your team can focus on what matters",
  "Modernize outdated systems without disrupting daily operations",
  "Build scalable digital platforms ready for your next stage of growth",
  "Integrate disconnected tools and APIs into one connected ecosystem",
  "Improve customer experience with AI-powered interactions",
  "Make faster, smarter decisions with real-time data dashboards"
];

const WHY_SKYVISTA = [
  "Custom-built, not templated - Every solution is designed around your specific business.",
  "Business-first approach - We start with your goals, then find the right technology.",
  "AI built into our DNA - Automation and intelligence are woven into how we build.",
  "Cloud-ready from day one - Every solution is architected to scale with your business.",
  "Travel-tech specialists - Rare, hands-on expertise in a complex industry.",
  "Partners beyond delivery - We stay engaged through support, maintenance, and growth."
];

export default function Home() {
  return (
    <>
      <SEO title="Home" description="Custom software development, enterprise solutions, cloud services, and AI automation for businesses worldwide - with specialized expertise in travel technology." />

      <section className="section hero">
        <div className="container grid grid-2" style={{ alignItems: "center" }}>
          <div>
            <h1>Custom Software, Cloud & AI Solutions for Smarter Businesses</h1>
            <p style={{ margin: "20px 0", fontSize: "18px" }}>
              SKYVISTA JOURNEYS LLP helps businesses worldwide build scalable software,
              modernize operations, and automate workflows with AI - backed by specialized
              expertise in travel technology.
            </p>
            <div style={{ display: "flex", gap: "16px", flexWrap: "wrap" }}>
              <Link to="/contact" className="btn-primary">Discuss Your Project</Link>
              <Link to="/services/custom-software-development" className="btn-secondary">Explore Our Services</Link>
            </div>
          </div>
          <div className="hero-visual-placeholder"></div>
        </div>
      </section>

      <section className="section-light" style={{ padding: "32px 0" }}>
        <div className="container grid grid-5">
          {TRUST_ITEMS.map((item) => (
            <div key={item} className="text-center">
              <p style={{ fontWeight: 600, color: "var(--color-navy)" }}>{item}</p>
            </div>
          ))}
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div className="text-center" style={{ marginBottom: "40px" }}>
            <h2>What We Do</h2>
            <p>End-to-end technology solutions designed around your business goals.</p>
          </div>
          <div className="grid grid-3">
            {SERVICE_CARDS.map((s) => (
              <div key={s.slug} className="card">
                <h3>{s.title}</h3>
                <p style={{ margin: "12px 0" }}>{s.desc}</p>
                <Link to={`/services/${s.slug}`} style={{ color: "var(--color-sky-blue)", fontWeight: 600 }}>
                  Learn More &rarr;
                </Link>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container grid grid-2" style={{ alignItems: "center" }}>
          <div>
            <h2>Technology Expertise Built for the Travel Industry</h2>
            <p style={{ margin: "16px 0" }}>
              Travel businesses run on complex, interconnected systems - bookings, suppliers,
              pricing, and customer communication, all happening in real time. We understand
              these challenges because travel technology is where SKYVISTA began.
            </p>
            <p style={{ marginBottom: "24px", fontWeight: 600 }}>
              B2B & B2C Travel Portals &middot; Booking Engines &middot; API Integrations &middot; Travel Workflow Automation
            </p>
            <Link to="/contact" className="btn-primary">Talk to a Travel-Tech Expert</Link>
          </div>
          <div className="hero-visual-placeholder"></div>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <h2 className="text-center" style={{ marginBottom: "40px" }}>Why Businesses Choose SKYVISTA</h2>
          <div className="grid grid-3">
            {WHY_SKYVISTA.map((item, i) => (
              <div key={i} className="card">
                <p>{item}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2 className="text-center" style={{ marginBottom: "40px" }}>Technology That Solves Real Business Problems</h2>
          <div className="grid grid-3">
            {OUTCOMES.map((item, i) => (
              <div key={i} className="card">
                <p>{item}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section">
        <div className="container text-center">
          <h2>Our Work</h2>
          <p style={{ margin: "16px 0 32px 0" }}>
            We are preparing detailed case studies to showcase our delivery expertise. Selected work coming soon.
          </p>
          <Link to="/contact" className="btn-secondary">Discuss Your Project Instead &rarr;</Link>
        </div>
      </section>

      <section className="section section-dark text-center">
        <div className="container">
          <h2>Have a Software, Cloud, or AI Project in Mind?</h2>
          <p style={{ margin: "16px 0 32px 0" }}>
            Tell us about your business requirement, and our team will get in touch with you.
          </p>
          <Link to="/contact" className="btn-primary">Start Your Project Enquiry</Link>
        </div>
      </section>
    </>
  );
}
'@

Write-Host "FRONTEND PART 5 COMPLETE: App.jsx, Home.jsx, services.js data created." -ForegroundColor Green

# =========================================================
# PART 6 of 6 - Remaining Pages + Completion
# =========================================================

# ---------- src/pages/About.jsx ----------
Write-File "src\pages\About.jsx" @'
import { Link } from "react-router-dom";
import SEO from "../components/common/SEO";

const VALUES = [
  { title: "Build With Purpose", desc: "Every line of code should solve a real problem. We do not build for the sake of building - we build for outcomes." },
  { title: "Understand Before We Build", desc: "We take the time to understand your business, your users, and your constraints before writing a single line of code." },
  { title: "Think in Systems", desc: "Technology does not exist in isolation. We design solutions that integrate, scale, and adapt as your business grows." },
  { title: "Automate Thoughtfully", desc: "AI and automation should remove friction, not add complexity. We build automation that genuinely makes work easier." },
  { title: "Stay Accountable", desc: "Our relationship with clients does not end at launch. We stand behind what we build - through support, iteration, and long-term partnership." }
];

const APPROACH = [
  { step: "Understand", desc: "We start by listening - to your business goals, operational challenges, and technical constraints." },
  { step: "Design", desc: "We design solutions that are practical, scalable, and tailored to your specific context - not recycled from a template." },
  { step: "Build", desc: "Our teams develop using modern, reliable technology, with regular check-ins so you always know where your project stands." },
  { step: "Support", desc: "Launch is just the beginning. We provide ongoing support, maintenance, and improvements as your business evolves." }
];

export default function About() {
  return (
    <>
      <SEO title="About Us" description="SKYVISTA JOURNEYS LLP is a technology company helping businesses worldwide build smarter software, scale with confidence, and automate operations - with specialized expertise in travel technology." />

      <section className="section text-center">
        <div className="container">
          <h1>We Build Technology That Moves Businesses Forward</h1>
          <p style={{ maxWidth: "720px", margin: "20px auto 0 auto" }}>
            SKYVISTA JOURNEYS LLP is a technology company helping businesses worldwide build
            smarter software, scale with confidence, and automate what used to be manual -
            with specialized expertise in travel technology.
          </p>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2>How We Got Here</h2>
          <p style={{ marginTop: "16px" }}>
            SKYVISTA JOURNEYS LLP was founded on a simple observation: most businesses do not
            need more software - they need the right software, built around how they actually work.
          </p>
          <p style={{ marginTop: "16px" }}>
            Our journey began in travel technology, where we encountered some of the most
            operationally complex challenges in any industry - real-time bookings, fragmented
            supplier systems, and customer expectations that never stop rising. Solving those
            problems taught us how to build technology that performs under pressure.
          </p>
          <p style={{ marginTop: "16px" }}>
            That experience now shapes everything we do - whether we are building a travel
            platform, automating an enterprise workflow, or deploying an AI-powered solution
            for a business in an entirely different industry.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container grid grid-2">
          <div className="card">
            <h3>Our Mission</h3>
            <p style={{ marginTop: "12px" }}>
              To help businesses of every size and industry build, automate, and scale through
              technology that is custom-built around their real needs - not forced into a generic template.
            </p>
          </div>
          <div className="card">
            <h3>Our Vision</h3>
            <p style={{ marginTop: "12px" }}>
              To be a trusted technology partner for businesses worldwide - known for combining
              deep technical expertise with genuine understanding of the industries we serve,
              starting with travel.
            </p>
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2 className="text-center" style={{ marginBottom: "32px" }}>What We Stand For</h2>
          <div className="grid grid-3">
            {VALUES.map((v) => (
              <div key={v.title} className="card">
                <h4>{v.title}</h4>
                <p style={{ marginTop: "8px" }}>{v.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <h2 className="text-center" style={{ marginBottom: "32px" }}>How We Work</h2>
          <div className="grid grid-2">
            {APPROACH.map((a, i) => (
              <div key={a.step} className="card">
                <h4>Step {i + 1}: {a.step}</h4>
                <p style={{ marginTop: "8px" }}>{a.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2>Where Deep Expertise Meets Broad Capability</h2>
          <p style={{ marginTop: "16px" }}>
            Travel technology is uniquely demanding - real-time data, multiple integrated
            systems, and customers who expect seamless experiences every time. Mastering this
            complexity gave us a foundation that strengthens everything else we build.
          </p>
          <p style={{ marginTop: "16px" }}>
            Today, SKYVISTA serves businesses across industries - but our travel-tech roots
            remain a core part of our identity, and a reason clients trust us with their most
            operationally complex challenges.
          </p>
        </div>
      </section>

      <section className="section section-dark text-center">
        <div className="container">
          <h2>Let us Build Something Together</h2>
          <p style={{ margin: "16px 0 32px 0" }}>
            Whether you are automating a workflow, modernizing a legacy system, or building
            something entirely new - we would like to hear about it.
          </p>
          <Link to="/contact" className="btn-primary">Start a Conversation</Link>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/services/ServicePage.jsx ----------
Write-File "src\pages\services\ServicePage.jsx" @'
import { useParams, Link } from "react-router-dom";
import SEO from "../../components/common/SEO";
import { getServiceBySlug } from "../../data/services";
import NotFound from "../NotFound";

export default function ServicePage() {
  const { slug } = useParams();
  const service = getServiceBySlug(slug);

  if (!service) return <NotFound />;

  return (
    <>
      <SEO title={service.title} description={service.heroSubheading} />

      <section className="section text-center section-light">
        <div className="container">
          <h1>{service.title}</h1>
          <p style={{ maxWidth: "720px", margin: "20px auto 0 auto" }}>{service.heroSubheading}</p>
          <div style={{ marginTop: "24px" }}>
            <Link to="/contact" className="btn-primary">{service.ctaText}</Link>
          </div>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <h2 style={{ marginBottom: "24px" }}>What We Deliver</h2>
          <div className="grid grid-2">
            {service.includes.map((item, i) => (
              <div key={i} className="card">
                <p>{item}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2 style={{ marginBottom: "24px" }}>Who This Is For</h2>
          <ul style={{ display: "flex", flexDirection: "column", gap: "12px" }}>
            {service.whoFor.map((item, i) => (
              <li key={i} style={{ paddingLeft: "20px", borderLeft: "3px solid var(--color-sky-blue)" }}>
                {item}
              </li>
            ))}
          </ul>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <h2 style={{ marginBottom: "24px" }}>How We Approach This</h2>
          <div className="grid grid-3">
            {service.approach.map((a, i) => (
              <div key={i} className="card">
                <h4>Step {i + 1}: {a.step}</h4>
                <p style={{ marginTop: "8px" }}>{a.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section section-light text-center">
        <div className="container">
          <h2>Projects in This Area</h2>
          <p style={{ margin: "16px 0" }}>
            We are preparing detailed case studies to showcase our work in this area. Selected projects coming soon.
          </p>
        </div>
      </section>

      <section className="section section-dark text-center">
        <div className="container">
          <h2>Ready to Get Started?</h2>
          <p style={{ margin: "16px 0 32px 0" }}>
            Tell us what you are trying to achieve - we will help you find the right approach.
          </p>
          <Link to="/contact" className="btn-primary">{service.ctaText}</Link>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/Portfolio.jsx ----------
Write-File "src\pages\Portfolio.jsx" @'
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import SEO from "../components/common/SEO";
import { getCaseStudies } from "../services/api";

const FILTERS = [
  { label: "All", value: "" },
  { label: "Custom Software Development", value: "software_development" },
  { label: "Enterprise Solutions", value: "enterprise_solutions" },
  { label: "Cloud & DevOps", value: "cloud_devops" },
  { label: "AI & Automation", value: "ai_automation" },
  { label: "Travel Technology", value: "travel_technology" }
];

export default function Portfolio() {
  const [activeFilter, setActiveFilter] = useState("");
  const [caseStudies, setCaseStudies] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    getCaseStudies(activeFilter)
      .then((res) => setCaseStudies(res.data))
      .catch(() => setCaseStudies([]))
      .finally(() => setLoading(false));
  }, [activeFilter]);

  return (
    <>
      <SEO title="Our Work" description="A look at how we help businesses build, automate, and scale through technology." />

      <section className="section text-center section-light">
        <div className="container">
          <h1>Our Work</h1>
          <p style={{ marginTop: "16px" }}>
            A look at how we help businesses build, automate, and scale through technology.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div style={{ display: "flex", gap: "12px", flexWrap: "wrap", justifyContent: "center", marginBottom: "40px" }}>
            {FILTERS.map((f) => (
              <button
                key={f.value}
                onClick={() => setActiveFilter(f.value)}
                className={activeFilter === f.value ? "btn-primary" : "btn-secondary"}
                style={{ fontSize: "14px", padding: "8px 16px" }}
              >
                {f.label}
              </button>
            ))}
          </div>

          {!loading && caseStudies.length === 0 && (
            <div className="text-center">
              <p style={{ marginBottom: "24px" }}>
                We are preparing detailed case studies to showcase our delivery expertise.
                Selected work coming soon.
              </p>
              <Link to="/contact" className="btn-secondary">Discuss Your Project With Us</Link>
            </div>
          )}

          {caseStudies.length > 0 && (
            <div className="grid grid-3">
              {caseStudies.map((cs) => (
                <div key={cs.id} className="card">
                  <h4>{cs.title}</h4>
                  <p style={{ marginTop: "8px", fontSize: "14px", color: "var(--color-slate-light)" }}>
                    {cs.client_industry}
                  </p>
                  <p style={{ marginTop: "8px" }}>{cs.summary}</p>
                </div>
              ))}
            </div>
          )}
        </div>
      </section>

      <section className="section section-dark text-center">
        <div className="container">
          <h2>Have a Similar Challenge?</h2>
          <p style={{ margin: "16px 0 32px 0" }}>
            Every project starts with a conversation. Let us talk about what you are trying to solve.
          </p>
          <Link to="/contact" className="btn-primary">Start a Conversation</Link>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/Insights.jsx ----------
Write-File "src\pages\Insights.jsx" @'
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import SEO from "../components/common/SEO";
import { getBlogPosts } from "../services/api";

export default function Insights() {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    getBlogPosts()
      .then((res) => setPosts(res.data))
      .catch(() => setPosts([]))
      .finally(() => setLoading(false));
  }, []);

  return (
    <>
      <SEO title="Insights" description="Thoughts on software, cloud, AI, and the future of travel technology." />

      <section className="section text-center section-light">
        <div className="container">
          <h1>Insights from SKYVISTA</h1>
          <p style={{ marginTop: "16px" }}>
            Thoughts on software, cloud, AI, and the future of travel technology.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          {!loading && posts.length === 0 && (
            <div className="grid grid-3">
              <div className="card">
                <h4>Why Businesses Are Moving to AI-Powered Automation</h4>
                <p style={{ marginTop: "8px" }}>
                  Explore how AI is transforming everyday business operations - and why the
                  shift is happening faster than expected.
                </p>
              </div>
              <div className="card">
                <h4>5 Signs Your Business Needs a Cloud Migration Strategy</h4>
                <p style={{ marginTop: "8px" }}>
                  If your systems are struggling to keep up, these five signs will help you
                  know it is time to move to the cloud.
                </p>
              </div>
              <div className="card">
                <h4>How Custom Software Outperforms Off-the-Shelf Solutions</h4>
                <p style={{ marginTop: "8px" }}>
                  Generic tools can only take you so far. Here is why custom-built software
                  gives growing businesses a real advantage.
                </p>
              </div>
            </div>
          )}

          {posts.length > 0 && (
            <div className="grid grid-3">
              {posts.map((p) => (
                <Link key={p.slug} to={`/insights/${p.slug}`} className="card">
                  <h4>{p.title_en}</h4>
                  <p style={{ marginTop: "8px" }}>{p.excerpt_en}</p>
                </Link>
              ))}
            </div>
          )}
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/BlogPost.jsx ----------
Write-File "src\pages\BlogPost.jsx" @'
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import SEO from "../components/common/SEO";
import { getBlogPost } from "../services/api";

export default function BlogPost() {
  const { slug } = useParams();
  const [post, setPost] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    getBlogPost(slug)
      .then((res) => setPost(res.data))
      .catch(() => setPost(null))
      .finally(() => setLoading(false));
  }, [slug]);

  if (loading) return <section className="section"><div className="container">Loading...</div></section>;
  if (!post) return <section className="section"><div className="container"><h1>Article Not Found</h1></div></section>;

  return (
    <>
      <SEO title={post.title_en} description={post.excerpt_en} />
      <section className="section">
        <div className="container" style={{ maxWidth: "720px" }}>
          <h1>{post.title_en}</h1>
          <p style={{ marginTop: "20px", whiteSpace: "pre-line" }}>{post.content_en}</p>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/FAQ.jsx ----------
Write-File "src\pages\FAQ.jsx" @'
import { useState } from "react";
import SEO from "../components/common/SEO";
import EnquiryForm from "../components/common/EnquiryForm";

const FAQ_DATA = [
  {
    category: "General",
    items: [
      { q: "What does SKYVISTA JOURNEYS LLP do?", a: "We are a technology company providing custom software development, enterprise solutions, cloud services, AI automation, and IT consulting - with specialized expertise in travel technology." },
      { q: "What industries do you work with?", a: "We work with businesses across industries, including travel, enterprise, retail, and startups. Our travel technology expertise is a particular strength, but our services apply broadly across sectors." },
      { q: "Where is SKYVISTA JOURNEYS LLP located?", a: "Our office is located in Janakpuri West, New Delhi, India. We work with clients both domestically and internationally." },
      { q: "Do you work with international clients?", a: "Yes. We work with businesses across different countries and time zones, and we structure our communication and delivery processes accordingly." }
    ]
  },
  {
    category: "Services",
    items: [
      { q: "Do you build custom software, or do you use pre-built templates?", a: "All our software is custom-built around each client specific business needs. We do not rely on generic templates or one-size-fits-all products." },
      { q: "Can you help modernize an existing system instead of building something new?", a: "Yes. Application modernization is part of our Enterprise Solutions and IT Consulting services." },
      { q: "Do you offer ongoing support after a project is completed?", a: "Yes. We provide ongoing maintenance and support for all the solutions we build." },
      { q: "What cloud platforms do you work with?", a: "We work with major cloud providers, including AWS, Microsoft Azure, and Google Cloud." }
    ]
  },
  {
    category: "AI & Automation",
    items: [
      { q: "What kind of AI solutions do you build?", a: "We build AI-powered chatbots, workflow automation systems, intelligent document processing tools, predictive analytics models, and custom AI integrations." },
      { q: "Can AI be added to software we already use?", a: "Yes. We specialize in integrating AI capabilities into existing systems." },
      { q: "How do I know if AI automation is right for my business?", a: "If your team spends significant time on repetitive manual tasks, or if you have unused data, AI automation is likely to deliver meaningful value." }
    ]
  },
  {
    category: "Travel Technology",
    items: [
      { q: "What kind of travel technology solutions do you build?", a: "B2B and B2C travel portals, booking engines, and API integrations with travel suppliers." },
      { q: "Do you build custom booking engines?", a: "Yes. We design and develop custom booking systems tailored to your specific business model." },
      { q: "We are a non-travel business - can you still help us?", a: "Absolutely. Our software, cloud, enterprise, and AI services apply to businesses across all industries." }
    ]
  },
  {
    category: "Process & Engagement",
    items: [
      { q: "How does a typical project start?", a: "Every engagement begins with a discovery conversation to understand your business goals, challenges, and requirements." },
      { q: "How long does a typical project take?", a: "Timelines vary depending on project scope and complexity. We provide a clear estimate after discovery." },
      { q: "Do you offer dedicated teams, or only fixed-scope projects?", a: "We offer flexible engagement models, including dedicated teams, fixed-scope projects, and ongoing consulting." },
      { q: "How do I get started?", a: "Submit an enquiry through our Contact page, and our team will reach out to schedule a conversation." }
    ]
  }
];

export default function FAQ() {
  const [openIndex, setOpenIndex] = useState(null);

  return (
    <>
      <SEO title="FAQ" description="Answers to common questions about our services, process, and how we work." />

      <section className="section text-center section-light">
        <div className="container">
          <h1>Frequently Asked Questions</h1>
          <p style={{ marginTop: "16px" }}>Answers to common questions about our services, process, and how we work.</p>
        </div>
      </section>

      <section className="section">
        <div className="container" style={{ maxWidth: "800px" }}>
          {FAQ_DATA.map((cat) => (
            <div key={cat.category} style={{ marginBottom: "40px" }}>
              <h3 style={{ marginBottom: "16px" }}>{cat.category}</h3>
              {cat.items.map((item, i) => {
                const key = cat.category + i;
                const isOpen = openIndex === key;
                return (
                  <div key={key} className="card" style={{ marginBottom: "12px", cursor: "pointer" }} onClick={() => setOpenIndex(isOpen ? null : key)}>
                    <strong>{item.q}</strong>
                    {isOpen && <p style={{ marginTop: "8px" }}>{item.a}</p>}
                  </div>
                );
              })}
            </div>
          ))}
        </div>
      </section>

      <section className="section section-light">
        <div className="container text-center">
          <h2>Still Have Questions?</h2>
          <p style={{ margin: "16px 0 32px 0" }}>Reach out directly, and our team will get back to you.</p>
          <div style={{ display: "flex", justifyContent: "center" }}>
            <EnquiryForm />
          </div>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/Contact.jsx ----------
Write-File "src\pages\Contact.jsx" @'
import SEO from "../components/common/SEO";
import EnquiryForm from "../components/common/EnquiryForm";

export default function Contact() {
  return (
    <>
      <SEO title="Contact Us" description="Tell us about your business requirement, and our team will get in touch with you." />

      <section className="section text-center section-light">
        <div className="container">
          <h1>Let us Start a Conversation</h1>
          <p style={{ marginTop: "16px" }}>
            Tell us about your business requirement, and our team will get in touch with you.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container grid grid-2">
          <div>
            <h3 style={{ marginBottom: "20px" }}>Send Us an Enquiry</h3>
            <EnquiryForm />
          </div>
          <div>
            <h3 style={{ marginBottom: "20px" }}>Reach Us Directly</h3>
            <p style={{ marginBottom: "12px" }}><strong>Email:</strong> info@skyvista.com</p>
            <p style={{ marginBottom: "12px" }}><strong>Phone:</strong> +91 90877 65544</p>
            <p style={{ marginBottom: "12px" }}>
              <strong>Office Address:</strong><br />
              Office No. 10, District Centre, Janakpuri West,<br />
              New Delhi - 110045, India
            </p>
            <div style={{ marginTop: "24px" }}>
              <h4 style={{ marginBottom: "12px" }}>Connect With Us</h4>
              <div style={{ display: "flex", gap: "12px" }}>
                <a href="#" style={{ color: "var(--color-sky-blue)" }}>LinkedIn</a>
                <a href="#" style={{ color: "var(--color-sky-blue)" }}>Instagram</a>
                <a href="#" style={{ color: "var(--color-sky-blue)" }}>Facebook</a>
                <a href="#" style={{ color: "var(--color-sky-blue)" }}>X</a>
                <a href="#" style={{ color: "var(--color-sky-blue)" }}>YouTube</a>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/PrivacyPolicy.jsx ----------
Write-File "src\pages\PrivacyPolicy.jsx" @'
import SEO from "../components/common/SEO";

export default function PrivacyPolicy() {
  return (
    <>
      <SEO title="Privacy Policy" description="Privacy Policy for SKYVISTA JOURNEYS LLP." />
      <section className="section">
        <div className="container" style={{ maxWidth: "800px" }}>
          <h1>Privacy Policy</h1>
          <p style={{ marginTop: "12px", color: "var(--color-slate-light)" }}>Last Updated: [Insert Date Before Publishing]</p>

          <h3 style={{ marginTop: "32px" }}>1. Introduction</h3>
          <p style={{ marginTop: "12px" }}>
            SKYVISTA JOURNEYS LLP ("we," "our," "us") respects your privacy and is committed to
            protecting the personal information you share with us. This Privacy Policy explains
            how we collect, use, and protect information when you visit our website at
            skyvista.com or interact with us through our contact and enquiry forms.
          </p>

          <h3 style={{ marginTop: "32px" }}>2. Information We Collect</h3>
          <p style={{ marginTop: "12px" }}>
            We may collect information you provide directly (name, email, phone, company,
            message) and automatically collected information (IP address, browser type,
            pages visited) through analytics tools such as Google Analytics.
          </p>

          <h3 style={{ marginTop: "32px" }}>3. How We Use Your Information</h3>
          <p style={{ marginTop: "12px" }}>
            We use your information to respond to enquiries, improve our website, communicate
            with you, and comply with legal obligations. We do not sell, rent, or trade your
            personal information to third parties.
          </p>

          <h3 style={{ marginTop: "32px" }}>4. Data Security</h3>
          <p style={{ marginTop: "12px" }}>
            We implement reasonable technical and organizational measures to protect your
            personal information. However, no method of transmission over the internet is
            completely secure.
          </p>

          <h3 style={{ marginTop: "32px" }}>5. Your Rights</h3>
          <p style={{ marginTop: "12px" }}>
            You may request access, correction, or deletion of your personal information by
            contacting us at info@skyvista.com.
          </p>

          <h3 style={{ marginTop: "32px" }}>6. Contact Us</h3>
          <p style={{ marginTop: "12px" }}>
            SKYVISTA JOURNEYS LLP<br />
            Email: info@skyvista.com<br />
            Phone: +91 90877 65544<br />
            Address: Office No. 10, District Centre, Janakpuri West, New Delhi - 110045, India
          </p>

          <p style={{ marginTop: "32px", fontStyle: "italic", color: "var(--color-slate-light)" }}>
            Note: This is a draft policy and should be reviewed by a qualified legal
            professional before publishing.
          </p>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/Terms.jsx ----------
Write-File "src\pages\Terms.jsx" @'
import SEO from "../components/common/SEO";

export default function Terms() {
  return (
    <>
      <SEO title="Terms & Conditions" description="Terms and Conditions for SKYVISTA JOURNEYS LLP." />
      <section className="section">
        <div className="container" style={{ maxWidth: "800px" }}>
          <h1>Terms & Conditions</h1>
          <p style={{ marginTop: "12px", color: "var(--color-slate-light)" }}>Last Updated: [Insert Date Before Publishing]</p>

          <h3 style={{ marginTop: "32px" }}>1. Acceptance of Terms</h3>
          <p style={{ marginTop: "12px" }}>
            By accessing or using skyvista.com, operated by SKYVISTA JOURNEYS LLP, you agree
            to be bound by these Terms & Conditions.
          </p>

          <h3 style={{ marginTop: "32px" }}>2. Use of This Website</h3>
          <p style={{ marginTop: "12px" }}>
            You agree to use this Website only for lawful purposes and not to submit false or
            misleading information through our forms.
          </p>

          <h3 style={{ marginTop: "32px" }}>3. Intellectual Property</h3>
          <p style={{ marginTop: "12px" }}>
            All content on this Website is the property of SKYVISTA JOURNEYS LLP or its
            licensors, unless otherwise stated.
          </p>

          <h3 style={{ marginTop: "32px" }}>4. Service Engagements</h3>
          <p style={{ marginTop: "12px" }}>
            These Terms govern use of the Website only. Any actual service engagement will be
            governed by a separate, signed agreement.
          </p>

          <h3 style={{ marginTop: "32px" }}>5. Governing Law</h3>
          <p style={{ marginTop: "12px" }}>
            These Terms shall be governed by the laws of India, subject to the jurisdiction of
            courts in New Delhi, India.
          </p>

          <h3 style={{ marginTop: "32px" }}>6. Contact Us</h3>
          <p style={{ marginTop: "12px" }}>
            SKYVISTA JOURNEYS LLP<br />
            Email: info@skyvista.com<br />
            Phone: +91 90877 65544
          </p>

          <p style={{ marginTop: "32px", fontStyle: "italic", color: "var(--color-slate-light)" }}>
            Note: This is a draft and should be reviewed by a qualified legal professional
            before publishing.
          </p>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/CookiePolicy.jsx ----------
Write-File "src\pages\CookiePolicy.jsx" @'
import SEO from "../components/common/SEO";

export default function CookiePolicy() {
  return (
    <>
      <SEO title="Cookie Policy" description="Cookie Policy for SKYVISTA JOURNEYS LLP." />
      <section className="section">
        <div className="container" style={{ maxWidth: "800px" }}>
          <h1>Cookie Policy</h1>
          <p style={{ marginTop: "12px", color: "var(--color-slate-light)" }}>Last Updated: [Insert Date Before Publishing]</p>

          <h3 style={{ marginTop: "32px" }}>1. What Are Cookies?</h3>
          <p style={{ marginTop: "12px" }}>
            Cookies are small text files placed on your device when you visit a website. They
            help websites function properly and understand visitor behavior.
          </p>

          <h3 style={{ marginTop: "32px" }}>2. How We Use Cookies</h3>
          <p style={{ marginTop: "12px" }}>
            We use essential cookies for website functionality and analytics cookies (such as
            Google Analytics) to understand visitor behavior and improve our content.
          </p>

          <h3 style={{ marginTop: "32px" }}>3. Managing Cookies</h3>
          <p style={{ marginTop: "12px" }}>
            You can control or disable cookies through your browser settings. Disabling
            certain cookies may affect website functionality.
          </p>

          <h3 style={{ marginTop: "32px" }}>4. Contact Us</h3>
          <p style={{ marginTop: "12px" }}>
            SKYVISTA JOURNEYS LLP<br />
            Email: info@skyvista.com<br />
            Phone: +91 90877 65544
          </p>

          <p style={{ marginTop: "32px", fontStyle: "italic", color: "var(--color-slate-light)" }}>
            Note: This is a draft and should be reviewed before publishing, especially if
            additional cookie categories (chatbot, WhatsApp) are added later.
          </p>
        </div>
      </section>
    </>
  );
}
'@

# ---------- src/pages/NotFound.jsx ----------
Write-File "src\pages\NotFound.jsx" @'
import { Link } from "react-router-dom";
import SEO from "../components/common/SEO";

export default function NotFound() {
  return (
    <>
      <SEO title="Page Not Found" description="The page you are looking for does not exist." />
      <section className="section text-center">
        <div className="container">
          <h1>404</h1>
          <p style={{ margin: "16px 0 32px 0" }}>The page you are looking for does not exist.</p>
          <Link to="/" className="btn-primary">Back to Home</Link>
        </div>
      </section>
    </>
  );
}
'@

# ---------- COMPLETION ----------
Set-Location ..

Write-Host ""
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host " FRONTEND SETUP COMPLETE: skyvista-frontend/" -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host "1. cd skyvista-frontend"
Write-Host "2. npm install"
Write-Host "3. copy .env.example .env"
Write-Host "4. npm run dev"
Write-Host ""
Write-Host "Site will be available at: http://localhost:5173"
Write-Host ""
Write-Host "IMPORTANT: Make sure the backend (skyvista-backend) is also"
Write-Host "running on http://localhost:8000 for the contact form to work."
Write-Host "=========================================================" -ForegroundColor Cyan





