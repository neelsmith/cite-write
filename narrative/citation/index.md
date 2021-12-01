+++
title = "Citation"
parent = "Narrative"
nav_order = 1
+++

# Citation


## TL;DR

- Uniform Resource Names (URNs) are an IETF standard that lets us implement permanent, immutable canonical identifiers.
- The `CitableBase` package defines an abstract `Urn` type, and functions for comparing URNs for *equality*, *containment* and *similarity*.

## Explanation 

> Scholarly resources are identified by permanent, immutable canonical identifiers.

This simple idea implies a number of requirements.

We must have a *taxonomy* of our scholarly content: what is it we want to identify?  If we say, for example, that we want to identify and cite passages of a text in a document, we must define what we mean by a "document". Does "book six of the *Iliad*" mean *any* version of the *Iliad*, in any edition, or manuscript, or translation?  Could it mean *all* versions of the *Iliad*? 

If we know what we want to identify, we must next guarantee that our citations identify content *uniquely*.  ("Some book of the *Iliad*" or "book six of some literary work" are  not identifiers.)




The fluidity of digital content presents some challenges to a digital translation of this fundamental idea.  




Identifiers must be *canonical* -- that is, they must follow some reference scheme more or less widely agreed upon by scholars working with the material.  They must be *permanent* and *immutable* so that they can be used by future scholars.  



TBA