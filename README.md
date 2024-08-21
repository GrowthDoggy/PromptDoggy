# PromptDoggy
Prompt management tool for product and engineering teams.

## Live Demo


## Features
### Current features
* Project, environment, prompt creation
* Access prompts with API
* Copilot textarea: assist you to write prompts with OpenAI
* Deploy prompts to S3 bucket

#### Planned features
- [ ] Role based prompt management
- [ ] Project, environment, prompt deletion

I'm not sure about other features as I don't plan too far ahead. If there is a feature you would like to see, feel free to [schedule a call with me](https://calendly.com/zhenhangtung/promptdoggy-15min).

### Questions to be explored
These are the questions I'm exploring and trying to answer with PromptDoggy:
- How does PromptDoggy manage its own prompts?
- How can we design better prompts with fewer iterations?
- How do we compare prompts and find the best one for a specific task?
- How do we decide which LLM is the best for a specific task?
- How do we collect LLM-generated data and use it to fine-tune the LLM model?

## Install and run locally
### Prerequisites
* Ruby 3.2.2+
* PostgreSQL
* Azure OpenAI
* AWS S3 and KMS

### Installation
* Clone the repository: `git clone git@github.com:PromptDoggy/PromptDoggy.git`
* Install dependencies: `bundle install`
* Migrate the database: `rails db:migrate`

### Run locally
* copy `.env.example` to `.env.development.local`
* Run `rails db:encryption:init` to [create the encryption key](https://guides.rubyonrails.org/active_record_encryption.html) for environment variables starting with `ACTIVE_RECORD_ENCRYPTION`
* Prepare AWS and Azure service keys, and fill in the environment variables
* Start the server: `bin/dev`

## Note
⚠️This project is still in early and rapid development.
Features will be iterated quickly or may even be deprecated based on community feedback.