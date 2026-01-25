DealDrop
A price tracking tool for Malaysian grocery essentials. It monitors daily price fluctuations across major local retailers for a fixed set of necessity items and brands.

core features
necessity tracking: monitoring of 50+ essential items (dairy, grains, pantry staples).

local brand focus: pre-configured for malaysian brands like gardenia, milo, and jasmine.

daily snapshots: automated batch jobs to fetch and store daily price points.

price analysis: logic to determine cheapest options and historical trends.

tech stack
framework: next.js (app router)

ui: tailwind css / shadcn ui

database: prisma / supabase

language: typescript

setup
install

Bash
npm install
database configure DATABASE_URL in .env and run:

Bash
npx prisma db push
dev

Bash
npm run dev