# Some Pluto notebooks

## 1. Working with texts


### Generally applicable modules

- using the `CitableText` module to work with [CTS URNs](./cts-urns.html) (version *1.0.1*)
- using the `CitableCorpus` module: [citable text passages, documents and corpora](./texts.html) (version *1.1.0*)
    - (with an aside on [reading CITE data with Julia IO](./julia_io.html)) (version *1.0.0*)
- using the `Orthography` module to work with explicitly defined [orthographic systems](./ortho.html) (version *1.1.0*)
- using the `CitableParserBuilder` module: abstractions for [analyzing citable texts](./textparsing.html) (version *1.0.1*)
    - (with an aside on using the `CitableParserBuilder`'s [abbreviated URN notation](./abbrurns.html))  (version *1.0.0*)
- using the `CitableCorpusAnalysis` module to [analyze and profile text corpora](./analysis.html)  (version *prerelease-2*)


### Specialized orthographies

- using the `PolytonicGreek` module
- using the `AtticGreek` module
- using the `ManuscriptOrthography` module

### Specialized morphological (and other) analyses

- using the `Kanones` module
- using the `Lycian` module
- using the `Tabulae` module

### Applications to specific text corpora

- analyzing corpora in ancient Greek
- analyzing corpora in Latin
- analyzing corpora in Lycian

## 2. Working with objects and images

- using the `CitableObject` module to work with CITE2 URNs
- using the `CitableImage` module to work with citable image data
- using the `CitableCollection` module to work with collections of citable objects
- using the `CitablePhysicalText` module to work with digital editions associated with physical artifacts


## 3. Developing digital text corpora

### Editing texts

- using the `CitableTeiReaders` module to create citable content from a variety of document formats
- using the `EditionBuilders` module to create univocal editions from multivalent source documents


### Managing archives of citable content

- using the `EditorsRepo` module
- using the `HmtArchive` module
