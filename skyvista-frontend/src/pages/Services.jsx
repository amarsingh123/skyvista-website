import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import SEO from "../components/common/SEO";
import { SERVICES_LIST } from "../data/services";

export default function Services() {
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";

  const labels = {
    en: {
      seoTitle: "Services",
      seoDesc: "End-to-end technology solutions: custom software, enterprise systems, cloud & DevOps, AI automation, and consulting.",
      heroTitle: "Our Technology Services",
      heroDesc: "We build custom, scalable, and intelligent digital solutions designed around your exact business requirements.",
      learnMore: "Explore Service →",
      deliverHeader: "Key Capabilities:",
      ctaTitle: "Need a Custom Solution?",
      ctaDesc: "Tell us about your business goals and technical challenges — our team is here to help.",
      ctaBtn: "Discuss Your Project"
    },
    hi: {
      seoTitle: "हमारी सेवाएं",
      seoDesc: "सम्पूर्ण तकनीकी समाधान: कस्टम सॉफ्टवेयर, एंटरप्राइज सिस्टम्स, क्लाउड और डेवऑप्स, एआई ऑटोमेशन और कंसल्टिंग।",
      heroTitle: "हमारी तकनीकी सेवाएं",
      heroDesc: "हम आपकी सटीक आवश्यकताओं के अनुरूप कस्टम, स्केलेबल और बुद्धिमत्ता-पूर्ण डिजिटल समाधान तैयार करते हैं।",
      learnMore: "सेवा विवरण देखें →",
      deliverHeader: "मुख्य क्षमताएं:",
      ctaTitle: "क्या आपको कस्टम समाधान चाहिए?",
      ctaDesc: "हमें अपने व्यावसायिक लक्ष्यों और तकनीकी चुनौतियों के बारे में बताएं — हमारी टीम आपकी सहायता के लिए तैयार है।",
      ctaBtn: "प्रोजेक्ट पर चर्चा करें"
    }
  }[lang];

  return (
    <>
      <SEO title={labels.seoTitle} description={labels.seoDesc} />

      <section className="section text-center section-light">
        <div className="container">
          <h1>{labels.heroTitle}</h1>
          <p style={{ maxWidth: "720px", margin: "20px auto 0 auto" }}>{labels.heroDesc}</p>
        </div>
      </section>

      <section className="section">
        <div className="container" style={{ display: "flex", flexDirection: "column", gap: "40px" }}>
          {SERVICES_LIST.map((s) => {
            const title = s.title[lang] || s.title.en;
            const desc = s.heroSubheading[lang] || s.heroSubheading.en;
            const items = (s.includes[lang] || s.includes.en).slice(0, 3);

            return (
              <div key={s.slug} className="card" style={{ padding: "32px" }}>
                <h2>{title}</h2>
                <p style={{ margin: "16px 0", fontSize: "17px" }}>{desc}</p>
                <div style={{ marginBottom: "20px" }}>
                  <strong style={{ color: "var(--color-navy)" }}>{labels.deliverHeader}</strong>
                  <ul style={{ marginTop: "10px", paddingLeft: "20px", listStyle: "disc" }}>
                    {items.map((item, idx) => (
                      <li key={idx} style={{ marginBottom: "6px" }}>{item}</li>
                    ))}
                  </ul>
                </div>
                <Link to={`/services/${s.slug}`} className="btn-secondary">
                  {labels.learnMore}
                </Link>
              </div>
            );
          })}
        </div>
      </section>

      <section className="section section-dark text-center">
        <div className="container">
          <h2>{labels.ctaTitle}</h2>
          <p style={{ margin: "16px 0 32px 0" }}>{labels.ctaDesc}</p>
          <Link to="/contact" className="btn-primary">{labels.ctaBtn}</Link>
        </div>
      </section>
    </>
  );
}