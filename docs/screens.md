# Screens — route, role, status

All routes are role-guarded; cross-role access lands on `/403`.
`(auth)` = pre-login flow. `done` = built + tested.

## Auth flow (auth)

| Route | Screen | Status |
|---|---|---|
| `/` | Splash (1.2 s, forwards into flow) | done |
| `/language` | Language select (8 cards) | done |
| `/login` | Phone + OTP request, demo panel | done |
| `/otp` | 6-digit OTP, resend, lockout, shake | done |
| `/role-picker` | Multi-role cards, last-used preselect | done |
| `/permissions` | Role checklist + location disclosure | done |
| `/biometric-setup` | Biometric or 4-digit PIN (staff) | done |
| `/lock` | Staff lock (biometric/PIN/demo 1234) | done |
| `/403` | Forbidden | done |

## Common (all roles)

| Route | Screen | Status |
|---|---|---|
| `/profile` | Profile, language, switch role, demo tools, logout | done |
| `/notifications` | Notification centre (Today/Earlier, deep links) | done |
| `/search` | Global search (Trips/LRs/Vehicles/Customers) | done |
| `/settings` | Theme, language, biometric, about | done |
| `/settings/language` | Language list | done |
| `/pdf` | Shared PDF viewer (bytes via extra) | done |

## Driver (`/driver/*`)

| Route | Screen | Status |
|---|---|---|
| `/driver/home` | My Trip (offer/active/empty, slide confirm, timeline, SOS FAB) | done |
| `/driver/earnings` | Earnings, settlement, allowances, slips | done |
| `/driver/documents` | Docs with expiry bands + zoom | done |
| `/driver/profile` | Shared profile + driver settings | done |
| `/driver/pod` | POD capture (OTP/signature/damage) | done |
| `/driver/expenses` | Expense list + balance chip | done |
| `/driver/expenses/add` | Add expense (diesel calc, bill, voice) | done |
| `/driver/advances` | Advance ledger | done |
| `/driver/advances/request` | Request advance | done |
| `/driver/sos` | SOS types + slide + call Ops | done |
| `/driver/queue` | Offline queue + sync now + retry | done |
| `/driver/payslip` | Payslip PDF preview | done |

## Owner (`/owner/*`)

| Route | Screen | Status |
|---|---|---|
| `/owner/home` | Dashboard (KPIs, trend, lanes, brief, ask) | done |
| `/owner/approvals` | Approvals inbox + detail sheet, swipe, bulk | done |
| `/owner/accounts` | Accounts home (banks, GST, trip P&L) | done |
| `/owner/accounts/ledger` | Customer/vendor ledger (`extra`: kind) | done |
| `/owner/accounts/ageing` | Ageing stacked bar | done |
| `/owner/accounts/pnl` | P&L + group switcher + trip P&L | done |
| `/owner/accounts/daybook` | Day book | done |
| `/owner/map` | Live map (fallback without key) + carousel | done |
| `/owner/brief` | Daily brief + WhatsApp share | done |
| `/owner/alerts` | Notification settings | done |
| `/owner/more` | Profile | done |

## Ops (`/ops/*`)

| Route | Screen | Status |
|---|---|---|
| `/ops/orders` | Orders (4 tabs, search, FAB) | done |
| `/ops/orders/new` | 4-step create + WhatsApp parse | done |
| `/ops/orders/:id` | Order detail + Plan action | done |
| `/ops/plan` | Plan landing (pending + market entry) | done |
| `/ops/plan/:orderId` | Plan wizard + return-load card | done |
| `/ops/trips` | Live trips list/map toggle | done |
| `/ops/trips/:id` | Trip control (status, advance, e-way…) | done |
| `/ops/exceptions` | Exceptions feed + quick actions | done |
| `/ops/market` | Broker vehicles + KYC | done |
| `/ops/market/memo` | Hire memo + pay advance + PDF | done |
| `/ops/more` | Profile | done |

## Sales (`/sales/*`)

| Route | Screen | Status |
|---|---|---|
| `/sales/leads` | Leads list/kanban, SLA chips | done |
| `/sales/leads/new` | Add lead (dup check, voice, card scan) | done |
| `/sales/leads/:id` | Lead detail + stage advance | done |
| `/sales/visits` | Visit plan | done |
| `/sales/visits/checkin` | GPS check-in/out + outcome | done |
| `/sales/quote` | Rate lookup + quick quote | done |
| `/sales/quote/preview` | Branded PDF + WhatsApp send | done |
| `/sales/customers` | Customer list (360 entry) | done |
| `/sales/customers/:id` | Customer 360 + payment nudge | done |
| `/sales/targets` | Rings + leaderboard (via Quote page action) | done |
| `/sales/more` | Profile | done |

## Supervisor (`/supervisor/*`)

| Route | Screen | Status |
|---|---|---|
| `/supervisor/today` | Loadings/Arrivals | done |
| `/supervisor/gate` | Gate in/out + delta chip | done |
| `/supervisor/loading/:taskId` | Loading flow (photos, seal, weighment) | done |
| `/supervisor/scan` | Continuous scan + issues | done |
| `/supervisor/manifest` | Manifest list (create from scan page) | done |
| `/supervisor/lr` | LR preview + share/print | done |
| `/supervisor/more` | Profile | done |

## Accountant (`/accountant/*`)

| Route | Screen | Status |
|---|---|---|
| `/accountant/home` | Summary (receivables/payables/GST/billable) | done |
| `/accountant/ledgers` | Ledger links + reminders + receipts entries | done |
| `/accountant/ledger/:kind` | Shared ledger view | done |
| `/accountant/ageing` | Shared ageing view | done |
| `/accountant/pnl` | Shared P&L view | done |
| `/accountant/daybook` | Shared day-book view | done |
| `/accountant/gst` | GST summary | done |
| `/accountant/invoices` | Invoice list + IRN chips | done |
| `/accountant/invoices/:id` | Invoice detail + PDF + receipt shortcut | done |
| `/accountant/approvals` | Approvals + Rs.50k forward rule | done |
| `/accountant/reminders` | Overdue + template + send | done |
| `/accountant/receipts` | Record receipt (permission-gated) | done |
| `/accountant/more` | Profile | done |
