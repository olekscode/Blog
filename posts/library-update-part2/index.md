In my previous post, I have explained the problem of library update, discussed the difference between library update and library migration, and introduced the general idea of automatic library update.

Now I will discuss different sources of information that can be used to generate rules for automatic library update and do a brief overview of the related work that was done in this area.

## Sources of Information for Automatic Library Update

|  | Library [L] | Updated Client System [C] |
|---|---|---|
| **Developer expertise [dev]** | dev(L) | dev(C) |
| **Two versions of source code [2v]** | 2v(L) | 2v(C) |
| **Commit history [hist]** | hist(L) | hist(C) |
| **Documentation [doc]** | doc(L) | doc(C) |
| **Comments [com]** | com(L) | com(C) |
| **Unit tests [test]** | test(L) | test(C) |
| **Examples [ex]** | ex(L) | ex(C) |

1. **Expert knowledge of library developers**
2. **Expert knowlege of the developers of a client system that has already been updated**
1. **Two versions of source code of the library**
1. **Two versions of source code of a client system that has already been updated**
1. **Commit history of the library**
1. **Commit history of a client system that has already been updated**
2. **

We can get information from the library developers, client developers, commit history, source code, documentation, examples, test cases.

## Related Work

| Paper | Year | Problem | Source of information |
|---|---|---|---|
| Chow et al. | 1996 | update | dev(L) |
| Henkel et al. | 2005| update | dev(L) |
| Kim et al. | 2007 | update | 2v(L) |
| Xing et al. | 2007 | update | 2v(L) |
| Dagenais et al. | 2008 | update | hist(L) |
| Schäfer et al. | 2008 | update | 2v(C) + test(L) |
| Wu et al. | 2010 | update | 2v(L) |
| Nguyen et al. | 2010 | update | 2v(L) + 2v(C) + test(L) |
| Meng et al. | 2012 | update | hist(L) |
| Teyton et al. | 2013 | migration | hist(C) |
| Hora et al. | 2014 | update | hist(L) |
| Pandita et al. | 2015 | migration | 2v(L) |
| Alrubaye et al. | 2019 | migration | hist(C) + doc(L) |
| Alrubaye et al. | 2020 | migration | doc(L) |