# Agent vs API

An AI agent that reads a rendered web page will sometimes hand back a number
that is wrong, and it will look exactly like the numbers that are right. No
error, no warning, no hedge. Just a clean figure in the expected format.

This repository is a small, reproducible example of that, plus a script that
asks the source directly instead.

## The failure mode

Agents read pages the way a person skims them: through a rendering, often
through a summarising model, sometimes through a partially loaded one. Anything
that comes back is text, and text has no provenance attached. A star count, a
price, a headcount and an invented number all arrive in the same shape.

The dangerous case is not the obvious failure. It is the plausible one. A
number that is wrong by a factor of forty still reads as a number, and if it
happens to support the argument you were already forming, nothing in the
pipeline will stop you.

## The evidence

Eight GitHub repositories, each listed somewhere with a star count. One agent
read the eight rendered pages. One script queried the REST API. Same
repositories, same afternoon, 9 September 2026.

| Repository | Published figure | Agent read the page | REST API |
|---|---|---|---|
| leonar15/startup-checklist | 2,586 | 2,600 | **2,588** |
| questflowai/investorskills | 1,843 | 1,000 | **1,847** |
| swyxio/devtools-angels | 646 | 648 | **647** |
| joelparkerhenderson/pitch-deck | 438 | 416 | **439** |
| ferdousbhai/investor-agent | 346 | 338 | **347** |
| lalalune/outreachr | 256 | 6 | **258** |
| emotixco/claude-skills-founder | 66 | 66 | **66** |
| midovislam/awesome-pitch-decks | 64 | 65 | **65** |

The agent was wrong on five of eight, and wrong by a factor of 43 on one. The
published figures, meanwhile, were all accurate: each sits one to four stars
below the live count, which is what a correct list looks like a few days after
publication.

Note what the wrong readings have in common with the right ones. Nothing. They
are indistinguishable without a second source.

The raw data is in [`data/repos.csv`](data/repos.csv).

## The script

```sh
./verify.sh                    # re-check the dataset above against the live API
./verify.sh owner/repo ...     # check any repositories you name
./verify.sh -f list.txt        # one owner/repo per line
cat list.txt | ./verify.sh -   # or from standard input
```

Free mode prints stars, forks, archived status and last push date, which is
usually enough to tell a maintained project from a retired one:

```
REPOSITORY                                  STARS   FORKS   ARCHIVED    LAST PUSH
torvalds/linux                             247634   64453      false   2026-09-09
swyxio/devtools-angels                        647      66       true   2026-08-03
```

Bash and curl, no dependencies, about sixty lines. Public repositories need no
token; set `GITHUB_TOKEN` to lift the rate limit above 60 requests an hour.

## Beyond GitHub

The principle generalises further than the script does. For most numbers worth
repeating there are two available sources, and they are not equivalent:

| You want | The page | The record |
|---|---|---|
| Repository popularity | the repo page | the REST API field |
| Package adoption | a badge on a README | the registry's downloads endpoint |
| Whether a company exists | its website | the national commercial register |
| A price or a rate | an aggregator | the exchange or the issuing institution |
| What a rule says | an article about it | the official text |
| What someone published | a summary of it | the document itself |

An agent reading a page is a witness. A record is a record. The work is
knowing, before you ask, which one you are about to quote.

## Before you repeat a number an agent gave you

1. Does a machine readable source exist? If yes, that is the source. The page
   is a convenience.
2. Is the number load bearing? If your conclusion collapses without it, it
   gets a second source, always.
3. Does it support what you already believed? Then it needs the second source
   more, not less.
4. Would being wrong about it cost you something you cannot take back, such as
   a public claim about another person's work? Then check it twice, and check
   it last, immediately before publishing.
5. Write down the date you checked. Numbers move, and a figure without a date
   cannot be defended later.

## Provenance

This exists because the check above was very nearly skipped. The eight
repositories came from a list circulating on LinkedIn in September 2026. The
agent readings suggested the list had inflated its figures, and a post saying so
was written, along with a repository to back it. The API check happened last,
by luck rather than method, and showed the list had been right all along.

The post was not published. This is what came out instead.

## Contributing

Corrections welcome, including corrections to this file. Open an issue with the
claim, the source you checked, and the date.

## Licence

MIT. See [LICENSE](LICENSE).
