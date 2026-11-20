import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import SEO from "../components/common/SEO";

export default function About() {
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";

  const content = {
    en: {
      seoTitle: "About Us",
      seoDesc: "SKYVISTA JOURNEYS LLP helps businesses worldwide build smarter software, scale with confidence, and automate operations.",
      heroTitle: "We Build Technology That Moves Businesses Forward",
      heroDesc: "SKYVISTA JOURNEYS LLP is a technology company helping businesses worldwide build smarter software, scale with confidence, and automate what used to be manual — with specialized expertise in travel technology.",
      storyTitle: "How We Got Here",
      storyP1: "SKYVISTA JOURNEYS LLP was founded on a simple observation: most businesses do not need more software — they need the right software, built around how they actually work.",
      storyP2: "Our journey began in travel technology, where we encountered some of the most operationally complex challenges in any industry — real-time bookings, fragmented supplier systems, and customer expectations that never stop rising. Solving those problems taught us how to build technology that performs under pressure.",
      storyP3: "That experience now shapes everything we do — whether we are building a travel platform, automating an enterprise workflow, or deploying an AI-powered solution for a business in an entirely different industry.",
      missionTitle: "Our Mission",
      missionDesc: "To help businesses of every size and industry build, automate, and scale through technology that is custom-built around their real needs — not forced into a generic template.",
      visionTitle: "Our Vision",
      visionDesc: "To be a trusted technology partner for businesses worldwide — known for combining deep technical expertise with genuine understanding of the industries we serve, starting with travel.",
      valuesTitle: "What We Stand For",
      values: [
        { title: "Build With Purpose", desc: "Every line of code should solve a real problem. We do not build for the sake of building — we build for outcomes." },
        { title: "Understand Before We Build", desc: "We take the time to understand your business, your users, and your constraints before writing a single line of code." },
        { title: "Think in Systems", desc: "Technology does not exist in isolation. We design solutions that integrate, scale, and adapt as your business grows." },
        { title: "Automate Thoughtfully", desc: "AI and automation should remove friction, not add complexity. We build automation that genuinely makes work easier." },
        { title: "Stay Accountable", desc: "Our relationship with clients does not end at launch. We stand behind what we build — through support, iteration, and long-term partnership." }
      ],
      approachTitle: "How We Work",
      stepPrefix: "Step",
      approach: [
        { step: "Understand", desc: "We start by listening — to your business goals, operational challenges, and technical constraints." },
        { step: "Design", desc: "We design solutions that are practical, scalable, and tailored to your specific context — not recycled from a template." },
        { step: "Build", desc: "Our teams develop using modern, reliable technology, with regular check-ins so you always know where your project stands." },
        { step: "Support", desc: "Launch is just the beginning. We provide ongoing support, maintenance, and improvements as your business evolves." }
      ],
      travelTitle: "Where Deep Expertise Meets Broad Capability",
      travelP1: "Travel technology is uniquely demanding — real-time data, multiple integrated systems, and customers who expect seamless experiences every time. Mastering this complexity gave us a foundation that strengthens everything else we build.",
      travelP2: "Today, SKYVISTA serves businesses across industries — but our travel-tech roots remain a core part of our identity, and a reason clients trust us with their most operationally complex challenges.",
      ctaTitle: "Let Us Build Something Together",
      ctaDesc: "Whether you are automating a workflow, modernizing a legacy system, or building something entirely new — we would like to hear about it.",
      ctaBtn: "Start a Conversation"
    },
    hi: {
      seoTitle: "हमारे बारे में",
      seoDesc: "SKYVISTA JOURNEYS LLP दुनिया भर के व्यवसायों को बेहतर सॉफ्टवेयर बनाने और कार्यों को स्वचालित करने में मदद करता है।",
      heroTitle: "हम ऐसी तकनीक बनाते हैं जो व्यवसाय को आगे बढ़ाती है",
      heroDesc: "SKYVISTA JOURNEYS LLP एक प्रौद्योगिकी कंपनी है जो दुनिया भर के व्यवसायों को स्मार्ट सॉफ्टवेयर बनाने, विश्वास के साथ विस्तार करने और कार्यों को ऑटोमेट करने में मदद करती है — ट्रैवल तकनीक में विशेष विशेषज्ञता के साथ।",
      storyTitle: "हमारी शुरुआत कैसे हुई",
      storyP1: "SKYVISTA JOURNEYS LLP की स्थापना एक सरल सोच के साथ हुई थी: अधिकांश व्यवसायों को केवल अधिक सॉफ्टवेयर की आवश्यकता नहीं है — उन्हें सही सॉफ्टवेयर चाहिए, जो उनके वास्तविक काम करने के तरीके के अनुरूप बना हो।",
      storyP2: "हमारी यात्रा ट्रैवल टेक्नोलॉजी से शुरू हुई, जहाँ हमें किसी भी उद्योग की सबसे जटिल परिचालन चुनौतियों का सामना करना पड़ा — रीयल-टाइम बुकिंग, कई सप्लायर्स का समन्वय और लगातार बढ़ती ग्राहकों की अपेक्षाएं। इन समस्याओं को हल करने से हमें दबाव में भी सटीक चलने वाली तकनीक बनाना सीखने को मिला।",
      storyP3: "वही अनुभव आज हमारे हर कार्य को आकार देता है — चाहे हम कोई ट्रैवल प्लेटफ़ॉर्म बना रहे हों, एंटरप्राइज वर्कफ़्लो ऑटोमेट कर रहे हों, या किसी अन्य उद्योग के व्यवसाय के लिए एआई समाधान तैयार कर रहे हों।",
      missionTitle: "हमारा मिशन",
      missionDesc: "हर आकार और उद्योग के व्यवसायों को ऐसी तकनीक के माध्यम से आगे बढ़ने और ऑटोमेट करने में सक्षम बनाना, जो उनकी वास्तविक आवश्यकताओं के अनुरूप बनाई गई हो — किसी सामान्य रेडीमेड टेम्पलेट की तरह नहीं।",
      visionTitle: "हमारा विजन",
      visionDesc: "दुनिया भर के व्यवसायों के लिए एक विश्वसनीय प्रौद्योगिकी साझेदार बनना — जो गहरी तकनीकी विशेषज्ञता के साथ-साथ उद्योगों की वास्तविक समझ रखने के लिए पहचाना जाए।",
      valuesTitle: "हमारे मूल सिद्धांत",
      values: [
        { title: "उद्देश्य के साथ निर्माण", desc: "कोड की हर पंक्ति किसी वास्तविक समस्या को हल करनी चाहिए। हम केवल बनाने के लिए नहीं — ठोस परिणामों के लिए काम करते हैं।" },
        { title: "बनाने से पहले समझना", desc: "हम एक भी लाइन कोड लिखने से पहले आपके व्यवसाय, ग्राहकों और सीमाओं को समझने के लिए पूरा समय देते हैं।" },
        { title: "प्रणालीगत सोच", desc: "तकनीक अलग-थलग काम नहीं करती। हम ऐसे समाधान डिज़ाइन करते हैं जो आपके व्यवसाय के विस्तार के साथ आसानी से जुड़ें और आगे बढ़ें।" },
        { title: "सार्थक ऑटोमेशन", desc: "एआई और ऑटोमेशन को काम आसान बनाना चाहिए, जटिल नहीं। हम ऐसा ऑटोमेशन बनाते हैं जिससे रोज़मर्रा का काम वास्तव में सुगम हो।" },
        { title: "पूर्ण उत्तरदायित्व", desc: "ग्राहकों के साथ हमारा संबंध प्रोजेक्ट लॉन्च के साथ समाप्त नहीं होता। हम निरंतर सहायता और दीर्घकालिक साझेदारी में विश्वास रखते हैं।" }
      ],
      approachTitle: "हमारी कार्यप्रणाली",
      stepPrefix: "चरण",
      approach: [
        { step: "समझना", desc: "हम सबसे पहले सुनते हैं — आपके व्यावसायिक लक्ष्यों, परिचालन बाधाओं और तकनीकी प्राथमिकताओं को।" },
        { step: "डिज़ाइन करना", desc: "हम ऐसे समाधान तैयार करते हैं जो व्यावहारिक और स्केलेबल हों — किसी पुराने टेम्पलेट की नकल नहीं।" },
        { step: "निर्माण करना", desc: "हमारी टीमें आधुनिक और सुरक्षित तकनीक पर नियमित प्रोग्रेस रिपोर्ट के साथ काम करती हैं।" },
        { step: "सहयोग देना", desc: "लॉन्च केवल पहली शुरुआत है। आपके व्यवसाय के साथ-साथ हम सिस्टम को निरंतर मेंटेन और अपडेट करते हैं।" }
      ],
      travelTitle: "जहाँ गहरी विशेषज्ञता व्यापक क्षमताओं से मिलती है",
      travelP1: "ट्रैवल तकनीक विशेष रूप से चुनौतीपूर्ण है — रीयल-टाइम डेटा, कई जुड़े हुए सप्लायर सिस्टम्स और तुरंत समाधान चाहने वाले ग्राहक। इस जटिलता को हल करने से हमें वह मजबूत आधार मिला जो हमारे बाकी सभी उत्पादों को भी मजबूत बनाता है।",
      travelP2: "आज, SKYVISTA विभिन्न उद्योगों के व्यवसायों को सेवाएं प्रदान करता है — लेकिन हमारे ट्रैवल-टेक अनुभव हमारी पहचान का मुख्य हिस्सा हैं और एक बड़ा कारण हैं कि ग्राहक जटिल चुनौतियों के लिए हम पर भरोसा करते हैं।",
      ctaTitle: "आइए मिलकर कुछ नया बनाएं",
      ctaDesc: "चाहे आप वर्कफ़्लो ऑटोमेट कर रहे हों, पुराने सिस्टम्स को आधुनिक बना रहे हों, या बिल्कुल नई तकनीक बना रहे हों — हम आपसे जुड़ना चाहते हैं।",
      ctaBtn: "बातचीत शुरू करें"
    }
  }[lang];

  return (
    <>
      <SEO title={content.seoTitle} description={content.seoDesc} />

      <section className="section text-center">
        <div className="container">
          <h1>{content.heroTitle}</h1>
          <p style={{ maxWidth: "720px", margin: "20px auto 0 auto" }}>{content.heroDesc}</p>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2>{content.storyTitle}</h2>
          <p style={{ marginTop: "16px" }}>{content.storyP1}</p>
          <p style={{ marginTop: "16px" }}>{content.storyP2}</p>
          <p style={{ marginTop: "16px" }}>{content.storyP3}</p>
        </div>
      </section>

      <section className="section">
        <div className="container grid grid-2">
          <div className="card">
            <h3>{content.missionTitle}</h3>
            <p style={{ marginTop: "12px" }}>{content.missionDesc}</p>
          </div>
          <div className="card">
            <h3>{content.visionTitle}</h3>
            <p style={{ marginTop: "12px" }}>{content.visionDesc}</p>
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2 className="text-center" style={{ marginBottom: "32px" }}>{content.valuesTitle}</h2>
          <div className="grid grid-3">
            {content.values.map((v) => (
              <div key={v.title} className="card">
                <h4>{v.title}</h4>
                <p style={{ marginTop: "8px" }}>{v.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <h2 className="text-center" style={{ marginBottom: "32px" }}>{content.approachTitle}</h2>
          <div className="grid grid-2">
            {content.approach.map((a, i) => (
              <div key={a.step} className="card">
                <h4>{content.stepPrefix} {i + 1}: {a.step}</h4>
                <p style={{ marginTop: "8px" }}>{a.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="section section-light">
        <div className="container">
          <h2>{content.travelTitle}</h2>
          <p style={{ marginTop: "16px" }}>{content.travelP1}</p>
          <p style={{ marginTop: "16px" }}>{content.travelP2}</p>
        </div>
      </section>

      <section className="section section-dark text-center">
        <div className="container">
          <h2>{content.ctaTitle}</h2>
          <p style={{ margin: "16px 0 32px 0" }}>{content.ctaDesc}</p>
          <Link to="/contact" className="btn-primary">{content.ctaBtn}</Link>
        </div>
      </section>
    </>
  );
}