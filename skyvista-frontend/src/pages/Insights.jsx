import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import SEO from "../components/common/SEO";
import { getBlogPosts } from "../services/api";

const STATIC_POSTS = {
  en: [
    {
      slug: "why-businesses-moving-to-ai-automation",
      title: "Why Businesses Are Moving to AI-Powered Automation",
      excerpt: "Explore how AI is transforming everyday business operations — and why the shift is happening faster than expected.",
      tag: "AI & Automation"
    },
    {
      slug: "5-signs-your-business-needs-cloud-migration",
      title: "5 Signs Your Business Needs a Cloud Migration Strategy",
      excerpt: "If your systems are struggling to keep up with load and scalability, these five signs will help you know it is time to move to the cloud.",
      tag: "Cloud & DevOps"
    },
    {
      slug: "how-custom-software-outperforms-off-the-shelf",
      title: "How Custom Software Outperforms Off-the-Shelf Solutions",
      excerpt: "Generic software tools can only take you so far. Here is why custom-built software gives growing businesses a distinct advantage.",
      tag: "Software Engineering"
    }
  ],
  hi: [
    {
      slug: "why-businesses-moving-to-ai-automation",
      title: "व्यवसाय एआई-संचालित ऑटोमेशन की ओर क्यों बढ़ रहे हैं?",
      excerpt: "जानें कि आर्टिफिशियल इंटेलिजेंस (AI) दैनिक कार्यों को कैसे बदल रहा है — और यह बदलाव उम्मीद से कहीं अधिक तेजी से क्यों हो रहा है।",
      tag: "एआई और ऑटोमेशन"
    },
    {
      slug: "5-signs-your-business-needs-cloud-migration",
      title: "5 संकेत कि आपके बिजनेस को क्लाउड माइग्रेशन की आवश्यकता है",
      excerpt: "यदि आपका मौजूदा सिस्टम लोड और विस्तार को संभालने में संघर्ष कर रहा है, तो ये 5 संकेत बताएंगे कि क्लाउड पर जाने का सही समय कब है।",
      tag: "क्लाउड और डेवऑप्स"
    },
    {
      slug: "how-custom-software-outperforms-off-the-shelf",
      title: "कस्टम सॉफ्टवेयर रेडीमेड टूल्स से बेहतर प्रदर्शन क्यों करता है?",
      excerpt: "रेडीमेड सॉफ्टवेयर एक सीमा तक ही काम आते हैं। जानें कि कस्टमाइज्ड सॉफ्टवेयर बढ़ते व्यवसायों को वास्तविक बढ़त कैसे देता है।",
      tag: "सॉफ्टवेयर इंजीनियरिंग"
    }
  ]
};

export default function Insights() {
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";

  const labels = {
    en: {
      seoTitle: "Insights & Articles",
      seoDesc: "Thoughts on software development, cloud infrastructure, AI automation, and travel technology.",
      heroTitle: "Insights from SKYVISTA",
      heroDesc: "In-depth perspectives on software, cloud scalability, practical AI, and travel technology.",
      readMore: "Read Article →"
    },
    hi: {
      seoTitle: "आर्टिकल और विचार",
      seoDesc: "सॉफ्टवेयर विकास, क्लाउड इन्फ्रास्ट्रक्चर, एआई ऑटोमेशन और ट्रैवल टेक्नोलॉजी पर हमारे लेख।",
      heroTitle: "स्काईविस्टा इनसाइट्स (लेख)",
      heroDesc: "सॉफ्टवेयर, क्लाउड स्केलेबिलिटी, व्यावहारिक एआई और ट्रैवल टेक्नोलॉजी पर ज्ञानवर्धक दृष्टिकोण।",
      readMore: "पूरा लेख पढ़ें →"
    }
  }[lang];

  const [apiPosts, setApiPosts] = useState([]);

  useEffect(() => {
    getBlogPosts()
      .then((res) => {
        if (Array.isArray(res.data) && res.data.length > 0) {
          setApiPosts(res.data);
        }
      })
      .catch(() => setApiPosts([]));
  }, []);

  const displayPosts = apiPosts.length > 0 ? apiPosts : STATIC_POSTS[lang];

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
          <div className="grid grid-3">
            {displayPosts.map((p, idx) => {
              const title = p[`title_${lang}`] || p.title || p.title_en;
              const excerpt = p[`excerpt_${lang}`] || p.excerpt || p.excerpt_en;
              const slug = p.slug;
              const tag = p.tag || p.category;

              return (
                <div key={slug || idx} className="card" style={{ display: "flex", flexDirection: "column", justifyContent: "space-between" }}>
                  <div>
                    {tag && (
                      <span style={{ fontSize: "12px", color: "var(--color-sky-blue)", fontWeight: "700", textTransform: "uppercase" }}>
                        {tag}
                      </span>
                    )}
                    <h3 style={{ marginTop: "8px", fontSize: "20px" }}>{title}</h3>
                    <p style={{ marginTop: "12px", fontSize: "15px" }}>{excerpt}</p>
                  </div>
                  <div style={{ marginTop: "20px" }}>
                    <Link to={`/insights/${slug}`} style={{ color: "var(--color-sky-blue)", fontWeight: "600" }}>
                      {labels.readMore}
                    </Link>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </section>
    </>
  );
}