import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import SEO from "../components/common/SEO";

export default function Home() {
  const { t } = useTranslation();

  const serviceCards = [
    { slug: "custom-software-development", title: t("servicesSection.s1Title"), desc: t("servicesSection.s1Desc") },
    { slug: "enterprise-solutions", title: t("servicesSection.s2Title"), desc: t("servicesSection.s2Desc") },
    { slug: "cloud-devops", title: t("servicesSection.s3Title"), desc: t("servicesSection.s3Desc") },
    { slug: "ai-automation", title: t("servicesSection.s4Title"), desc: t("servicesSection.s4Desc") },
    { slug: "it-consulting-support", title: t("servicesSection.s5Title"), desc: t("servicesSection.s5Desc") }
  ];

  const trustItems = [
    t("trust.global"),
    t("trust.custom"),
    t("trust.ai"),
    t("trust.travel"),
    t("trust.support")
  ];

  const outcomes = [
    t("outcomes.o1"),
    t("outcomes.o2"),
    t("outcomes.o3"),
    t("outcomes.o4"),
    t("outcomes.o5"),
    t("outcomes.o6")
  ];

  const whySkyvista = [
    t("why.w1"),
    t("why.w2"),
    t("why.w3"),
    t("why.w4"),
    t("why.w5"),
    t("why.w6")
  ];

  return (
    <>
      <SEO title={t("nav.home")} description={t("hero.subheading")} />

      <section className="section hero">
        <div className="container grid grid-2" style={{ alignItems: "center" }}>
          <div>
            <h1>{t("hero.heading")}</h1>
            <p style={{ margin: "20px 0", fontSize: "18px" }}>
              {t("hero.subheading")}
            </p>
            <div style={{ display: "flex", gap: "16px", flexWrap: "wrap" }}>
              <Link to="/contact" className="btn-primary">{t("hero.btnPrimary")}</Link>
              <Link to="/services/custom-software-development" className="btn-secondary">{t("hero.btnSecondary")}</Link>
            </div>
          </div>
          <div className="hero-visual-placeholder">
<img src="images/banner2.jpg" alt="Hero Visual" style={{ maxWidth: "100%" }} />

          </div>
        </div>
      </section>

      <section className="section-light" style={{ padding: "32px 0" }}>
        <div className="container grid grid-5">
          {trustItems.map((item) => (
            <div key={item} className="text-center">
              <p style={{ fontWeight: 600, color: "var(--color-navy)" }}>{item}</p>
            </div>
          ))}
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div className="text-center" style={{ marginBottom: "40px" }}>
            <h2>{t("servicesSection.title")}</h2>
            <p>{t("servicesSection.subtitle")}</p>
          </div>
          <div className="grid grid-3">
            {serviceCards.map((s) => (
              <div key={s.slug} className="card">
                <h3>{s.title}</h3>
                <p style={{ margin: "12px 0" }}>{s.desc}</p>
                <Link to={`/services/${s.slug}`} style={{ color: "var(--color-sky-blue)", fontWeight: 600 }}>
                  {t("servicesSection.learnMore")}
                </Link>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container grid grid-2" style={{ alignItems: "center" }}>
          <div>
            <h2>{t("travel.title")}</h2>
            <p style={{ margin: "16px 0" }}>
              {t("travel.body")}
            </p>
            <p style={{ marginBottom: "24px", fontWeight: 600 }}>
              {t("travel.tags")}
            </p>
            <Link to="/contact" className="btn-primary">{t("travel.btn")}</Link>
          </div>
          <div className="hero-visual-placeholder">
            <img src="images/Banner3.jpg" alt="Travel Visual" style={{ maxWidth: "100%" }} />
          </div>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <h2 className="text-center" style={{ marginBottom: "40px" }}>{t("why.title")}</h2>
          <div className="grid grid-3">
            {whySkyvista.map((item, i) => (
              <div key={i} className="card">
                <p>{item}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2 className="text-center" style={{ marginBottom: "40px" }}>{t("outcomes.title")}</h2>
          <div className="grid grid-3">
            {outcomes.map((item, i) => (
              <div key={i} className="card">
                <p>{item}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section">
        <div className="container text-center">
          <h2>{t("work.title")}</h2>
          <p style={{ margin: "16px 0 32px 0" }}>
            {t("work.desc")}
          </p>
          <Link to="/contact" className="btn-secondary">{t("work.btn")}</Link>
        </div>
      </section>

      <section className="section section-dark text-center">
        <div className="container">
          <h2>{t("cta.title")}</h2>
          <p style={{ margin: "16px 0 32px 0" }}>
            {t("cta.desc")}
          </p>
          <Link to="/contact" className="btn-primary">{t("cta.btn")}</Link>
        </div>
      </section>
    </>
  );
}