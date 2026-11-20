import { useState } from "react";
import { useTranslation } from "react-i18next";
import SEO from "../components/common/SEO";
import EnquiryForm from "../components/common/EnquiryForm";

const FAQ_COLLECTION = {
  en: {
    seoTitle: "FAQ",
    seoDesc: "Answers to common questions about our services, process, and how we work.",
    heroTitle: "Frequently Asked Questions",
    heroDesc: "Answers to common questions about our services, process, and how we work.",
    stillQuestionsTitle: "Still Have Questions?",
    stillQuestionsDesc: "Reach out directly, and our team will get back to you.",
    categories: [
      {
        category: "General",
        items: [
          { q: "What does SKYVISTA JOURNEYS LLP do?", a: "We are a technology company providing custom software development, enterprise solutions, cloud services, AI automation, and IT consulting — with specialized expertise in travel technology." },
          { q: "What industries do you work with?", a: "We work with businesses across industries, including travel, enterprise, retail, and startups. Our travel technology expertise is a particular strength, but our services apply broadly across sectors." },
          { q: "Where is SKYVISTA JOURNEYS LLP located?", a: "Our office is located in Janakpuri West, New Delhi, India. We work with clients both domestically and internationally." },
          { q: "Do you work with international clients?", a: "Yes. We work with businesses across different countries and time zones, and we structure our communication and delivery processes accordingly." }
        ]
      },
      {
        category: "Services",
        items: [
          { q: "Do you build custom software, or do you use pre-built templates?", a: "All our software is custom-built around each client specific business needs. We do not rely on generic templates or one-size-fits-all products." },
          { q: "Can you help modernize an existing system instead of building something new?", a: "Yes. Application modernization is part of our Enterprise Solutions and IT Consulting services." },
          { q: "Do you offer ongoing support after a project is completed?", a: "Yes. We provide ongoing maintenance and support for all the solutions we build." },
          { q: "What cloud platforms do you work with?", a: "We work with major cloud providers, including AWS, Microsoft Azure, and Google Cloud." }
        ]
      },
      {
        category: "AI & Automation",
        items: [
          { q: "What kind of AI solutions do you build?", a: "We build AI-powered chatbots, workflow automation systems, intelligent document processing tools, predictive analytics models, and custom AI integrations." },
          { q: "Can AI be added to software we already use?", a: "Yes. We specialize in integrating AI capabilities into existing systems." },
          { q: "How do I know if AI automation is right for my business?", a: "If your team spends significant time on repetitive manual tasks, or if you have unused data, AI automation is likely to deliver meaningful value." }
        ]
      },
      {
        category: "Travel Technology",
        items: [
          { q: "What kind of travel technology solutions do you build?", a: "B2B and B2C travel portals, booking engines, and API integrations with travel suppliers." },
          { q: "Do you build custom booking engines?", a: "Yes. We design and develop custom booking systems tailored to your specific business model." },
          { q: "We are a non-travel business — can you still help us?", a: "Absolutely. Our software, cloud, enterprise, and AI services apply to businesses across all industries." }
        ]
      },
      {
        category: "Process & Engagement",
        items: [
          { q: "How does a typical project start?", a: "Every engagement begins with a discovery conversation to understand your business goals, challenges, and requirements." },
          { q: "How long does a typical project take?", a: "Timelines vary depending on project scope and complexity. We provide a clear estimate after discovery." },
          { q: "Do you offer dedicated teams, or only fixed-scope projects?", a: "We offer flexible engagement models, including dedicated teams, fixed-scope projects, and ongoing consulting." },
          { q: "How do I get started?", a: "Submit an enquiry through our Contact page, and our team will reach out to schedule a conversation." }
        ]
      }
    ]
  },
  hi: {
    seoTitle: "अक्सर पूछे जाने वाले सवाल",
    seoDesc: "हमारी सेवाओं, कार्यप्रणाली और सहयोग के तरीकों से जुड़े सामान्य प्रश्नों के उत्तर।",
    heroTitle: "अक्सर पूछे जाने वाले सवाल (FAQ)",
    heroDesc: "हमारी सेवाओं, कार्यप्रणाली और सहयोग के तरीकों से जुड़े सामान्य प्रश्नों के उत्तर।",
    stillQuestionsTitle: "क्या आपके पास अभी भी कोई प्रश्न है?",
    stillQuestionsDesc: "हमसे सीधे संपर्क करें, और हमारी टीम शीघ्र ही आपसे जुड़ेगी।",
    categories: [
      {
        category: "सामान्य प्रश्न",
        items: [
          { q: "SKYVISTA JOURNEYS LLP क्या करती है?", a: "हम एक प्रौद्योगिकी कंपनी हैं जो कस्टम सॉफ्टवेयर डेवलपमेंट, एंटरप्राइज सॉल्यूशंस, क्लाउड सर्विसेज, AI ऑटोमेशन और IT कंसल्टिंग प्रदान करती हैं — ट्रैवल तकनीक में विशेष अनुभव के साथ।" },
          { q: "आप किन उद्योगों के साथ काम करते हैं?", a: "हम ट्रैवल, एंटरप्राइज, रिटेल और स्टार्टअप्स सहित विभिन्न उद्योगों के साथ काम करते हैं। ट्रैवल टेक्नोलॉजी हमारी मुख्य ताकत है, पर हमारी सेवाएं सभी सेक्टर्स में प्रभावी हैं।" },
          { q: "SKYVISTA का कार्यालय कहाँ स्थित है?", a: "हमारा कार्यालय जनकपुरी वेस्ट, नई दिल्ली, भारत में है। हम घरेलू और अंतरराष्ट्रीय दोनों प्रकार के ग्राहकों को सेवाएं देते हैं।" },
          { q: "क्या आप अंतरराष्ट्रीय ग्राहकों के साथ काम करते हैं?", a: "हाँ। हम विभिन्न देशों और टाइम-ज़ोन के ग्राहकों के साथ काम करते हैं और उसी अनुसार संचार व प्रोजेक्ट डिलीवरी समन्वय करते हैं।" }
        ]
      },
      {
        category: "सेवाएं",
        items: [
          { q: "क्या आप कस्टम सॉफ्टवेयर बनाते हैं या रेडीमेड टेम्पलेट का उपयोग करते हैं?", a: "हमारा प्रत्येक सॉफ्टवेयर क्लाइंट की विशिष्ट व्यावसायिक जरूरतों के अनुसार शून्य से कस्टमाइज्ड बनाया जाता है। हम किसी रेडीमेड टेम्पलेट का प्रयोग नहीं करते।" },
          { q: "क्या आप नए सिस्टम बनाने के बजाय पुराने सिस्टम को अपग्रेड कर सकते हैं?", a: "हाँ। एप्लिकेशन आधुनिकीकरण हमारी एंटरप्राइज सॉल्यूशंस और IT कंसल्टिंग सेवाओं का मुख्य हिस्सा है।" },
          { q: "क्या प्रोजेक्ट पूरा होने के बाद भी सपोर्ट मिलता है?", a: "हाँ। हम अपने बनाए गए सभी समाधानों के लिए निरंतर मेंटेनेंस और तकनीकी सपोर्ट उपलब्ध कराते हैं।" },
          { q: "आप किन क्लाउड प्लेटफ़ॉर्म पर काम करते हैं?", a: "हम AWS, Microsoft Azure और Google Cloud सहित सभी प्रमुख प्रदाताओं के साथ काम करते हैं।" }
        ]
      },
      {
        category: "एआई और ऑटोमेशन",
        items: [
          { q: "आप किस प्रकार के AI समाधान तैयार करते हैं?", a: "हम AI चैटबॉट, वर्कफ़्लो ऑटोमेशन, डॉक्यूमेंट प्रोसेसिंग टूल्स, प्रेडिक्टिव एनालिटिक्स और कस्टम AI इंटीग्रेशन बनाते हैं।" },
          { q: "क्या हमारे मौजूदा सॉफ्टवेयर में AI जोड़ा जा सकता है?", a: "हाँ। हम पुराने या मौजूदा सॉफ्टवेयर में आधुनिक AI क्षमताएं इंटीग्रेट करने में दक्ष हैं।" },
          { q: "मुझे कैसे पता चलेगा कि मेरे बिजनेस को AI की जरूरत है?", a: "यदि आपकी टीम का समय बार-बार दोहराए जाने वाले कामों में बीतता है या आपके पास अप्रयुक्त डेटा है, तो AI ऑटोमेशन निश्चित ही आपके लिए लाभकारी होगा।" }
        ]
      },
      {
        category: "ट्रैवल टेक्नोलॉजी",
        items: [
          { q: "आप ट्रैवल क्षेत्र में क्या समाधान बनाते हैं?", a: "B2B और B2C ट्रैवल पोर्टल्स, कस्टम बुकिंग इंजन, और एयरलाइंस/होटल सप्लायर्स के साथ API इंटीग्रेशन।" },
          { q: "क्या आप कस्टम बुकिंग इंजन बना सकते हैं?", a: "हाँ। हम आपके व्यावसायिक मॉडल और सप्लायर नेटवर्क के अनुसार कस्टम बुकिंग इंजन तैयार करते हैं।" },
          { q: "हम ट्रैवल बिजनेस नहीं हैं — क्या आप हमारी मदद कर सकते हैं?", a: "बिल्कुल। हमारी सॉफ्टवेयर, क्लाउड, एंटरप्राइज और AI सेवाएं सभी उद्योगों के व्यवसायों पर समान रूप से लागू होती हैं।" }
        ]
      },
      {
        category: "प्रक्रिया और जुड़ाव",
        items: [
          { q: "प्रोजेक्ट की शुरुआत कैसे होती है?", a: "हर जुड़ाव एक प्रारंभिक चर्चा से शुरू होता है ताकि आपके लक्ष्यों और तकनीकी आवश्यकताओं को समझा जा सके।" },
          { q: "एक सामान्य प्रोजेक्ट में कितना समय लगता है?", a: "समयसीमा प्रोजेक्ट के दायरे और जटिलता पर निर्भर करती है। प्रारंभिक समीक्षा के बाद हम स्पष्ट टाइमलाइन साझा करते हैं।" },
          { q: "क्या आप समर्पित डेवलपर्स उपलब्ध कराते हैं?", a: "हाँ, हम समर्पित डेवलपर टीम, फिक्स्ड-स्कोप प्रोजेक्ट और कंसल्टिंग जैसे लचीले मॉडल्स प्रदान करते हैं।" },
          { q: "हम शुरुआत कैसे करें?", a: "हमारे संपर्क पेज पर फॉर्म भरें, और हमारी टीम आपसे बैठक निर्धारित करने के लिए संपर्क करेगी।" }
        ]
      }
    ]
  }
};

export default function FAQ() {
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";
  const data = FAQ_COLLECTION[lang];
  const [openIndex, setOpenIndex] = useState(null);

  return (
    <>
      <SEO title={data.seoTitle} description={data.seoDesc} />

      <section className="section text-center section-light">
        <div className="container">
          <h1>{data.heroTitle}</h1>
          <p style={{ marginTop: "16px" }}>{data.heroDesc}</p>
        </div>
      </section>

      <section className="section">
        <div className="container" style={{ maxWidth: "800px" }}>
          {data.categories.map((cat) => (
            <div key={cat.category} style={{ marginBottom: "40px" }}>
              <h3 style={{ marginBottom: "16px" }}>{cat.category}</h3>
              {cat.items.map((item, i) => {
                const key = cat.category + i;
                const isOpen = openIndex === key;
                return (
                  <div
                    key={key}
                    className="card"
                    style={{ marginBottom: "12px", cursor: "pointer" }}
                    onClick={() => setOpenIndex(isOpen ? null : key)}
                  >
                    <strong>{item.q}</strong>
                    {isOpen && <p style={{ marginTop: "8px" }}>{item.a}</p>}
                  </div>
                );
              })}
            </div>
          ))}
        </div>
      </section>

      <section className="section section-light">
        <div className="container text-center">
          <h2>{data.stillQuestionsTitle}</h2>
          <p style={{ margin: "16px 0 32px 0" }}>{data.stillQuestionsDesc}</p>
          <div style={{ display: "flex", justifyContent: "center" }}>
            <EnquiryForm />
          </div>
        </div>
      </section>
    </>
  );
}