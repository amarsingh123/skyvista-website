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
