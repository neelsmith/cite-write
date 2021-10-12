# Citable scholarly work in Julia

A hands-on introduction to working with the CITE architecture in Julia.


![Color key](./colorkey.png)

![Modules graph](./modules-tikz.png)

## Narrative introduction

- introductory text with embedded code examples: TBA

## Some Pluto notebooks

### 1. Working with texts


#### Generally applicable modules

- using the `CitableText` module to work with [CTS URNs](./cts-urns.html) (version *1.0.1*)
- using the `CitableCorpus` module: [citable text passages, documents and corpora](./texts.html) (version *1.1.0*)
    - (with an aside on [reading CITE data with Julia IO](./julia_io.html)) (version *1.0.0*)
- using the `Orthography` module to work with explicitly defined [orthographic systems](./ortho.html) (version *1.1.0*)
- using the `CitableParserBuilder` module: abstractions for [analyzing citable texts](./textparsing.html) (version *1.0.1*)
    - (with an aside on using the `CitableParserBuilder`'s [abbreviated URN notation](./abbrurns.html))  (version *1.0.0*)
- using the `CitableCorpusAnalysis` module to [analyze and profile text corpora](./analysis.html)  (version *prerelease-2*)


#### Specialized orthographies

- using the `PolytonicGreek` module
- using the `AtticGreek` module
- using the `ManuscriptOrthography` module

#### Specialized morphological (and other) analyses

- using the `Kanones` module
- using the `Lycian` module
- using the `Tabulae` module

#### Applications to specific text corpora

- analyzing corpora in ancient Greek
- analyzing corpora in Latin
- analyzing corpora in Lycian

### 2. Working with objects and images

- using the `CitableObject` module to work with CITE2 URNs
- using the `CitableImage` module to work with citable image data
- using the `CitableCollection` module to work with collections of citable objects
- using the `CitablePhysicalText` module to work with digital editions associated with physical artifacts


### 3. Developing digital text corpora

#### Editing texts

- using the `CitableTeiReaders` module to create citable content from a variety of document formats
- using the `EditionBuilders` module to create univocal editions from multivalent source documents


#### Managing archives of citable content

- using the `EditorsRepo` module
- using the `HmtArchive` module

## Documentation



Links to documentation for modules discussed here, listed alphabetically:


- the [`AtticGreek` module](https://neelsmith.github.io/AtticGreek.jl/stable/) ([github](https://github.com/neelsmith/AtticGreek.jl))
- the [`CitableBase` module](https://cite-architecture.github.io/CitableBase.jl/stable/)  ([github](https://github.com/cite-architecture/CitableBase.jl))
- the [`CitableCollection` module](https://cite-architecture.github.io/CitableCollection.jl/stable/) ([github](https://github.com/cite-architecture/CitableCollection.jl))
- the [`CitableCorpus` module](https://cite-architecture.github.io/CitableCorpus.jl/stable/) ([github](https://github.com/cite-architecture/CitableCorpus.jl))
- the [`CitableCorpusAnalysis` module](https://neelsmith.github.io/CitableCorpusAnalysis.jl/stable/) ([github](https://github.com/neelsmith/CitableCorpusAnalysis.jl))
- the [`CitableImage` module](https://cite-architecture.github.io/CitableImage.jl/stable/) ([github](https://github.com/cite-architecture/CitableImage.jl))
- the [`CitableObject` module](https://cite-architecture.github.io/CitableObject.jl/stable/) ([github](https://github.com/cite-architecture/CitableObject.jl))
- the [`CitableParserBuilder` module](https://neelsmith.github.io/CitableParserBuilder.jl/stable/) ([github](https://github.com/neelsmith/CitableParserBuilder.jl))
- the [`CitablePhysicalText` module](https://cite-architecture.github.io/CitablePhysicalText.jl/stable/) ([github](https://github.com/cite-architecture/CitablePhysicalText.jl))
- the [`CitableTeiReaders` module](https://hcmid.github.io/CitableTeiReaders.jl/stable/) ([github](https://github.com/HCMID/CitableTeiReaders.jl))
- the [`CitableText` module](https://cite-architecture.github.io/CitableText.jl/stable/) ([github](https://github.com/cite-architecture/CitableText.jl))
- the [`EditionBuilders` module](https://hcmid.github.io/EditionBuilders.jl/stable/) ([github](https://github.com/HCMID/EditionBuilders.jl))
- the [`EditorsRepo` module](https://hcmid.github.io/EditorsRepo.jl/stable/) ([github](https://github.com/HCMID/EditorsRepo.jl))
- the [`HmtArchive` module](https://homermultitext.github.io/HmtArchive.jl/stable/) ([github](https://github.com/homermultitext/HmtArchive.jl))
- the `Kanones` module (not yet published: work in progress at [this github repository](https://github.com/neelsmith/Kanones.jl))
- the [`Lycian` module](https://neelsmith.github.io/Lycian.jl/stable/) ([github](https://github.com/neelsmith/Lycian.jl))
- the [`ManuscriptOrthography` module](https://homermultitext.github.io/ManuscriptOrthography.jl/stable/) ([github](https://github.com/homermultitext/ManuscriptOrthography.jl))
- the [`Orthography` module](https://hcmid.github.io/Orthography.jl/stable/) ([github](https://github.com/HCMID/Orthography.jl))
- the [`PolytonicGreek` module](https://neelsmith.github.io/PolytonicGreek.jl/stable/) ([github](https://github.com/neelsmith/PolytonicGreek.jl))
- the [`Tabulae` module](https://neelsmith.github.io/Tabulae.jl/stable/) ([github](https://github.com/neelsmith/Tabulae.jl/actions))
