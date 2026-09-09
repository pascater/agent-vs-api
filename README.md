# Check the number, not the summary

An AI agent reading a rendered web page will hand you a confident, well
formatted, plausible number that is wrong, and it will look exactly like the
numbers that are right.

This repository is one worked example of that, with the data, and a short
script that catches it.

## What happened

In September 2026 a list of eight fundraising repositories circulated on
LinkedIn with a star count next to each one. I was about to use those
repositories, so I had an agent check all eight by reading their GitHub pages.

Two of the readings looked damning. `outreachr` published at 256 stars, read as
6. `investorskills` published at 1,843, read as 1,000. Star counts do not fall,
so a figure published above the current count could never have been correct.
Clean argument, sound logic.

Then the same eight were checked again against the GitHub REST API.

| Repository | Published in the list | Agent reading the page | REST API |
|---|---|---|---|
| leonar15/startup-checklist | 2,586 | 2,600 | **2,588** |
| questflowai/investorskills | 1,843 | 1,000 | **1,847** |
| swyxio/devtools-angels | 646 | 648 | **647** |
| joelparkerhenderson/pitch-deck | 438 | 416 | **439** |
| ferdousbhai/investor-agent | 346 | 338 | **347** |
| lalalune/outreachr | 256 | 6 | **258** |
| emotixco/claude-skills-founder | 66 | 66 | **66** |
| midovislam/awesome-pitch-decks | 64 | 65 | **65** |

Every figure in the original list was accurate. Each sits one to four stars
below the live count, which is what an accurate list looks like a few days
after publication. The agent was wrong on five of eight, and wrong by a factor
of 43 on one of them.

The failure was silent. No error, no timeout, no warning. Five correct-looking
numbers, three of them badly wrong, in the same format as the rest.

## The distinction worth keeping

An agent reading a page is a witness. An API is a record. Do not go to press
with a witness.

The counts above live in one JSON field, `stargazers_count`, one request away.
Nothing about this check was hard. It simply was not done before the argument
was built on top of it.

## Use it

```
./verify.sh
```

Reads [`data/repos.csv`](data/repos.csv) and prints, per repository, the figure
the list published, the figure the agent reported, the figure the API returned
on 9 September 2026, and the figure the API returns right now. No token
required for public repositories; an unauthenticated run is rate limited to 60
requests per hour.

Point it at your own CSV to check any claim of this shape before repeating it.

## Two notes on the repositories themselves

Neither is a correction to the original list, which was right.

- `swyxio/devtools-angels` returns `archived: true` with its last push on
  3 August 2026. It is retired, and points to `conorbronsdon/ai-angels`.
- `ferdousbhai/investor-agent` is an MCP server for stock fundamentals, RSI and
  MACD. Useful, though it is an investing tool rather than a fundraising one.

## Licence

MIT. See [LICENSE](LICENSE).
