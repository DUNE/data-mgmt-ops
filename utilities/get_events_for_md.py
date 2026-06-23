import ROOT as RT
import json
from argparse import ArgumentParser as ap

def get_events(filename):
  ev = RT.gallery.Event(RT.vector(RT.string)(1, filename))
  event_numbers = []
  for i in range(ev.numberOfEventsInFile()):
    ev.goToEntry(i)
    event_numbers.append(ev.eventAuxiliary().id().event())
  return event_numbers

def place_events(events, md):
  ##Place events in the metadata
  md |= {
    'core.events':events,
    'core.event_count':len(events),
    'core.first_event_number':events[0],
    'core.last_event_number':events[-1],
  }

if __name__ == '__main__':
  parser = ap()
  parser.add_argument('-i', type=str, required=True, help='Input File')
  parser.add_argument('--json', '-j', type=str, required=True, help='Output JSON file')
  args = parser.parse_args()

  events = get_events(args.i)

  output  = json.dumps({
    'metadata': {
      'core.events':events,
      'core.event_count':len(events),
      'core.first_event_number':events[0],
      'core.last_event_number':events[-1],
    }
  })

  with open(args.json, 'w') as outfile:
    outfile.write(output)
