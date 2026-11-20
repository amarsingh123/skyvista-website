import { Component } from "react";

export default class ErrorBoundary extends Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  componentDidCatch(error, errorInfo) {
    console.error("ErrorBoundary caught:", error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div style={{ padding: "60px 24px", textAlign: "center" }}>
          <h1 style={{ color: "#EF4444" }}>Something went wrong</h1>
          <p style={{ marginTop: "16px", color: "#475569" }}>
            {this.state.error?.toString()}
          </p>
          <pre style={{ textAlign: "left", background: "#F6F9FC", padding: "16px", marginTop: "20px", overflow: "auto", borderRadius: "8px" }}>
            {this.state.error?.stack}
          </pre>
          <a href="/" style={{ display: "inline-block", marginTop: "24px", color: "#1FA9E5", fontWeight: 600 }}>
            ← Back to Home
          </a>
        </div>
      );
    }
    return this.props.children;
  }
}
