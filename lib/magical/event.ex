defmodule Magical.Event do
  @moduledoc """
  A representation of a iCalendar VEVENT

  This struct provides a comprehensive representation of an calendar event,
  capturing all standard properties defined in the iCalendar specification.

  ## Fields

  ### Identification and Timestamps
  * `uid` - Unique identifier for the event (RFC 5545 §3.8.4.7)
  * `dtstamp` - Date and time of creation of the iCalendar object (RFC 5545 §3.8.7.2)
  * `created` - Date and time the event was created (RFC 5545 §3.8.7.1)
  * `last_modified` - Date and time the event was last modified (RFC 5545 §3.8.7.3)
  * `seq` - Sequence number for tracking event revisions (RFC 5545 §3.8.7.4)

  ### Event Schedule
  * `dtstart` - Start date or date-time of the event (RFC 5545 §3.8.2.4)
  * `dtend` - End date or date-time of the event (RFC 5545 §3.8.2.2)
  * `rrule` - Recurrence rule defining event repetition (RFC 5545 §3.8.5.3)
  * `rdate` - Recurring date times (RFC 5545 §3.8.5.2)
  * `exdate` - Dates to exclude from the recurrence set (RFC 5545 §3.8.5.1)
  * `recurid` - Identifier for a specific recurring instance (RFC 5545 §3.8.4.4)

  ### Event Metadata
  * `summary` - Short summary or title of the event (RFC 5545 §3.8.1.12)
  * `description` - Detailed description of the event (RFC 5545 §3.8.1.5)
  * `location` - Location of the event (RFC 5545 §3.8.1.7)
  * `url` - URL associated with the event (RFC 5545 §3.8.4.6)
  * `categories` - Event categories or classification (RFC 5545 §3.8.1.2)
  * `resources` - Resources required for the event (RFC 5545 §3.8.1.10)

  ### Event Classification
  * `class` - Access classification of the event (RFC 5545 §3.8.1.3)
  * `status` - Status of the event (RFC 5545 §3.8.1.11)
  * `priority` - Priority of the event (RFC 5545 §3.8.1.9)
  * `transp` - Time transparency of the event (RFC 5545 §3.8.2.7)

  ### Event Participants
  * `organizer` - Organizer of the event (RFC 5545 §3.8.4.3)
  * `attendee` - Attendees of the event (RFC 5545 §3.8.4.1)
  * `contact` - Contact information for the event (RFC 5545 §3.8.1.4)

  ### Additional Properties
  * `geo` - Geographic position for the event (RFC 5545 §3.8.1.6)
  * `attach` - Attachment associated with the event (RFC 5545 §3.8.1.1)
  * `comment` - Comments about the event (RFC 5545 §3.8.1.4)
  * `rstatus` - Participation status (RFC 5545 §3.8.8.3)
  * `related` - Related event identifier (RFC 5545 §3.8.4.5)
  """

  defstruct uid: nil,
            summary: nil,
            description: nil,
            dtstamp: nil,
            location: nil,
            dtstart: nil,
            dtend: nil,
            class: nil,
            created: nil,
            geo: nil,
            last_modified: nil,
            organizer: nil,
            priority: nil,
            seq: nil,
            status: nil,
            transp: nil,
            url: nil,
            recurid: nil,
            rrule: nil,
            attach: nil,
            attendee: nil,
            categories: nil,
            comment: nil,
            contact: nil,
            exdate: nil,
            rstatus: nil,
            related: nil,
            resources: nil,
            rdate: nil

  @type t :: %__MODULE__{
          uid: String.t(),
          dtstamp: DateTime.t(),
          dtstart: DateTime.t() | Date.t(),
          dtend: DateTime.t() | Date.t(),
          summary: String.t(),
          description: String.t(),
          location: String.t(),
          class: String.t(),
          created: DateTime.t(),
          geo: String.t(),
          last_modified: DateTime.t(),
          organizer: String.t(),
          priority: String.t(),
          seq: String.t(),
          status: String.t(),
          transp: String.t(),
          url: String.t(),
          recurid: String.t(),
          rrule: String.t(),
          attach: String.t(),
          attendee: String.t(),
          categories: String.t(),
          comment: String.t(),
          contact: String.t(),
          exdate: String.t(),
          rstatus: String.t(),
          related: String.t(),
          resources: String.t(),
          rdate: String.t()
        }
end
