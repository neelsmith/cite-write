# Citable content

## TL;DR

The `CitableBase` package includes a `CitableTrait` that defines behavior for citable objects. They must:

- have a URN identifier (implemented by the `urn` function)
- have a human-readable label (implemented by the `label` function)
- be serializable to the plain-text CEX format (implemented by the `cex` function)
- support instantation from a CEX representation(implemented by the `fromcex` function)