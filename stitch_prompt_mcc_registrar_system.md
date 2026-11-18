# Stitch Prompt: Mabalacat City College Registrar's Office – Student Services System

> **How to use:** Paste **Part 1 (Master Prompt)** into Stitch first to set the global design system and app shell. Then paste each **Part 2 screen prompt** one at a time (Stitch gives the best results one screen per prompt). Part 3 (tech stack) is for developer handoff and is not needed in Stitch.

---

# PART 1: MASTER PROMPT (paste first)

## 1. Product Overview

Design a complete **Registrar Student Services System** for **Mabalacat City College (MCC), Registrar's Office**. It is a queue and appointment management platform with two roles:

- **Student portal**: register, log in, browse registrar services, view schedules, book appointments, receive a queue number, track the queue, view history, manage profile.
- **Registrar Staff/Admin portal**: manage services, schedules, appointments, live queue, call/serve students, update transaction statuses, manage student accounts, view transaction records, generate reports.

**Platforms:** Desktop web is the primary layout (1440px wide), with a fully responsive tablet and mobile (390px) adaptation. The final app is built in Flutter, so use clear card/list/table components that map cleanly to Flutter widgets.

**Tone:** Official, trustworthy, clean, modern, institutional. Friendly greetings for students ("Good morning, Juan!"). Philippine context: dates like "October 1, 2026", 12-hour time, "BSIT - 3rd Year".

## 2. Design System (match the reference dashboard exactly)

**Layout shell**
- **Top header bar:** full-width deep maroon/crimson, left side shows the circular MCC college seal/logo placeholder, then a stacked title: **"Mabalacat City College"** (bold white, large), **"Registrar's Office"** (white, medium), **"Student Services System"** (small, light pink/white). Right side: a notification bell icon with a small red badge showing count (e.g., "2"), then a circular avatar, user name ("Juan Dela Cruz") with a small subtitle ("BSIT - 3rd Year"), and a dropdown chevron.
- **Left sidebar (about 240px):** same deep maroon, with a subtle, low-opacity architectural line-art illustration of the college building watermarked at the bottom. Nav items have a white outline icon plus white label. The **active item** has a lighter translucent maroon rounded highlight. Items for the student: Dashboard, View Registrar Services, Appointment Schedules, Queue Status, Transaction History, Manage Profile. **Logout** is pinned to the bottom of the sidebar.
- **Main content area:** very light grey/white-blue background (#F6F7FB) with white rounded cards (12–16px radius), soft shadows, generous spacing (24px gutters).

**Color palette**
- Primary maroon: `#7A1622` (header/sidebar), darker `#5E0F19`, hover/active tint `#923041`
- Primary action red (buttons): `#A4212F`
- Page background: `#F5F6FA`; Card background: `#FFFFFF`; Highlight card tint (upcoming appointment): `#FBF1EF`
- Text: heading `#1F2430`, body `#4B5160`, muted `#8A90A0`
- Status colors: Success/Completed/Confirmed green text `#1E8E4E` on `#DDF3E4`; In Progress/Pending amber text `#9A6B00` on `#FFF1C2`; Info blue `#2F6FD6` on `#E3EEFF`; Danger/Cancelled red `#C0392B` on `#FCE3E0`; Purple accent `#7A4CC2` on `#EEE5FA`
- Stat-card icon circles use soft pastel fills: pink (appointments), blue (queue), green (transactions), purple (services)

**Typography:** Modern geometric sans-serif (Inter or Poppins). Page greeting 24px semibold; card titles 16px semibold; body 14px; captions 12px; big stat numbers 28px bold.

**Components**
- Rounded stat cards with a pastel circular icon, label, large number, and a colored text link with an arrow ("View Schedule →").
- Pill status chips (Completed, In Progress, Confirmed, Pending, Cancelled, Serving, Waiting, No-show).
- Primary button: filled maroon-red, white text, 8px radius. Secondary: white with a maroon border. Text links in matching accent colors.
- Data tables: light grey header row, row dividers, a right chevron on each row, rounded container.
- Section cards with a small maroon icon plus bold title on the left and a "View All" link on the right.
- Form inputs: white, 1px light border, 10px radius, left icon, maroon focus ring, inline validation messages.
- Toasts, modals, empty states, skeleton loaders, and a stepper component for the booking flow.
- Reference number format shown on cards: `2026-1003-001`. Queue number format: `Q015`.

## 3. Global Behavior to Reflect in the UI

- Role-based navigation: Student sidebar vs Staff sidebar (same maroon theme).
- Every list has loading, empty, and error states.
- Notifications: bell dropdown plus a full Notifications page (appointment confirmed, transaction completed, queue update).
- Accessibility: AA contrast, visible focus states, 44px minimum touch targets on mobile.
- Mobile: sidebar collapses into a hamburger drawer plus a bottom navigation bar (Home, Services, Queue, History, Profile). Cards stack in a single column; tables become stacked list cards.

---

# PART 2: SCREEN PROMPTS (paste one by one)

> Prefix each with: *"Using the same design system, header, and sidebar as the master prompt, design the following screen:"*

## A. STUDENT PORTAL

### A1. Student Registration (FR-01)
Split-screen auth page. Left half: maroon panel with the MCC seal, "Mabalacat City College – Registrar's Office", tagline "Skip the line. Book your registrar appointment online.", and the faint college-building line art. Right half: white card titled **"Create your account"** with a 2-column form: First Name, Middle Name, Last Name, Student ID Number, Email Address, Mobile Number, Course/Program (dropdown, e.g., BSIT), Year Level (dropdown), Username, Password (with strength meter), Confirm Password. Checkbox "I agree to the Terms and Data Privacy Notice." Full-width primary button **"Create Account"**. Footer link "Already have an account? Log in". Show inline validation errors and a success state/toast ("Account created! Please log in").

### A2. Student Login (FR-02)
Same split-screen layout. Card titled **"Welcome back"**, subtitle "Log in to your student account." Fields: Email or Username, Password (show/hide toggle). "Remember me" checkbox and "Forgot password?" link. Primary button **"Log In"**. Divider, then "New student? Create an account". Include an error state: "Invalid email/username or password."

### A3. Student Dashboard (reference screen, recreate exactly)
Recreate the reference dashboard layout with the full shell (header + sidebar, **Dashboard** active):
- **Top row:** a greeting card with a circular avatar, **"Good morning, Juan!"** and the subtitle "Here's an overview of your account and upcoming appointments."; on the right a date card with a calendar icon, **"October 1, 2026"** and "Thursday, 10:24 AM".
- **Four stat cards in a row:** (1) Upcoming Appointments **1** with "View Schedule →" (pink icon); (2) Current Queue Status **Q015** with "View Queue →" (blue icon); (3) Transactions **3** with "View History →" (green icon); (4) Available Services **5** with "View Services →" (purple icon).
- **Upcoming Appointment card** (title with calendar icon, "View All" link): a tinted row with a date badge (OCT / **03** / 2026), **"Enrollment"** with a green "Confirmed" chip, clock icon "09:00 AM – 10:00 AM", location pin "Mabalacat City College Registrar's Office", red text "Reference No. 2026-1003-001", and a **"View Details"** primary button on the right.
- **Recent Transactions card** ("View All" link): table with columns Date, Service, Status, Reference No. and rows: Sep 28, 2026 / Enrollment / Completed / 2026-0928-003; Sep 20, 2026 / Certificate Request / Completed / 2026-0920-001; Sep 15, 2026 / Transcript of Records / In Progress / 2026-0915-002; Sep 10, 2026 / Subject Adjustment / Completed / 2026-0910-004. Each row has a right chevron.
- **Right column:** (a) A maroon promo card with a government-building icon, **"Need a service?"**, text "Browse all available registrar services and start your request.", and a white button **"View Registrar Services →"**. (b) **Quick Actions** card with four rows with icon and chevron: Book Appointment, Check Queue Status, View Transaction History, Update Profile. (c) **Notifications** card ("View All"): green check "Your appointment has been confirmed – Enrollment • Oct 3, 2026 • 09:00 AM (2h ago)"; blue info "Transaction completed – Certificate Request • Sep 28, 2026 (1d ago)"; red alert "Queue update – You are now on Queue 015. (2d ago)".

### A4. View Registrar Services (FR-03)
Page title "Registrar Services" with subtitle "Choose a service to start your request." Search bar and category filter chips (All, Enrollment, Certificates, Records, Adjustments). Responsive grid of service cards. Each card has a pastel icon, service name, short description, required documents summary, estimated processing time, fee (or "Free"), an active/available badge, and a **"Book Appointment"** button. Sample services (5 available): Enrollment, Certificate Request, Transcript of Records, Subject Adjustment, Document Verification/Authentication. Include a service detail side-drawer showing the full requirements checklist.

### A5. View Appointment Schedules (FR-04)
Title "Appointment Schedules". Top: a service selector dropdown. Left: a monthly calendar with available dates highlighted in light maroon, fully booked dates greyed out, and today ringed. Right: a **time-slot panel** for the selected date, showing slots as selectable pills ("09:00 – 10:00 AM · 3 slots left"), with color states: Available, Few left (amber), Full (disabled grey). Legend below. Sticky footer button **"Continue to Booking"**. Also include an "Upcoming Appointments" list tab showing the student's existing bookings.

### A6. Book Appointment (FR-05)
A 4-step stepper: **1 Service → 2 Date & Time → 3 Details → 4 Review & Submit**. Step 3 form: Purpose/Remarks textarea, document checklist with confirm checkboxes, optional file upload for supporting documents. Step 4: a review card summarizing service, date, time, location, and student info, with a terms checkbox and a **"Submit Appointment"** button, plus "Back". Show a success modal: "Appointment submitted!" with the Reference No. and a "View Details" button. Include an error state for a slot that was just taken ("This slot is no longer available. Please choose another").

### A7. Appointment Details and Queue Number (FR-06)
Appointment detail page: a large ticket-style card with a big queue number **Q015**, a green "Confirmed" chip, a QR code placeholder, service name, date/time, location, reference number `2026-1003-001`, and instructions ("Please arrive 15 minutes early and bring your valid ID."). Buttons: **"View Queue Status"**, **"Reschedule"**, **"Cancel Appointment"** (danger text button with a confirm modal). Show an activity timeline (Submitted → Confirmed → Queue number assigned).

### A8. Queue Status (FR-07)
Title "Queue Status". Hero card showing **"Now Serving: Q012"**, **"Your Number: Q015"**, **"Position in line: 3rd"**, an estimated wait time ("~20 minutes"), and a progress bar/stepper for the queue. Below, a compact live queue list (Q012 Serving, Q013 Next, Q014 Waiting, Q015 You) with the student's row highlighted in maroon tint. Counter/window info ("Window 2 – Enrollment"). Auto-refresh indicator ("Updated just now") and a refresh button. Show alternate states: "Your turn! Please proceed to Window 2" (green full-width banner) and "No active queue".

### A9. Appointment and Transaction History (FR-08)
Title "Transaction History". Tabs: **All | Appointments | Transactions**. Filters: date range, service, status. Table columns: Date, Service, Status chip (Completed, In Progress, Pending, Cancelled), Reference No., Queue No., with a row chevron. Pagination at the bottom. Clicking a row opens a **Transaction Detail** drawer with a status timeline (Submitted → Processing → Ready/Completed), staff remarks, and a downloadable receipt button. Empty state illustration placeholder (no images, use icon).

### A10. Manage Profile (FR-09)
Two-column layout. Left: profile card with an avatar and "Change photo", name, student ID, program/year. Right: tabs **Personal Info | Account & Security**. Personal Info fields: first/middle/last name (read-only if restricted), Student ID (read-only), Email, Mobile Number, Address, Program/Year (read-only). Locked fields show a lock icon with tooltip "Contact the Registrar to change this". Security tab: Change Password (current, new, confirm). Buttons **"Save Changes"** and **"Cancel"**, and a success toast.

### A11. Notifications Page
Full list of notifications with icon, title, detail, relative time, unread dot, and filters (All, Unread). "Mark all as read" action.

## B. REGISTRAR STAFF / ADMIN PORTAL

> Use the same maroon shell. Header subtitle changes to **"Registrar Staff Portal"**, and the user chip shows the staff name and role (e.g., "Maria Santos – Registrar Staff"). Sidebar items: **Dashboard, Services, Schedules, Appointments, Queue Management, Transactions, Student Accounts, Reports, Logout.**

### B1. Staff Login (FR-10)
Same split-screen as the student login, titled **"Registrar Staff Login"**, with a small "Authorized personnel only" notice. Email/Username and Password fields, "Log In" button, and an error state for unauthorized/inactive accounts.

### B2. Staff Dashboard
Greeting plus date card. Stat cards: Today's Appointments, Currently Waiting, Now Serving, Completed Today, Pending Transactions. Main area: a **"Live Queue"** mini-card (Now Serving Q012, Next Q013, waiting count) with a **"Call Next"** button; **Today's Appointments** table; and a "Transactions by Status" donut/bar chart card. Right column: Quick Actions (Call Next Student, Add Schedule, Add Service, Generate Report) and recent activity feed.

### B3. Manage Registrar Services (FR-11)
Page title "Registrar Services" with an **"+ Add Service"** primary button. Table: Service Name, Category, Processing Time, Fee, Status toggle (Active/Inactive), Actions (Edit, Deactivate). Search and status filter. **Add/Edit Service modal**: Name, Description, Category, Required Documents (add/remove list), Processing time, Fee, Active toggle, Save/Cancel. Confirmation dialog on deactivate ("Deactivating hides this service from students.").

### B4. Manage Appointment Schedules (FR-12)
Calendar-plus-list view. Left: monthly calendar with slot-count badges per day. Right: slot list for the selected date with time range, linked service, capacity, booked count, status (Open/Full/Closed) and Edit/Delete. **"+ Create Schedule"** modal: Service, Date (single or date range, repeat weekdays), Start time, End time, Slot duration, Capacity per slot, Window/Counter, Save. Include a "Close date" action (holiday/no service) with a reason field.

### B5. View Appointments (FR-13)
Filter bar: date picker/range, service dropdown, status dropdown (Pending, Confirmed, Completed, Cancelled, No-show), search by student name, ID, or reference. Table columns: Reference No., Student (name + ID), Service, Date & Time, Queue No., Status chip, Actions (View, Confirm, Cancel). Row click opens a detail drawer with the student profile summary, submitted documents, and remarks. Pagination and an **Export** button.

### B6. Manage Queue (FR-14) and Call/Serve Student (FR-15)
A two-pane operations screen. **Left pane (live queue list):** tabs Waiting | Serving | Completed | Skipped; each row shows queue number, student name, service, wait time, and priority flag (PWD/Senior), with actions Move Up/Down (or drag handle), Skip, Remove. **Right pane (Service Console):** a large card **"Now Serving: Q012 – Juan Dela Cruz"** with service and a timer, a big primary **"Call Next"** button, plus **"Recall"**, **"Mark as Serving"**, **"Complete"**, **"No-show/Skip"** buttons, and a window/counter selector. Below: student quick-info and a remarks field. Show a toast "Q013 has been called to Window 2" and a state where the queue is empty.

### B7. Update Transaction Status (FR-16)
Triggered from the console or the transactions list. A modal/side panel with the student and service summary, a **Status dropdown** (Pending, In Progress, Ready for Release, Completed, Cancelled, Rejected), a remarks/notes textarea, an optional attachment, and a checkbox "Notify student". Buttons **"Update Status"** and "Cancel". Show a status history timeline beneath.

### B8. Manage Student Accounts (FR-17)
Title "Student Accounts" with a search bar, filters (Program, Year Level, Account Status), and a table: Student ID, Name, Email, Program/Year, Status (Active/Disabled), Registered On, Actions (View, Edit, Disable/Enable, Reset Password). Student detail drawer with profile info and a short appointment history. Confirmation modals for disabling or resetting. Role-gated notice: "Only authorized staff can modify accounts."

### B9. View Transaction Records (FR-18)
Summary chips at the top with counts (Completed, Pending, In Progress, Cancelled). Filters: date range, service, status, search. Table: Reference No., Student, Service, Date, Processed By, Status, Last Updated, with a row chevron opening a detail drawer with the full status timeline and remarks. **Export CSV/PDF** buttons.

### B10. Generate Reports (FR-19)
Title "Reports". A filter panel: Report type (Appointments Summary, Transactions Summary, Service Usage, Queue Performance), date range, service, status, then **"Generate Report"** button. Results area: KPI cards (Total Appointments, Completed, Cancelled, No-show rate, Avg. Wait Time), a line chart (volume over time), a bar chart (by service), a donut chart (by status), and a detailed data table. Buttons: **Export PDF**, **Export Excel/CSV**, **Print**. Include a "Report generated on …" footer line and an empty state before generation.

---

# PART 3: TECH STACK AND DEVELOPER HANDOFF NOTES

## Stack
| Layer | Technology |
|---|---|
| Frontend (web + mobile) | **Flutter** (responsive web + Android/iOS), state mgmt via Riverpod or Bloc |
| Backend | **Django + Django REST Framework (DRF)**, token/JWT auth (SimpleJWT) |
| Database (local/dev) | **SQLite** |
| Database (production) | **PostgreSQL** |
| Config | Environment-based settings (`DATABASE_URL`), `django-environ`, separate `settings/dev.py` (SQLite) and `settings/prod.py` (PostgreSQL) |
| Extras | `django-cors-headers`, `drf-spectacular` (OpenAPI docs), `django-filter`, optional Celery/Redis for notifications, polling or WebSockets (Django Channels) for live queue |

## Core Data Models (for UI field alignment)
`User` (role: student/staff/admin) · `StudentProfile` (student_id, program, year_level, mobile) · `Service` (name, description, requirements, fee, processing_time, is_active) · `Schedule` / `TimeSlot` (service, date, start, end, capacity, booked_count, status) · `Appointment` (reference_no, student, service, slot, status, remarks) · `QueueEntry` (appointment, queue_no, position, status, window, called_at) · `Transaction` (appointment, status, processed_by, remarks) · `TransactionStatusLog` · `Notification` (user, title, body, is_read)

## Key REST Endpoints (map to screens)
| Requirement | Endpoint(s) |
|---|---|
| FR-01 Register | `POST /api/auth/register/` |
| FR-02 / FR-10 Login | `POST /api/auth/login/`, `POST /api/auth/refresh/` |
| FR-03 Services | `GET /api/services/` |
| FR-04 Schedules | `GET /api/services/{id}/schedules/?date=` |
| FR-05 Book | `POST /api/appointments/` |
| FR-06 Queue number | Auto-assigned on confirmation: `GET /api/appointments/{id}/` |
| FR-07 Queue status | `GET /api/queue/my-status/` |
| FR-08 History | `GET /api/appointments/?mine=true`, `GET /api/transactions/?mine=true` |
| FR-09 Profile | `GET/PATCH /api/profile/` |
| FR-11 Services CRUD | `/api/staff/services/` (`PATCH` to activate/deactivate) |
| FR-12 Schedules CRUD | `/api/staff/schedules/` |
| FR-13 Appointments list | `GET /api/staff/appointments/?date=&service=&status=` |
| FR-14 / FR-15 Queue | `GET /api/staff/queue/`, `POST /api/staff/queue/call-next/`, `PATCH /api/staff/queue/{id}/` |
| FR-16 Transaction status | `PATCH /api/staff/transactions/{id}/status/` |
| FR-17 Student accounts | `/api/staff/students/` |
| FR-18 Transaction records | `GET /api/staff/transactions/` |
| FR-19 Reports | `GET /api/staff/reports/?type=&from=&to=` |

## Business Rules to Reflect in the UI
- Queue numbers are assigned only to **confirmed** appointments, using a per-day, per-service sequence (e.g., `Q001`, `Q002`), and shown as `Q015`.
- A slot cannot be booked beyond capacity; show a clear "slot full" state.
- Reference number format: `YYYY-MMDD-NNN`.
- Staff-only screens are hidden from students (role-based access control).
- Students can edit only permitted profile fields (Student ID, program, and year level are locked).
- Transaction statuses: Pending → In Progress → Ready for Release → Completed (or Cancelled/Rejected).

---

# FINAL INSTRUCTION TO STITCH

Generate all screens using the **exact visual language of the reference dashboard**: deep maroon header and sidebar with the MCC seal and the building line-art watermark, white rounded cards on a soft grey background, pastel icon circles, pill status chips, and red/maroon primary buttons. Keep components consistent across every screen, include loading, empty, and error states, and provide both desktop (1440px) and mobile (390px) versions. Use realistic sample data (Juan Dela Cruz, BSIT – 3rd Year, Oct 2026 dates, Q015, 2026-1003-001). Do not use stock photos; use icons and simple placeholders only.
