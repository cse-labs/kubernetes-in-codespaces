# Working Agreement

## Goal

This living document represents the principles and expected behavior of everyone involved in the project. It is not meant to be exhaustive nor  complete. The team should be accountable to these standards and revisit, review, and revise as needed. The agreement is signed off by everyone.

## Code of Conduct

We pledge to follow the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/):

- **Be friendly and patient**: Remember you might not be communicating in someone else's primary spoken or programming language, and others may not have your level of understanding.
- **Be welcoming**: Our communities welcome and support people of all backgrounds and identities. This includes, but is not limited to members of any race, ethnicity, culture, national origin, color, immigration status, social and economic class, educational level, sex, sexual orientation, gender identity and expression, age, size, family status, political belief, religion, and mental and physical ability.
- **Be respectful**: We are a world-wide community of professionals, and we conduct ourselves professionally. Disagreement is no excuse for poor behavior and poor manners. Disrespectful and unacceptable behavior includes, but is not limited to:
  - Violent threats or language.
  - Discriminatory or derogatory jokes and language.
  - Posting sexually explicit or violent material.
  - Posting, or threatening to post, people's personally identifying information ("doxing").
  - Insults, especially those using discriminatory terms or slurs.
  - Behavior that could be perceived as sexual attention.
  - Advocating for or encouraging any of the above behaviors.
- **Understand disagreements**: Disagreements, both social and technical, are useful learning opportunities. Seek to understand the other viewpoints and resolve differences constructively.
- This code is not exhaustive or complete. It serves to capture our common understanding of a productive, collaborative environment. We expect the code to be followed in spirit as much as in the letter.

## How we work together

Teams and feature crews should feel free to be flexible based on your life situation - especially during COVID. Many of us work split schedules to accomodate our personal lives and health. You should feel empowered to work "your" schedule. 

### Model, Coach, Care

We should personally practice a growth mindset with three skills in particular: active role modeling, coaching others to be active role models, and showing care about team members and their personal growth.

We should all display accountability, integrity, and respect.

At every level, we practice Two-in-a-Box project management. If something is not right, you have permission to hold leads accountable. If you see something, say something.

### Timezones

Our crews are distributed across timezones and across the world. Where possible, we will have ceremonies and meetings at a time convenient to everyone. Where it's not possible, we will do our best to share the timezone tax. We don't currently have "core hours" but may consider implementing them in the future.

### How we track and share information

- We will prefer our Teams General Channel for discussions or questions over email
- We will use Teams for meetings and calls
- Teams and email communication are asynchronous, especially with crews based in different regions
- We will make documentation accessible:
  | Type | Where? | Examples |
  |------|--------|----------|
  | Organization Artifacts | ArtifactHub | Game Plan, SDD, draft documents |
  | Project Artifacts | Teams Channel Files | ADS agenda, Sprint Review videos, Meeting Notes |
  | Project Documentation | GitHub Repo | Working Agreement, code of conduct, high-level overview |
  | Architecture / Designs | GitHub Repo| Technical Design documents |

## How we plan together

### Work Items

- We will track our work in GitHub
- We will prefer public repos when possible
- Our sprint work items will follow the hierarchy:  --
  - Epic
    - Story
      - Task
    - Bug
      - Task
- We will track Risk work items outside of the hierarchy so that we may easily manage them independently; however, we may choose to relate them to other work items.

|  | Sizing | Definition |
|--|--------|------------|
| **Epic** | Up to the lifetime of the project | Business initiative for a stakeholder to accomplish |
| **Story** | Completable within a sprint | Consists of multiple tasks |
| **Bug** | Completable within a sprint | Production blocking bugs are prioritized |
| **Task** | Completable within a week | Optionally defined by the story owner to help track work that must be completed to consider a story done |
| **Risk** | N/A | Something that the team would like to shine light on to ensure actions can be taken to mitigate effects on the project |

#### User Story Guidelines

> Sourced from <https://www.scrumtraining.com>

##### User Story Guideline

  Leveraging the 5 W's (who, what, when, where, why)
  
##### Acceptance Criteria/Tests

   User can *[select/operate] [Feature/Function]* so that *[output]* is *[visible/complete/etc.]*  
   Verify that...

##### I.N.V.E.S.T. in User Stories

**I**ndependent - Can it be developed independently of other stories?  
**N**egotiable - Is the scope negotiated to enable completion?  
**V**aluable - Is the value to the user or customer clear?  
**E**stimatable - Can the work be estimated? Are there unknowns, dependencies, barriers? Do we lack domain or technical knowledge?  
**S**ize appropriately - Can it be completed in the iteration?  
**T**estable - What are the tests to know the work is done?

##### User Story Issues to Avoid

- Describing a task
- UI too soon
- Write in an inactive voice
- Splitting too often in the iteration
- Thinking too far ahead
- Interdependent Stories
- Too many details
- [Gold plating](https://en.wikipedia.org/wiki/Gold_plating_(project_management))
- Stories are too small

#### Definition of Ready

- User stories clearly provide context and scope of work
- Acceptance Criteria is defined
- User stories are achievable withinin the milestone
  - Stories are broken down into prioritized tasks ranging from small to large (If extra large, break it down)
  - "Spike" if investigating something in order to timebox and track outcomes
- Story owner is able to break down user story into tasks if desired
- Dependencies identified (either external or other work items)

#### Definition of Done

- Acceptance Criteria are satisfied
- Appropriate [Pull Request template(s)](https://github.com/retaildevcrews/ngsa/blob/main/.github/PULL_REQUEST_TEMPLATE.md) satisfied
- [Pull Request](https://github.com/orgs/retaildevcrews/projects/4) approved and completed
- [DoD Review & Release](https://github.com/orgs/retaildevcrews/projects/4?card_filter_query=label%3Arelease) checklist satisfied and completed
- Demonstration recorded and available to customer (when applicable)

### Backlogs and (Dash)boards

- Product Owner owns the Product Backlog.
- Tech Lead owns the Risk Backlog.
- User Story Board will be used to track User Story progress.
- Kanban Board will be used to track project progress
  - Board columns:
    - **Triage**: All net-new tasks/bugs/features/stories need to be created as an "issue"; things to discuss/notes can be added as a "note"
    - **Backlog**: Stories and tasks that have been refined, triaged, and prioritized.
    - **Sprint Goals**: Stories that have been committed for the current sprint.
    - **Sprint Backlog**:  Tasks that have been committed for the current sprint.
    - **In Progress**: A development team member owns the story or bug and begins work.
    - **PR Submitted/In Review**: The owner of the story or bug determines the item meets our Definition of Done and has created a Pull Request. The item will stay in this status through the PR process -- including addressing requested feedback or fixing issues found.
    - **Done**: The Pull Request/Task has completed, and the work has been committed to the `main` branch of the project repository.

### Estimating

- We will estimate User Stories with size tagging to help gauge how much work we commit to within a sprint.
- We will use T-shirts sizing for our estimation -- with XS <1 day, Small is 1-2 days, Medium is 2-3 days, Large is 4-5 days, and XL > week, needs decomposed.

### Ceremonies

- Our sprints will be one week and run from Wednesday - Tuesday with Review, Retrospective, and Planning occurring back-to-back.
- We will use an assigned Scrum Master versus rotating the role among the team.

|  | When | Length | Participants | Purpose |
|------|------|--------|--------------|---------|
| **Standup** | Monday, Wednesday, Thursday  @ 1PM CST | 10 minutes | Development Team, Scrum Master, Product Owner | Those with committed work answer: What did I do yesterday? What will I do today? Is there anything in my way? |
| **Triage** | Monday, Wednesday, Thursday  @ 1:10PM CST | 10 minutes | Development Team, Scrum Master, Product Owner| Review an net-new issues for prioritization and discussion |
| **Review** | Tuesday @ 4:00PM CST | 30 minutes | Development Team, Scrum Master, Product Owner | Demonstrate the work we did this week. Show and tell time. |
| **Retrospective** | Tuesday @ 4:30PM CST | 30 minutes | Development Team, Scrum Master, Product Owner | Reflect as a team on how we're doing -- what's working well for us, and what could we do better? |
| **Planning** | Wednesday @ 5:00PM | 30 minutes | Scrum Master, Product Owner, Development Team | Commit to work for the next sprint. |


## How we code together

### Branch Strategy

- `main` branch will be used
  - It will be locked, requiring a PR to make commits.
  - It will be shippable at any time.
- Branches will be used for story or bug-fix work.
  - Naming convention will include alias with a short description of the story or bug (e.g., `dsturgell-create-working-agreement` or `jofultz-deploy-script-error-on-box`)
  - Commits should always have a short but descriptive message explaining what is changing.

### Versioning & Tagging

- Code requires versioning to support side-by-side releases.
- Semantic versioning will be used (ex.: 0.5.0-MMdd-hhmm).
- We will tag as needed to identify releases along main branch.

### Reviews

- The entire team owns quality.
- While Pull Requests will be required as an official form of review for any work done, ad-hoc code reviews or design reviews are encouraged.
- Designs that may impact other areas or assumptions should be reviewed with a larger audience (preferably including the project leads) for visibility to the proposed changes and feedback.

### Pull Requests

- PRs should be small in nature; ideally should close one or more tasks.
- PRs should contain complete descriptions that follow the template and describe the scope of the work and how it meets the acceptance criteria if not obvious.
- A branch policy that requires the PR is tied to a task or bug is in place.
- A branch policy that requires one approver to complete a PR is in place. Explicitly call out the approvers as named reviewers. Ask for committed approvers early (consider asking at assignment), and as a committed approver attempt to complete within 12hours of assignment. If you don't feel you are a qualified approver, comment on that, remove the explicit reviewer assignment to yourself and try to find another approver to replace you.
- A branch policy that requires a successful and unexpired merge build before completion is in place.
- A branch policy that requires all PR comments to be resolved is in place.
- Linters must pass before completion. (Note: not all file types will require linting.)
- Tests must pass before completion.
- PRs will utilize a squash merge into main upon completion ensuring a linear commit history with a single consolidated commit per PR.
- Branches will be deleted after PR completion -- missed functionality should be captured as a new bugfix or story.

### Pairing

Pairing work is recommended to support knowledge sharing between the team members. Work items have a dedicated field *Pairing with* so that a second team members is explicitly assigned. Each team member should look for pairing opportunities before picking up a new work item. Commits should be made by the people that are assigned to the story. Other team members are encouraged to provide feedback using PR comments.

### Sharing

Sharing is caring. We will record demos to share early and share often. We will share as we go and not wait until the end of the project.