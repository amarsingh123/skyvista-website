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
