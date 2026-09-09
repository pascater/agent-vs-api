# Fundraising repos, checked

A list of "the top 8 AI fundraising repos on GitHub" went round LinkedIn in
September 2026, presented as the complete list.

I checked all eight, one at a time, because I was about to use them. We are
raising for a FINMA licensed life insurance platform in Switzerland and I
needed the tools to be real.

Four of the eight figures in that list are above what the repositories show
today. GitHub stars only go up, so those figures were never correct.

This repo is the check, the method, and the script to redo it yourself.

## The eight, checked on 9 September 2026

| Repository | Listed as | Shown on 9 Sep 2026 | Verdict |
|---|---|---|---|
| [leonar15/startup-checklist](https://github.com/leonar15/startup-checklist) | 2,586 | ~2.6k | Figure holds. US only: Delaware incorporation and Californian payroll tax |
| [questflowai/investorskills](https://github.com/questflowai/investorskills) | 1,843 | 1,000 | Figure does not hold. 50+ investing philosophies for public markets, not for raising |
| [swyxio/devtools-angels](https://github.com/swyxio/devtools-angels) | 646 | 648 | Figure holds, repo does not. Archived 3 Aug 2026, moved to [conorbronsdon/ai-angels](https://github.com/conorbronsdon/ai-angels) |
| [joelparkerhenderson/pitch-deck](https://github.com/joelparkerhenderson/pitch-deck) | 438 | 416 | Figure does not hold. A folder of links to nine year old advice, still clear |
| [ferdousbhai/investor-agent](https://github.com/ferdousbhai/investor-agent) | 346 | 338 | Figure does not hold. MCP server for stock fundamentals, RSI, MACD. Not a fundraising tool |
| [lalalune/outreachr](https://github.com/lalalune/outreachr) | 256 | 6 | Figure does not hold, by a factor of 42. One fork, ten commits. Good idea, two week old code |
| [emotixco/claude-skills-founder](https://github.com/emotixco/claude-skills-founder) | 66 | 66 | Figure holds. Four commits, generic founder prompts |
| [midovislam/awesome-pitch-decks](https://github.com/midovislam/awesome-pitch-decks) | 64 | 65 | Figure holds. 754 decks indexed, files hosted on Google Drive rather than here |

One of the eight survived contact with an actual raise: the deck archive.

## Method, so you can attack it

Star counts were read from each repository's own GitHub page on 9 September
2026, in a single pass. `2.6k` is recorded as GitHub renders it, not as an
exact integer.

Stars are monotonic in practice: they go up over time, and a repository does
not lose 250 of them. So a figure published above what a repository shows
later was wrong when it was published, not merely stale. The reverse is not
evidence of anything: `devtools-angels` is listed at 646 and shows 648, which
is two weeks of ordinary drift.

Numbers move. Rerun the check before quoting this table:

```
./verify.sh
```

It reads live counts from the GitHub API and prints them next to the figures
recorded here. No token needed for public repositories, though an
unauthenticated run is rate limited to 60 requests per hour.

## What none of the eight covers

The gap is not quantity, it is assumption. Every fundraising resource above
assumes a Delaware C corporation with no regulator, no capital requirement and
nobody who has to approve a change in its shareholders.

None of it survives the first questions a serious investor asks a licensed
company:

- who owns the risk, and what happens to that person after the round
- what the solvency capital requirement does to the use of proceeds
- what happens to the licence, and to the money, if the round slips two quarters
- which line items a supervisor reads differently from a VC
- whether a new shareholder above a given threshold needs supervisory clearance
  before the wire, not after

Those questions are the job for a regulated founder, and there is nothing
published on them. That version is being written. It will appear here.

## Contributing

Corrections welcome, including corrections to this file. Open an issue with the
repository, the figure you see, and the date you saw it. If something here is
wrong I will change it and say so in the commit message.

## Licence

MIT. See [LICENSE](LICENSE).
