import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import SEO from "../components/common/SEO";
import { getCaseStudies } from "../services/api";

export default function Portfolio() {
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";

  const labels = {
    en: {
      seoTitle: "Our Work",
      seoDesc: "A look at how we help businesses build, automate, and scale through technology.",
      heroTitle: "Our Work",
      heroDesc: "A look at how we help businesses build, automate, and scale through technology.",
      emptyDesc: "We are preparing detailed case studies to showcase our delivery expertise. Selected work coming soon.",
      emptyBtn: "Discuss Your Project With Us",
      ctaTitle: "Have a Similar Challenge?",
      ctaDesc: "Every project starts with a conversation. Let us talk about what you are trying to solve.",
      ctaBtn: "Start a Conversation",
      filters: [
        { label: "All", value: "" },
        { label: "Custom Software Development", value: "software_development" },
        { label: "Enterprise Solutions", value: "enterprise_solutions" },
        { label: "Cloud & DevOps", value: "cloud_devops" },
        { label: "AI & Automation", value: "ai_automation" },
        { label: "Travel Technology", value: "travel_technology" }
      ]
    },
    hi: {
      seoTitle: "हमारा कार्य",
      seoDesc: "देखें कि हम तकनीक के माध्यम से व्यवसायों को आगे बढ़ने और ऑटोमेट करने में कैसे मदद करते हैं।",
      heroTitle: "हमारा कार्य",
      heroDesc: "देखें कि हम तकनीक के माध्यम से व्यवसायों को आगे बढ़ने और ऑटोमेट करने में कैसे मदद करते हैं।",
      emptyDesc: "हम अपनी डिलीवरी विशेषज्ञता प्रदर्शित करने के लिए केस स्टडीज तैयार कर रहे हैं। चुनिंदा काम जल्द ही उपलब्ध होगा।",
      emptyBtn: "अपने प्रोजेक्ट पर हमसे चर्चा करें",
      ctaTitle: "क्या आपकी भी ऐसी ही चुनौती है?",
      ctaDesc: "हर प्रोजेक्ट की शुरुआत एक संवाद से होती है। आइए बताएं कि आप क्या हल करना चाहते हैं।",
      ctaBtn: "बातचीत शुरू करें",
      filters: [
        { label: "सभी", value: "" },
        { label: "कस्टम सॉफ्टवेयर डेवलपमेंट", value: "software_development" },
        { label: "एंटरप्राइज सॉल्यूशंस", value: "enterprise_solutions" },
        { label: "क्लाउड और डेवऑप्स", value: "cloud_devops" },
        { label: "एआई और ऑटोमेशन", value: "ai_automation" },
        { label: "ट्रैवल टेक्नोलॉजी", value: "travel_technology" }
      ]
    }
  }[lang];

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
      <SEO title={labels.seoTitle} description={labels.seoDesc} />

      <section className="section text-center section-light">
        <div className="container">
          <h1>{labels.heroTitle}</h1>
          <p style={{ marginTop: "16px" }}>{labels.heroDesc}</p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div style={{ display: "flex", gap: "12px", flexWrap: "wrap", justifyContent: "center", marginBottom: "40px" }}>
            {labels.filters.map((f) => (
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
              <p style={{ marginBottom: "24px" }}>{labels.emptyDesc}</p>
              <Link to="/contact" className="btn-secondary">{labels.emptyBtn}</Link>
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
          <h2>{labels.ctaTitle}</h2>
          <p style={{ margin: "16px 0 32px 0" }}>{labels.ctaDesc}</p>
          <Link to="/contact" className="btn-primary">{labels.ctaBtn}</Link>
        </div>
      </section>
    </>
  );
}