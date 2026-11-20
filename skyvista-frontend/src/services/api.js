import axios from "axios";

const API_BASE = import.meta.env.VITE_API_BASE_URL || "http://localhost:8000/api";

const api = axios.create({ baseURL: API_BASE, timeout: 10000 });

export const submitEnquiry = (data) => api.post("/enquiries/", data);
export const getBlogPosts = (category = "") =>
  api.get(`/blog/${category ? `?category=${category}` : ""}`);
export const getBlogPost = (slug) => api.get(`/blog/${slug}/`);
export const getCaseStudies = (category = "") =>
  api.get(`/portfolio/${category ? `?service_category=${category}` : ""}`);
export const getFAQs = () => api.get("/faq/");

export default api;
