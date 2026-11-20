import { Routes, Route } from "react-router-dom";
import Header from "./components/common/Header";
import Footer from "./components/common/Footer";
import ErrorBoundary from "./components/common/ErrorBoundary";

import Home from "./pages/Home";
import About from "./pages/About";
import Services from "./pages/Services";
import ServicePage from "./pages/services/ServicePage";
import Portfolio from "./pages/Portfolio";
import Insights from "./pages/Insights";
import BlogPost from "./pages/BlogPost";
import FAQ from "./pages/FAQ";
import Contact from "./pages/Contact";
import PrivacyPolicy from "./pages/PrivacyPolicy";
import Terms from "./pages/Terms";
import CookiePolicy from "./pages/CookiePolicy";
import NotFound from "./pages/NotFound";

export default function App() {
  return (
    <>
      <Header />
      <main>
        <ErrorBoundary>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/about" element={<About />} />
            <Route path="/services" element={<Services />} />
            <Route path="/services/:slug" element={<ServicePage />} />
            <Route path="/portfolio" element={<Portfolio />} />
            <Route path="/insights" element={<Insights />} />
            <Route path="/insights/:slug" element={<BlogPost />} />
            <Route path="/faq" element={<FAQ />} />
            <Route path="/contact" element={<Contact />} />
            <Route path="/privacy-policy" element={<PrivacyPolicy />} />
            <Route path="/terms-conditions" element={<Terms />} />
            <Route path="/cookie-policy" element={<CookiePolicy />} />
            <Route path="*" element={<NotFound />} />
          </Routes>
        </ErrorBoundary>
      </main>
      <Footer />
    </>
  );
}
