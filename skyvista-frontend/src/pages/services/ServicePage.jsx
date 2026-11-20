import { useParams, Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import SEO from "../../components/common/SEO";
import { getServiceBySlug } from "../../data/services";
import NotFound from "../NotFound";

export default function ServicePage() {
  const { slug } = useParams();
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";

  const service = getServiceBySlug(slug);

  if (!service) {
    return <NotFound />;
  }

  const getField = (field, fallback) => {
    if (!field) return fallback;
    if (typeof field === "string") return field;
    if (field[lang]) return field[lang];
    if (field.en) return field.en;
    return fallback;
  };

  const getArrayField = (field) => {
    if (!field) return [];
    if (Array.isArray(field)) return field;
    if (field[lang] && Array.isArray(field[lang])) return field[lang];
    if (field.en && Array.isArray(field.en)) return field.en;
    return [];
  };

  const title = getField(service.title, "Service");
  const heroSubheading = getField(service.heroSubheading, "");
  const includes = getArrayField(service.includes);
  const whoFor = getArrayField(service.whoFor);
  const approach = getArrayField(service.approach);
  const ctaText = getField(service.ctaText, "Contact Us");

  const labels = {
    en: {
      deliverTitle: "What We Deliver",
      whoTitle: "Who This Is For",
      approachTitle: "How We Approach This",
      stepPrefix: "Step",
      projectsTitle: "Projects in This Area",
      projectsDesc: "We are preparing detailed case studies to showcase our work in this area. Selected projects coming soon.",
      readyTitle: "Ready to Get Started?",
      readyDesc: "Tell us what you are trying to achieve — we will help you find the right approach."
    },
    hi: {
      deliverTitle: "हम क्या प्रदान करते हैं",
      whoTitle: "यह किसके लिए उपयोगी है",
      approachTitle: "हमारी कार्यप्रणाली",
      stepPrefix: "चरण",
      projectsTitle: "इस क्षेत्र में हमारे कार्य",
      projectsDesc: "हम इस सेवा से जुड़े प्रोजेक्ट्स की केस स्टडीज तैयार कर रहे हैं। चुनिंदा काम जल्द ही यहाँ प्रदर्शित होगा।",
      readyTitle: "क्या आप शुरुआत करने के लिए तैयार हैं?",
      readyDesc: "हमें अपना लक्ष्य बताएं — हम आपके लिए सबसे उपयुक्त और प्रभावी तकनीकी समाधान खोजेंगे।"
    }
  }[lang];

  return (
    <>
      <SEO title={title} description={heroSubheading} />

      <section className="section text-center section-light">
        <div className="container">
          <h1>{title}</h1>
          <p style={{ maxWidth: "720px", margin: "20px auto 0 auto" }}>{heroSubheading}</p>
          <div style={{ marginTop: "24px" }}>
            <Link to="/contact" className="btn-primary">{ctaText}</Link>
          </div>
        </div>
      </section>

      {includes.length > 0 && (
        <section className="section">
          <div className="container">
            <h2 style={{ marginBottom: "24px" }}>{labels.deliverTitle}</h2>
            <div className="grid grid-2">
              {includes.map((item, i) => (
                <div key={i} className="card">
                  <p>{typeof item === "string" ? item : JSON.stringify(item)}</p>
                </div>
              ))}
            </div>
          </div>
        </section>
      )}

      {whoFor.length > 0 && (
        <section className="section section-light">
          <div className="container">
            <h2 style={{ marginBottom: "24px" }}>{labels.whoTitle}</h2>
            <ul style={{ display: "flex", flexDirection: "column", gap: "12px" }}>
              {whoFor.map((item, i) => (
                <li key={i} style={{ paddingLeft: "20px", borderLeft: "3px solid var(--color-sky-blue)" }}>
                  {typeof item === "string" ? item : JSON.stringify(item)}
                </li>
              ))}
            </ul>
          </div>
        </section>
      )}

      {approach.length > 0 && (
        <section className="section">
          <div className="container">
            <h2 style={{ marginBottom: "24px" }}>{labels.approachTitle}</h2>
            <div className="grid grid-3">
              {approach.map((a, i) => (
                <div key={i} className="card">
                  <h4>{labels.stepPrefix} {i + 1}: {a?.step || ""}</h4>
                  <p style={{ marginTop: "8px" }}>{a?.desc || ""}</p>
                </div>
              ))}
            </div>
          </div>
        </section>
      )}

      <section className="section section-light text-center">
        <div className="container">
          <h2>{labels.projectsTitle}</h2>
          <p style={{ margin: "16px 0" }}>{labels.projectsDesc}</p>
        </div>
      </section>

      <section className="section section-dark text-center">
        <div className="container">
          <h2>{labels.readyTitle}</h2>
          <p style={{ margin: "16px 0 32px 0" }}>{labels.readyDesc}</p>
          <Link to="/contact" className="btn-primary">{ctaText}</Link>
        </div>
      </section>
    </>
  );
}
