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
