import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import SEO from "../components/common/SEO";
import { getBlogPost } from "../services/api";

const STATIC_ARTICLES = {
  "why-businesses-moving-to-ai-automation": {
    en: {
      title: "Why Businesses Are Moving to AI-Powered Automation",
      category: "AI & Automation",
      date: "May 2025",
      content: `In today competitive business landscape, efficiency is no longer optional. Companies across sectors are adopting AI-powered automation not just to cut operational costs, but to fundamentally transform customer experience and turn-around times.

Traditional automation followed static rules. If something unexpected happened, human intervention was immediately required. Modern AI automation, powered by Large Language Models and Machine Learning, understands context, handles edge cases, and continuously learns from data.

Key Areas Where AI is Making an Immediate Impact:
1. Intelligent Customer Support: Chatbots that understand nuance and resolve complex queries 24/7.
2. Document Processing: Automated extraction of invoices, contracts, and travel vouchers in seconds.
3. Workflow Orchestration: Routing leads, generating quotes, and dispatching tasks without human delay.

At SKYVISTA JOURNEYS LLP, we believe the best AI solutions are not meant to replace human expertise, but to remove repetitive operational friction so teams can focus on growth.`
    },
    hi: {
      title: "व्यवसाय एआई-संचालित ऑटोमेशन की ओर क्यों बढ़ रहे हैं?",
      category: "एआई और ऑटोमेशन",
      date: "मई 2025",
      content: `आज के प्रतिस्पर्धी व्यापारिक परिदृश्य में कार्यकुशलता अब केवल एक विकल्प नहीं, बल्कि अनिवार्यता बन चुकी है। विभिन्न क्षेत्रों की कंपनियां केवल परिचालन लागत कम करने के लिए ही नहीं, बल्कि ग्राहकों के अनुभव को बेहतर बनाने और कार्यों की गति कई गुना बढ़ाने के लिए AI ऑटोमेशन अपना रही हैं।

पारंपरिक ऑटोमेशन कुछ पूर्व-निर्धारित नियमों पर आधारित था। यदि कोई अप्रत्याशित स्थिति आती थी, तो तुरंत मैन्युअल मदद लेनी पड़ती थी। इसके विपरीत, आधुनिक एआई ऑटोमेशन संदर्भ (context) को समझता है, असामान्य स्थितियों को संभालता है और डेटा से लगातार सीखता है।

एआई के तीन मुख्य व्यावहारिक प्रभाव क्षेत्र:
1. बुद्धिमान ग्राहक सहायता: ऐसे चैटबॉट जो मानवीय भाषा की बारीकियों को समझते हैं और 24/7 जटिल प्रश्नों का त्वरित समाधान करते हैं।
2. दस्तावेज प्रोसेसिंग: इनवॉइस, अनुबंध और ट्रैवल वाउचर्स से कुछ ही सेकंडों में सटीक डेटा निकालना।
3. वर्कफ़्लो स्वचालन: लीड्स का सही विभाजन, तत्काल कोटेशन तैयार करना और कार्यों का स्वचालित आवंटन।

SKYVISTA JOURNEYS LLP में हमारा मानना है कि सबसे बेहतरीन AI समाधान कर्मचारियों को हटाने के लिए नहीं, बल्कि रोजमर्रा के उबाऊ कार्यों को समाप्त करने के लिए बनाए जाते हैं ताकि आपकी टीम व्यापार विस्तार पर ध्यान दे सके।`
    }
  },
  "5-signs-your-business-needs-cloud-migration": {
    en: {
      title: "5 Signs Your Business Needs a Cloud Migration Strategy",
      category: "Cloud & DevOps",
      date: "April 2025",
      content: `Relying on legacy on-premise infrastructure often caps your company growth rate. Here are five unmistakable indicators that your organization needs to migrate to cloud platforms like AWS or Azure:

1. Performance Degradation During Traffic Spikes: If your booking portal or internal CRM slows down when user traffic doubles, your infrastructure lacks elastic scalability.
2. High Maintenance and Hardware Overhead: Spending valuable developer hours fixing server faults instead of building product features.
3. Slow Software Deployments: If releasing a simple bug fix takes days or requires late-night server downtime, automated cloud CI/CD pipelines are needed.
4. Data Silos Across Departments: Disconnected servers prevent real-time data visibility across finance, sales, and operations.
5. Inadequate Disaster Recovery: Lacking automated multi-region backups puts your business at severe risk.

Cloud migration eliminates these bottlenecks, giving you pay-as-you-go cost efficiency and enterprise-grade security.`
    },
    hi: {
      title: "5 संकेत कि आपके बिजनेस को क्लाउड माइग्रेशन की आवश्यकता है",
      category: "क्लाउड और डेवऑप्स",
      date: "अप्रैल 2025",
      content: `पुराने ऑन-प्रेमिस सर्वर पर निर्भर रहना अक्सर किसी भी व्यवसाय के विस्तार की गति को धीमा कर देता है। यहाँ पाँच स्पष्ट संकेत दिए गए हैं जो दर्शाते हैं कि आपकी संस्था को AWS या Azure जैसे आधुनिक क्लाउड पर माइग्रेट करना चाहिए:

1. ट्रैफिक बढ़ने पर सिस्टम का धीमा होना: जब आपकी वेबसाइट या बुकिंग पोर्टल पर यूज़र्स की संख्या दोगुनी होती है और सिस्टम क्रैश होने लगता है, तो इसका अर्थ है कि सर्वर में स्केलेबिलिटी की कमी है।
2. हार्डवेयर और मेंटेनेंस का भारी खर्च: नई सुविधाएं विकसित करने के बजाय डेवलपर्स का समय केवल सर्वर की खराबी सुधारने में नष्ट होना।
3. सॉफ्टवेयर अपडेट्स में अत्यधिक देरी: यदि एक छोटा सा बग फिक्स करने के लिए भी सिस्टम डाउनटाइम की आवश्यकता होती है, तो आपको स्वचालित क्लाउड CI/CD पाइपलाइन की आवश्यकता है।
4. विभागों के बीच अलग-थलग डेटा: अलग-अलग लोकल सर्वर होने के कारण सेल्स, ऑपरेशंस और फाइनेंस के बीच रीयल-टाइम डेटा उपलब्ध नहीं हो पाता।
5. डेटा रिकवरी का अभाव: बैकअप की स्वचालित व्यवस्था न होने से डेटा नष्ट होने का गंभीर जोखिम रहता है।

क्लाउड माइग्रेशन इन सभी सीमाओं को समाप्त कर सुरक्षित और किफायती इंफ्रास्ट्रक्चर प्रदान करता है।`
    }
  },
  "how-custom-software-outperforms-off-the-shelf": {
    en: {
      title: "How Custom Software Outperforms Off-the-Shelf Solutions",
      category: "Software Engineering",
      date: "March 2025",
      content: `When businesses start out, off-the-shelf SaaS tools make sense. But as your operations scale and mature, generic software often becomes a bottleneck.

Why Custom Software Creates Long-Term Advantage:
- Aligned With Your Exact Workflow: You don't have to alter your business model to fit the software; the software is engineered around your exact operations.
- Zero Per-Seat Licensing Fees: As your team grows from 10 to 500, off-the-shelf SaaS costs explode. Custom software gives you full ownership.
- Seamless Proprietary Integrations: Connect your proprietary booking engines, internal databases, and supplier APIs without artificial vendor restrictions.
- Competitive Differentiation: If your competitors use the exact same template software, how do you differentiate your service? Custom digital products provide proprietary competitive advantage.`
    },
    hi: {
      title: "कस्टम सॉफ्टवेयर रेडीमेड टूल्स से बेहतर प्रदर्शन क्यों करता है?",
      category: "सॉफ्टवेयर इंजीनियरिंग",
      date: "मार्च 2025",
      content: `शुरुआती दौर में रेडीमेड SaaS टूल्स सुविधाजनक लगते हैं, लेकिन जैसे-जैसे आपका व्यवसाय बढ़ता है, ये सामान्य सॉफ्टवेयर विकास में बाधा बनने लगते हैं।

कस्टम सॉफ्टवेयर से मिलने वाले दीर्घकालिक लाभ:
- आपकी कार्यशैली के 100% अनुकूल: आपको सॉफ्टवेयर के अनुसार अपना बिजनेस मॉडल बदलने की जरूरत नहीं होती; सॉफ्टवेयर आपकी कार्यप्रणाली के अनुरूप तैयार किया जाता है।
- प्रति-उपयोगकर्ता लाइसेंस शुल्क से मुक्ति: टीम 10 से बढ़कर 500 होने पर रेडीमेड टूल्स का खर्च अत्यधिक बढ़ जाता है। कस्टम सॉफ्टवेयर का पूर्ण स्वामित्व आपका होता है।
- निर्बाध और स्वतंत्र इंटीग्रेशन: किसी थर्ड-पार्टी की सीमाओं के बिना अपने बुकिंग इंजन, आंतरिक डेटाबेस और सप्लायर API को सीधे जोड़ें।
- बाजार में प्रतिस्पर्धात्मक बढ़त: यदि आपके सभी प्रतिद्वंद्वी एक ही रेडीमेड सॉफ्टवेयर का उपयोग कर रहे हैं, तो आप अलग कैसे दिखेंगे? कस्टम सॉफ्टवेयर आपके ब्रांड को एक अद्वितीय तकनीकी पहचान देता है।`
    }
  }
};

export default function BlogPost() {
  const { slug } = useParams();
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";

  const labels = {
    en: { back: "← Back to Insights", notFound: "Article Not Found", loading: "Loading article..." },
    hi: { back: "← सभी आर्टिकल्स पर वापस जाएं", notFound: "लेख नहीं मिला", loading: "लेख लोड हो रहा है..." }
  }[lang];

  const [post, setPost] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    getBlogPost(slug)
      .then((res) => {
        if (res.data) setPost(res.data);
      })
      .catch(() => {
        // Fallback to static article
        if (STATIC_ARTICLES[slug] && STATIC_ARTICLES[slug][lang]) {
          setPost(STATIC_ARTICLES[slug][lang]);
        } else {
          setPost(null);
        }
      })
      .finally(() => setLoading(false));
  }, [slug, lang]);

  if (loading) {
    return (
      <section className="section">
        <div className="container">{labels.loading}</div>
      </section>
    );
  }

  if (!post) {
    return (
      <section className="section">
        <div className="container text-center">
          <h1>{labels.notFound}</h1>
          <div style={{ marginTop: "24px" }}>
            <Link to="/insights" className="btn-secondary">{labels.back}</Link>
          </div>
        </div>
      </section>
    );
  }

  const title = post[`title_${lang}`] || post.title || post.title_en;
  const content = post[`content_${lang}`] || post.content || post.content_en;
  const category = post.category || post.tag;

  return (
    <>
      <SEO title={title} description={title} />
      <section className="section">
        <div className="container" style={{ maxWidth: "780px" }}>
          <Link to="/insights" style={{ color: "var(--color-sky-blue)", fontWeight: 600 }}>
            {labels.back}
          </Link>
          {category && (
            <div style={{ marginTop: "20px", fontSize: "13px", fontWeight: "700", color: "var(--color-sky-blue)", textTransform: "uppercase" }}>
              {category}
            </div>
          )}
          <h1 style={{ marginTop: "12px", marginBottom: "24px", lineHeight: "1.3" }}>{title}</h1>
          <div style={{ fontSize: "17px", lineHeight: "1.8", whiteSpace: "pre-line", color: "var(--color-slate)" }}>
            {content}
          </div>
        </div>
      </section>
    </>
  );
}