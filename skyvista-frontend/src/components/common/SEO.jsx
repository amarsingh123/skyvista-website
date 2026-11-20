import { Helmet } from "react-helmet-async";

export default function SEO({ title, description }) {
  return (
    <Helmet>
      <title>{title} | SKYVISTA JOURNEYS LLP</title>
      <meta name="description" content={description} />
    </Helmet>
  );
}
