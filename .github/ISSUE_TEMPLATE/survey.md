---
name: Engineering Survey
about: Engineering Fundamentals Survey
title: ''
labels: Retro
assignees: ''

---

### How well was the backlog maintained

- [ ] We did not use a backlog.
- [ ] We created a backlog, but did not maintain it.
- [ ] Our backlog was loosely defined for the project.
- [ ] Our backlog was organized into well-defined work items.
- [ ] Our backlog was organized into well-defined work items and was actively maintained.
- [ ] Our backlog was thorough, maintained, and every pull request was associated with a work item.

### How effective was sprint planning

- [ ] We did not do any planning.
- [ ] We planned some of the work.
- [ ] We planned but did not estimate the work.
- [ ] We underestimated and didn’t close out the sprint.
- [ ] All work was planned and well estimated.
- [ ] All work was planned, well estimated, and had well-defined acceptance criteria.

### How useful were stand ups

- [ ] We didn't have stand ups.
- [ ] We didn’t meet with any regular cadence.
- [ ] Participation was not consistent.
- [ ] They were too long, with too much detail.
- [ ] People shared updates, but I usually didn’t get unblocked.
- [ ] Very efficient. People shared openly and received the help they needed.

### How informative was the retrospective

- [ ] We didn’t have a retrospective.
- [ ] We had a retrospective because they are part of our process, but it wasn't useful.
- [ ] Retrospectives helped us understand and improve some aspects of the project and team interactions.
- [ ] Retrospectives were key to our team’s success. We surfaced areas of improvement and acted on them.

### How thorough were design reviews

- [ ] We didn’t do any design reviews.
- [ ] We did a high-level system/architecture review.
- [ ] We produced and reviewed architecture and component/sequence/data flow diagrams.
- [ ] We produced and reviewed all design artifacts and solicited feedback from domain experts.
- [ ] We produced and reviewed all design artifacts and solicited feedback from domain experts. As the project progressed, we actively validated and updated our designs, based on our learnings.

### How effective were code reviews

- [ ] We didn’t review code changes
- [ ] We used automated tooling to enforce basic convention/standards.
- [ ] We used automated tooling to enforce basic convention/standards. Code changes required approval from one individual on the team.
- [ ] We used automated tooling to enforce basic convention/standards. Code changes required approval from two or more individuals on the team.
- [ ] We used automated tooling to enforce basic convention/standards. Code changes required approval from two or more individuals on the team. Domain experts were added to reviews, when applicable.

### How were changes introduced to the codebase

- [ ] No governance; anyone could introduce changes to any part/branch of the codebase.
- [ ] Branches were used to isolate new changes and folded into an upstream branch via Pull Request.
- [ ] Branches were used to isolate new changes and folded into an upstream branch via Pull Request. Pull Requests were scoped to smaller, more granular changes.
- [ ] Branches were used to isolate new changes. Pull Requests were used to fold changes into a primary working branch. Multiple upstream branches were used to manage changes. Main is always shippable. Branch policies and/or commit hooks were in place.
- [ ] Branches were used to isolate new changes. Pull Requests were used to fold changes into a primary working branch. Branch names and commit message(s) follow a convention and always reference back to a work item. Multiple upstream branches were used to manage/validate/promote changes. Main represents `last known good` and is always shippable. Branch policies and/or commit hooks were in place.

### How rigorous was the code validation

- [ ] We did not do any testing.
- [ ] Our work was primarily validated through manual testing.
- [ ] We consciously did not allocate time for automated testing.
- [ ] Automated tests existed in the project, but were challenging to run.
- [ ] New tests or test modifications accompanied every significant code change.
- [ ] Our project contained automated tests, every check-in must have a test, and they ran as part of CI.

### How smooth was continuous integration

- [ ] We didn’t have any continuous integration configured.
- [ ] Builds were always done on a central build server.
- [ ] Builds are always done on a central build server. Automated tests prevented check-ins that would result in a broken build, for some of the code bases.
- [ ] Builds are always done on a central build server. Automated tests prevented check-ins that would result in a broken build, for all the code bases.
- [ ] Builds are always done on a central build server. Automated tests prevented check-ins that would result in a broken build, for all the code bases. Built artifacts were always shared from a central artifact/package server.

### How reliable was continuous delivery

- [ ] We didn’t have any continuous delivery configured.
- [ ] We had scripts for some deployments.
- [ ] We had scripts for both creating and deploying some services to an environment.
- [ ] We had scripts for both creating and deploying all services to an environment.
- [ ] There were multiple environments and deployments into them were automated and well understood.

### How was observability achieved

- [ ] We didn’t add any logging, metrics, tracing, or monitoring.
- [ ] We added some logging, metrics, tracing, and/or monitoring but it was not done consistently across all system components.
- [ ] We added logging, metrics, tracing, and/or monitoring across most components. However, the implementation was not complete; ex) we did not use correlation ids or business context was missing or alerts were not defined for monitored components, etc.
- [ ] We added extensive logging, metrics, tracing, and monitoring alerts to facilitate debugging, viewing of historical trends, understanding control flow, and the current state of the system.
- [ ] We designed and implemented instrumentation to help run the solution with the goal of adding value to the customer.

### How was security evaluated in this engagement

- [ ] We did not evaluate security as a part of this engagement.
- [ ] Security was evaluated only at the end of the engagement; little to no time was available to remediate issues.
- [ ] Security was evaluated only at the end of the engagement; there was time remaining prior to hand-off to fix issues (if needed).
- [ ] Secure design was considered during the design and implementation phases but with no ongoing support.
- [ ] Secure design was considered during the design and implementation phases, and ongoing automated testing was introduced to the DevSecOps process prior to hand off.

### How was impactful Product Group engineering feedback provided

- [ ] Microsoft products/services worked flawlessly without any issues, therefore, there was no engineering feedback to share.
- [ ] We encountered some friction with Microsoft products/services but didn’t submit any engineering feedback for the Product Group.
- [ ] We shared our feedback directly with the Product Group but only in an ad-hoc manner (i.e. via email, teams, etc).
- [ ] Mostly at the end of the engagement, we submitted some engineering feedback via CSE Feedback tool.
- [ ] On an ongoing basis, we submitted all of the relevant high-quality feedback via CSE Feedback tool, including priority, scenario-based description, repro steps with screenshots, and attached relevant email threads with the Product Group.
