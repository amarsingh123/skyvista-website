import { useTranslation } from "react-i18next";
import SEO from "../components/common/SEO";
import EnquiryForm from "../components/common/EnquiryForm";

export default function Contact() {
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";

  const content = {
    en: {
      seoTitle: "Contact Us",
      seoDesc: "Tell us about your business requirement, and our team will get in touch with you.",
      heroTitle: "Let Us Start a Conversation",
      heroDesc: "Tell us about your business requirement, and our team will get in touch with you.",
      formTitle: "Send Us an Enquiry",
      reachTitle: "Reach Us Directly",
      emailLabel: "Email:",
      phoneLabel: "Phone:",
      addressLabel: "Office Address:",
      address: "Office No. 10, District Centre, Janakpuri West,\nNew Delhi - 110045, India",
      connectTitle: "Connect With Us"
    },
    hi: {
      seoTitle: "संपर्क करें",
      seoDesc: "हमें अपनी व्यावसायिक आवश्यकता बताएं, हमारी टीम आपसे शीघ्र ही संपर्क करेगी।",
      heroTitle: "आइए बातचीत शुरू करें",
      heroDesc: "हमें अपनी व्यावसायिक आवश्यकता बताएं, और हमारी टीम आपसे जल्द ही संपर्क करेगी।",
      formTitle: "पूछताछ भेजें",
      reachTitle: "सीधे संपर्क करें",
      emailLabel: "ईमेल:",
      phoneLabel: "फ़ोन:",
      addressLabel: "कार्यालय का पता:",
      address: "कार्यालय संख्या 10, डिस्ट्रिक्ट सेंटर, जनकपुरी वेस्ट,\nनई दिल्ली - 110045, भारत",
      connectTitle: "हमसे जुड़ें"
    }
  }[lang];

  return (
    <>
      <SEO title={content.seoTitle} description={content.seoDesc} />

      <section className="section text-center section-light">
        <div className="container">
          <h1>{content.heroTitle}</h1>
          <p style={{ marginTop: "16px" }}>{content.heroDesc}</p>
        </div>
      </section>

      <section className="section">
        <div className="container grid grid-2">
          <div>
            <h3 style={{ marginBottom: "20px" }}>{content.formTitle}</h3>
            <EnquiryForm />
          </div>
          <div>
            <h3 style={{ marginBottom: "20px" }}>{content.reachTitle}</h3>
            <p style={{ marginBottom: "12px" }}><strong>{content.emailLabel}</strong> info@skyvista.com</p>
            <p style={{ marginBottom: "12px" }}><strong>{content.phoneLabel}</strong> +91 90877 65544</p>
            <p style={{ marginBottom: "12px", whiteSpace: "pre-line" }}>
              <strong>{content.addressLabel}</strong><br />
              {content.address}
            </p>
            <div style={{ marginTop: "24px" }}>
              <h4 style={{ marginBottom: "12px" }}>{content.connectTitle}</h4>
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