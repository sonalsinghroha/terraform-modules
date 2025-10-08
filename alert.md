# Documentation on Alerting Rules, Severity Levels, Notification Channels & Escalation Process for App Monitoring using Alertmanager

<img width="295" height="171" alt="download" src="https://github.com/user-attachments/assets/55453275-9b9e-4c78-a401-d0906df0960f" />

---

## Author Information

| Last Updated On | Version | Author          | Level           | Reviewer       |
| --------------- | ------- | --------------- | --------------- | -------------- |
| 08-10-2025      | V1.2    | Kawalpreet Kour | Internal Review | Sharvari       |
|                 |         | Kawalpreet Kour | L0              | Shreya         |
|                 |         | Kawalpreet Kour | L1              | Abhishek V     |
|                 |         | Kawalpreet Kour | L2              | Abhishek Dubey |

---

<details>
  <summary><h2><strong>Table of Contents</strong></h2></summary>

1. [Introduction](#introduction)
2. [What Are Alerting Rules?](#what-are-alerting-rules)
3. [Severity Levels](#severity-levels)
4. [Notification Channels](#notification-channels)
5. [Escalation Process](#escalation-process)
6. [Process of App Monitoring using Alertmanager](#process-of-app-monitoring-using-alertmanager)
7. [Common Alert Rules for Applications](#common-alert-rules-for-applications)
8. [Advantages of Alerting](#advantages-of-alerting)
9. [Limitations and Challenges](#limitations-and-challenges)
10. [Best Practices for Alerting](#best-practices-for-alerting)
11. [Conclusion](#conclusion)
12. [FAQs](#faqs)
13. [Contact Information](#contact-information)
14. [References](#references)

</details>

---

## Introduction

Application monitoring ensures the health, performance, and availability of services.
**Alerting rules** act like an early warning system—detecting anomalies and notifying responsible teams before users are affected.
**Alertmanager**, integrated with **Prometheus**, automates alert routing, grouping, and escalation through defined notification channels and severity levels.

---

## What Are Alerting Rules?

Alerting rules are predefined conditions in Prometheus that continuously evaluate metrics.
When a defined threshold is breached, an alert is generated and sent to **Alertmanager**, which processes and routes it to appropriate channels.

Example (YAML snippet):

```yaml
groups:
  - name: app_alerts
    rules:
      - alert: HighCPUUsage
        expr: avg(rate(process_cpu_seconds_total[5m])) * 100 > 80
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High CPU usage detected on {{ $labels.instance }}"
          description: "CPU usage has exceeded 80% for more than 5 minutes."
```

---

## Severity Levels

Each alert should have a **severity label** defining its importance and response priority.

| Severity Level | Definition                                              | Example Scenarios                             | Action / Response Time               |
| -------------- | ------------------------------------------------------- | --------------------------------------------- | ------------------------------------ |
| **Critical**   | Major outage or service down affecting users            | App or API not responding, database failure   | Immediate escalation to L2/L3        |
| **High**       | Significant performance degradation or resource overuse | CPU > 90%, Memory > 85%, Error rate > 10%     | Response within 10–15 minutes        |
| **Medium**     | Non-critical but needs attention                        | High latency, disk usage > 80%, queue backlog | Response within 30–45 minutes        |
| **Low**        | Informational or minor issues                           | Service restart, config drift, warning events | Review in daily check or next sprint |

 *Severity helps prioritize response and reduces alert fatigue.*

---

## Notification Channels

Alertmanager supports multiple notification integrations for quick incident response.

| Channel Type                | Purpose                           | Example / Tool         | Usage Scenario                                                   |
| --------------------------- | --------------------------------- | ---------------------- | ---------------------------------------------------------------- |
| **Email**                   | Default notification channel      | Gmail, Outlook         | For general system alerts                                        |
| **Slack / Microsoft Teams** | Instant team collaboration        | Slack Incoming Webhook | For on-call & ops team notifications                             |
| **PagerDuty / OpsGenie**    | Incident escalation management    | PagerDuty Integration  | For production-level critical alerts                             |
| **SMS / Phone Call**        | Urgent, high-impact alerts        | Twilio / PagerDuty     | For critical outage alerts                                       |
| **Webhook / Custom API**    | Integration with automation tools | REST endpoints         | For auto-remediation or ticket creation (e.g., ServiceNow, Jira) |

Example Alertmanager config:

```yaml
route:
  receiver: 'slack_notifications'
  group_by: ['alertname', 'severity']

receivers:
  - name: 'slack_notifications'
    slack_configs:
      - channel: '#app-alerts'
        send_resolved: true
        title: '[{{ .Status | toUpper }}] {{ .CommonLabels.alertname }}'
        text: "{{ .CommonAnnotations.description }}"
```

---

## Escalation Process

An escalation process ensures that unacknowledged alerts are automatically passed to higher levels.

| Escalation Level         | Responsible Team            | Trigger Condition                | Escalation Time |
| ------------------------ | --------------------------- | -------------------------------- | --------------- |
| **Level 1 (L1)**         | On-call Engineer            | Alert triggered                  | Immediate       |
| **Level 2 (L2)**         | Senior Engineer / App Owner | Alert unresolved > 15 mins       | 15 minutes      |
| **Level 3 (L3)**         | DevOps / SRE Lead           | Alert unresolved > 30 mins       | 30 minutes      |
| **Level 4 (Management)** | IT Manager / CTO            | Major outage continues > 60 mins | 1 hour          |

 **Automation:**
Alertmanager routes alerts to **Slack → PagerDuty → Email** sequentially until acknowledgment is received.

 **Review:**
Post-resolution, the team performs **RCA (Root Cause Analysis)** and updates alerting thresholds or rules if required.

---

## Process of App Monitoring using Alertmanager

| Step  | Stage                        | Description                                                                 |
| ----- | ---------------------------- | --------------------------------------------------------------------------- |
| **1** | **Metrics Collection**       | Prometheus scrapes metrics from app and infra (CPU, memory, response time). |
| **2** | **Rule Evaluation**          | Alerting rules are evaluated periodically (defined in YAML).                |
| **3** | **Alert Triggering**         | If threshold is breached, Prometheus triggers an alert.                     |
| **4** | **Alert Grouping & Routing** | Alertmanager groups and routes alerts based on labels (e.g., severity).     |
| **5** | **Notification Dispatch**    | Alerts sent to Slack, Email, or PagerDuty as per configuration.             |
| **6** | **Escalation Handling**      | If not acknowledged, alerts are auto-escalated per escalation policy.       |
| **7** | **Resolution & Review**      | Once resolved, alerts auto-close and RCA is performed.                      |

---

## Common Alert Rules for Applications

| Alert Rule                 | Condition / Threshold Example | Severity | Notification Channel | Escalation        |
| -------------------------- | ----------------------------- | -------- | -------------------- | ----------------- |
| **High CPU Usage**         | CPU > 80% for 5 min           | High     | Slack / PagerDuty    | L1 → L2 after 15m |
| **Memory Utilization**     | Memory > 90%                  | Critical | PagerDuty / SMS      | Immediate to L2   |
| **Service Down**           | Health check fail for 1 min   | Critical | Email + Slack        | L1 → L2 instantly |
| **High Error Rate**        | HTTP 5xx > 5%                 | Critical | Slack / Email        | L1 → L2 (10m)     |
| **High Latency**           | Response time > 2s            | Medium   | Slack                | L1 only           |
| **Disk Space Low**         | Disk usage > 85%              | High     | Email                | L1 → L2 (20m)     |
| **DB Connection Failures** | > 50 errors/min               | Critical | PagerDuty            | Immediate         |
| **Queue Lag**              | Queue length > threshold      | Medium   | Slack                | L1 only           |
| **App Restart Detected**   | Restart count > 3/hr          | Low      | Email                | L1 review daily   |

---

## Advantages of Alerting

| Advantage                    | Description                                  |
| ---------------------------- | -------------------------------------------- |
| **Faster Incident Response** | Alerts reach the right team instantly.       |
| **Reduced Downtime**         | Quick detection = quicker recovery.          |
| **Improved Visibility**      | Real-time health view of apps.               |
| **Automated Escalations**    | No manual tracking for unresolved alerts.    |
| **Actionable Insights**      | Alerts include details for immediate action. |

---

## Limitations and Challenges

| Limitation               | Description                                         |
| ------------------------ | --------------------------------------------------- |
| **Alert Fatigue**        | Too many alerts can desensitize teams.              |
| **False Alarms**         | Poorly defined thresholds cause noise.              |
| **Integration Overhead** | Managing multiple channels can be complex.          |
| **Escalation Delays**    | If automation fails, manual escalation is required. |

---

## Best Practices for Alerting

 Use **severity labels** consistently.
 Define **realistic thresholds** using historical data.
 Configure **grouping and inhibition rules** in Alertmanager.
 Integrate with **Slack/PagerDuty** for immediate visibility.
 Regularly review **false alerts** and refine rules.
 Perform **RCA** after each critical incident.

---

## Conclusion

**Prometheus + Alertmanager** together enable intelligent, automated, and structured alerting.
With clearly defined **alert rules**, **severity levels**, **notification channels**, and **escalation policies**, teams can ensure proactive monitoring, faster response, and minimal downtime.

---

## FAQs

**Q:** What is the purpose of severity in alerts?
**A:** Severity defines how critical an issue is and determines who gets notified and how quickly they should respond.

**Q:** Can I use multiple notification channels?
**A:** Yes, Alertmanager supports simultaneous multi-channel notifications.

**Q:** How can I prevent alert fatigue?
**A:** Prioritize actionable alerts, review rules frequently, and use silencing/inhibition.

---

## Contact Information

| Name                | Email                                                                                   |
| ------------------- | --------------------------------------------------------------------------------------- |
| **Kawalpreet Kour** | [kawalpreet.kour.snaatak@mygurukulam.co](mailto:kawalpreet.kour.snaatak@mygurukulam.co) |

---

## References

| Description                 | Link                                                                                           |
| --------------------------- | ---------------------------------------------------------------------------------------------- |
| Prometheus Alerting Rules   | [Prometheus - Alertmanager Docs](https://prometheus.io/docs/alerting/latest/alertmanager/)     |
| Alertmanager Configuration  | [Prometheus Configuration Examples](https://prometheus.io/docs/alerting/latest/configuration/) |
| Best Practices for Alerting | [Datadog Monitoring Guide](https://www.datadoghq.com/monitoring-alerting-guide/)               |

---
