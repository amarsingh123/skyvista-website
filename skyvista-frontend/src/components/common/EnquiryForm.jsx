import { useState } from "react";
import { useTranslation } from "react-i18next";
import { submitEnquiry } from "../../services/api";
import "./EnquiryForm.css";

export default function EnquiryForm() {
  const { i18n } = useTranslation();
  const lang = i18n.language && i18n.language.startsWith("hi") ? "hi" : "en";

  const labels = {
    en: {
      fullName: "Full Name *",
      email: "Email Address *",
      phone: "Phone Number",
      company: "Company Name",
      servicePrompt: "Service Interested In *",
      message: "Message / Project Details *",
      submit: "Submit Enquiry",
      submitting: "Submitting...",
      error: "Something went wrong. Please try again or email us directly.",
      services: [
        { value: "software_development", label: "Custom Software Development" },
        { value: "enterprise_solutions", label: "Enterprise Solutions" },
        { value: "cloud_devops", label: "Cloud & DevOps" },
        { value: "ai_automation", label: "AI & Automation" },
        { value: "it_consulting", label: "IT Consulting & Support" },
        { value: "travel_technology", label: "Travel Technology" },
        { value: "other", label: "Other / Not Sure" }
      ]
    },
    hi: {
      fullName: "पूरा नाम *",
      email: "ईमेल पता *",
      phone: "फ़ोन नंबर",
      company: "कंपनी का नाम",
      servicePrompt: "रुचि की सेवा चुनें *",
      message: "संदेश / प्रोजेक्ट विवरण *",
      submit: "पूछताछ भेजें",
      submitting: "भेज रहे हैं...",
      error: "कुछ गड़बड़ हुई। कृपया पुनः प्रयास करें या सीधे ईमेल भेजें।",
      services: [
        { value: "software_development", label: "कस्टम सॉफ्टवेयर डेवलपमेंट" },
        { value: "enterprise_solutions", label: "एंटरप्राइज सॉल्यूशंस" },
        { value: "cloud_devops", label: "क्लाउड और डेवऑप्स" },
        { value: "ai_automation", label: "एआई और ऑटोमेशन" },
        { value: "it_consulting", label: "आईटी कंसल्टिंग और सपोर्ट" },
        { value: "travel_technology", label: "ट्रैवल टेक्नोलॉजी" },
        { value: "other", label: "अन्य / निश्चित नहीं" }
      ]
    }
  }[lang];

  const [form, setForm] = useState({
    full_name: "", email: "", phone: "", company_name: "",
    service_interested: "", message: ""
  });
  const [status, setStatus] = useState({ loading: false, success: "", error: "" });

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setStatus({ loading: true, success: "", error: "" });
    try {
      const res = await submitEnquiry(form);
      setStatus({ loading: false, success: res.data.message, error: "" });
      setForm({ full_name: "", email: "", phone: "", company_name: "", service_interested: "", message: "" });
    } catch (err) {
      setStatus({ loading: false, success: "", error: labels.error });
    }
  };

  return (
    <form className="enquiry-form" onSubmit={handleSubmit}>
      <input name="full_name" placeholder={labels.fullName} value={form.full_name} onChange={handleChange} required />
      <input name="email" type="email" placeholder={labels.email} value={form.email} onChange={handleChange} required />
      <input name="phone" placeholder={labels.phone} value={form.phone} onChange={handleChange} />
      <input name="company_name" placeholder={labels.company} value={form.company_name} onChange={handleChange} />
      <select name="service_interested" value={form.service_interested} onChange={handleChange} required>
        <option value="">{labels.servicePrompt}</option>
        {labels.services.map(opt => (
          <option key={opt.value} value={opt.value}>{opt.label}</option>
        ))}
      </select>
      <textarea name="message" placeholder={labels.message} rows="5" value={form.message} onChange={handleChange} required />
      <button type="submit" className="btn-primary" disabled={status.loading}>
        {status.loading ? labels.submitting : labels.submit}
      </button>
      {status.success && <p className="form-success">{status.success}</p>}
      {status.error && <p className="form-error">{status.error}</p>}
    </form>
  );
}