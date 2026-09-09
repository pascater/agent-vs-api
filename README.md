# agent-vs-api

`verify.sh` reads GitHub repository facts from the REST API: stars, forks,
archived status, last push. One repository, a list, or piped input. Bash and
curl, no dependencies, no token needed for public repositories.

```sh
./verify.sh owner/repo ...      # the repositories you name
./verify.sh -f list.txt         # one owner/repo per line
cat list.txt | ./verify.sh -    # from standard input
./verify.sh --dataset           # re-run the measurement below
```

```
REPOSITORY                                  STARS   FORKS   ARCHIVED    LAST PUSH
torvalds/linux                             247634   64453      false   2026-09-09
swyxio/devtools-angels                        647      66       true   2026-08-03
```

Archived status and last push are in there because a popular repository and a
maintained one are different things, and the star count alone will not tell you
which you are looking at.

## Why not read the page

Because an agent reading a rendered page returns the wrong number often enough
to matter, and returns it in exactly the format of a right one.

Measured across eight repositories on 9 September 2026. One pass had an agent
read the rendered GitHub pages; the other queried the REST API.

| Repository | Agent read the page | REST API |
|---|---|---|
| leonar15/startup-checklist | 2,600 | **2,588** |
| questflowai/investorskills | 1,000 | **1,847** |
| swyxio/devtools-angels | 648 | **647** |
| joelparkerhenderson/pitch-deck | 416 | **439** |
| ferdousbhai/investor-agent | 338 | **347** |
| lalalune/outreachr | 6 | **258** |
| emotixco/claude-skills-founder | 66 | **66** |
| midovislam/awesome-pitch-decks | 65 | **65** |

Five of eight diverged. One by a factor of 43. Two were exact, which is the
problem: the readings that were wrong and the readings that were right came
back looking identical, with no error, no warning and no hedge.

Raw data in [`data/repos.csv`](data/repos.csv), including which way each
reading failed. `./verify.sh --dataset` re-runs it against live counts.

## The same distinction elsewhere

The script covers GitHub. The principle is wider: for most numbers worth
repeating there are two sources available, and they are not equivalent.

| You want | The page | The record |
|---|---|---|
| Repository popularity | the repo page | the REST API field |
| Package adoption | a badge in a README | the registry's downloads endpoint |
| Whether a company exists | its website | the national commercial register |
| A price or a rate | an aggregator | the exchange or the issuing institution |
| What a rule says | an article about it | the official text |
| What someone published | a summary of it | the document |

An agent reading a page is a witness. A record is a record.

## When a number needs a second source

1. A machine readable source exists. Then that is the source, and the page is
   a convenience.
2. The number is load bearing. If the conclusion collapses without it, it gets
   a second source.
3. It confirms what you already suspected. That makes the second source more
   necessary, not less.
4. Being wrong would cost something you cannot take back, such as a public
   claim about someone else's work.
5. Whatever you check, record the date. Numbers move, and a figure without a
   date cannot be defended later.

## Licence

MIT.
