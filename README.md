# Case files and code for NLRB union representation elections, 1984-2010

This repository [has copies of publicly available files](./raw) from the National Labor Relations Board, holding closed-case records from the NLRB's various case-tracking databases. The repository also contains code to turn those files into a [sqlite database](https://labordata.github.io/nlrb-cats/nlrb.sqlite.zip).

To build the database yourself run the Makefile:

```bash
> make
```

This data and code is just a refactor of the work done by [JP Ferguson](https://github.com/jpfergongithub/nlrb-cats). He describes the data in [some detail on his blog](http://jpferguson.net/project/nlrb_rcase/).

## Data Notes
The source `R_BARGAINING_UNIT` tables duplicate the `R_CASE` table, so we are
missing data on the second, third, and higher bargaining units if they were
part of a NLRB case.
