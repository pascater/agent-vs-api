# RETRACTED, do not publish

This repository was built on 9 September 2026 around the claim that a widely
shared LinkedIn list of eight fundraising repositories carried inflated star
counts.

That claim is false. The star counts in the original list were accurate.

The error was mine. The first pass read the counts from rendered GitHub pages
through a summarising fetch tool, which returned wrong numbers for several
repositories (outreachr as 6 rather than 258, investorskills as 1,000 rather
than 1,847). The GitHub REST API, queried directly, contradicts every one of
those readings.

Live counts from `api.github.com` on 9 September 2026, against the figures the
original list published:

| Repository | Listed | Live API | Verdict |
|---|---|---|---|
| leonar15/startup-checklist | 2,586 | 2,588 | accurate |
| questflowai/investorskills | 1,843 | 1,847 | accurate |
| swyxio/devtools-angels | 646 | 647 | accurate |
| joelparkerhenderson/pitch-deck | 438 | 439 | accurate |
| ferdousbhai/investor-agent | 346 | 347 | accurate |
| lalalune/outreachr | 256 | 258 | accurate |
| emotixco/claude-skills-founder | 66 | 66 | accurate |
| midovislam/awesome-pitch-decks | 64 | 65 | accurate |

Every figure sits one to four stars below the live count, which is exactly what
a list published a few days earlier should look like.

Two smaller observations survive, and neither is a correction of the original
list:

- `swyxio/devtools-angels` carries `archived: true` with its last push on
  3 August 2026. It is a retired list, and its maintainer points to
  `conorbronsdon/ai-angels`, which has 6 stars and was created in July 2026.
- `ferdousbhai/investor-agent` describes itself as a server for building an
  investor agent, and its tooling is stock fundamentals, RSI and MACD. Whether
  that belongs in a fundraising list is a matter of judgement, not a factual
  error by whoever compiled it.

The methodology lesson is the one worth keeping, and it applies to this file
first: read numbers from the API, not from a summary of a rendered page, and
run the check before making a claim rather than after. `verify.sh` in this
repository does that. It is the tool that caught the mistake.
