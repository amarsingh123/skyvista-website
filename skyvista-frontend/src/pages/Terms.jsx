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
