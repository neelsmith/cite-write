### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ da50a6c9-699a-48cf-976c-50cd55aed91d
using CitableText, CitableCorpus

# ╔═╡ a789c96c-bb16-40ed-8c76-c4ae8e7af262
corpuscex = begin
	using HTTP
	corpusurl = "https://raw.githubusercontent.com/cite-architecture/CitableCorpus.jl/main/docs/data/gettysburgcorpus.cex"
	HTTP.get(corpusurl).body |> String
end

# ╔═╡ f81b2eb8-25fb-11ec-0910-4911df54f93f
md"""
# Working with citable texts

This notebook introduces three structures defined in the `CitableCorpus` library:

1. the `CitablePassage`, a kind of  `Citable` object that  pairs a CTS URN with a string of text content
1. the `CitableCorpus`, a sequence of `CitablePassage`s.
1. the `CitableDocument`, a kind of  `Citable` object including a sequence of `CitablePassage`s.  The document's identifying URN is a CTS URN that, in URN logic, contains all of its citable passages.
"""

# ╔═╡ 23a92e23-de00-4da3-a2f7-9e8075f55c81
md"""
## 1. Citable passages

A *citable passage* associates an identifying CTS URN with a text string.  You can manually construct them, as in the following cell.
"""

# ╔═╡ 445b507d-5644-4c4b-b908-7c7c0a361795
psg1 = CitablePassage(
		 CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:1"), 
		 "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."
	)


# ╔═╡ 6b00dceb-2efd-49e2-9443-8158c39db541
md"""
You can also create a passage from a delimited text string.  If you use the default delimiter (the vertical pipe `|`), you only need to provide one parameter to the `passage_fromcex` function.
"""

# ╔═╡ c48d3947-c201-4449-8e3a-4b39bfa06f0e
psgcex = "urn:cts:citedemo:gburg.bancroft.v2:1|Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."

# ╔═╡ cab41c17-d0aa-4727-85cd-2ae6a5a04f30
psg2 = CitableCorpus.passage_fromcex(psgcex)

# ╔═╡ 8dc0fc0e-b9df-4186-96ae-2c6a3673d770
md"The results are equivalent:"

# ╔═╡ cad62b5d-d7fb-4ba5-b39f-6c8fdbe918ff
psg1 == psg2

# ╔═╡ 21f9c59e-f611-4beb-811a-81a4f1282d0a
md"""
## 2. Citable text corpora
"""

# ╔═╡ 4cc27d15-f568-4707-b4cb-03e606ab2629
md"""
A *citable corpus* is simply a list of citable passages. We could create them manually, or read them from the `ctsdata` block of a CEX source. The following cells use a `ctsdata` block with a single line of delimited text, identical to the text we used above to create an individual passage.  The corpus built from this source comprises only one citable passage.
"""

# ╔═╡ d8e0bd00-b705-4a4b-a333-7fe5f5e33fc5
tinycex = """#!ctsdata
urn:cts:citedemo:gburg.bancroft.v2:1|Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.
"""

# ╔═╡ 98a9d7a7-563a-4269-bd1a-1a5a9b241bd0
tinycorpus = corpus_fromcex(tinycex)

# ╔═╡ 303d23de-bcf8-47fc-b7f6-45f7216baf15
md"""
The citable content is in the `passages` member of the corpus, which is simply a Vector of `CitablePassage`s.
"""

# ╔═╡ d300906a-07f9-430d-b26c-0fc8583282ac
tinycorpus.passages

# ╔═╡ 2ee1c952-4f0f-4f2e-bb4b-2ae728cdf631
tinycorpus.passages[1].urn

# ╔═╡ 06de49f4-0b91-42fa-8057-bab9aaa21697
tinycorpus.passages[1].text

# ╔═╡ 0011163c-b486-4507-915e-b62950fe2650
md"""
### Example: loading the Gettysburg Address from a URL


Normally, you'll want to load a corpus from a local or remote file.  Since the `corpus_fromcex` function takes a String as its argument, we can use normal Julia IO to read data from a file or a URL into a String, and pass that to `corpus_fromcex`.

The following cells illustrates this:  the first one reads the body of a URL as a String; the following cell instantiates a corpus of the five extant texts of Lincoln's Gettysburg Address.  Our corpus comprises 20 citable passages in 5 documents.
"""

# ╔═╡ c479dce8-4183-4097-a73f-8d8e2cf5be47
corpus = corpus_fromcex(corpuscex)

# ╔═╡ 64407ce2-5565-409f-a38c-b49037ac16f7
md"""
We can work directly with the Vector of passages.
"""

# ╔═╡ 3e74280f-e758-4bd9-bd45-5b0238a9f02d
engaged = filter(psg -> startswith(psg.text, "Now we are engaged in a great civil war"),  corpus.passages)

# ╔═╡ 40538b72-f90e-46ba-bff5-aa456888320c
md"""
The `document_urns()` function identifies all the individual documents in the corpus. 
"""

# ╔═╡ f1e2f1d9-9e02-4f9f-8b79-4f8b88568a97
document_urns(corpus)

# ╔═╡ 499bea0d-6ab7-4696-81f1-cb8256be5e0e
md"""
## 3. Citable documents

Like a citable corpus, a *citable document* is defined by a series of citable passages.   The citable document differs from a corpus in two ways, however.

1. It is a citable entity in its own right, with an identifying CTS URN, and a human-readable label, or title.
2. All the citable passages in the document are contained by the URN identifying the document.

We'll illustrate those two points in the following cells.

"""

# ╔═╡ 5483c449-2de4-4611-a3ef-f4ece41da07d
md"""
As with a corpus, the easiest way to create a citable document is to read a string of delimited text in CEx format.  We previously created a corpus from the `tinycex` string:  since it only contains one passage, we could also create a corpus from it.
"""

# ╔═╡ 9671ed51-979a-4066-9b4b-b9421060c9b5
tinydocument = document_fromcex(tinycex)

# ╔═╡ 2cc62aa7-2db1-437e-aaa9-c82f7fd49c8d
md"""
Optionally, we can include a title for the document.
"""

# ╔═╡ eeebd224-5784-4f4f-95d2-4670a358eed0
titled = document_fromcex(tinycex; title = "Introductory sentence of Bancroft's text")

# ╔═╡ 2e43bb3e-869f-4513-9671-222925bc0988
md"""
### Citable documents fulfill the `CitableInterface`

This means they implement the functions `urn`, `label` and `cex`.
"""

# ╔═╡ bcf4b7c5-c6bf-4dc7-85be-5a4451cb42e8
urn(titled)

# ╔═╡ c926dd0e-cf3a-4141-a18e-0ed6e82f0627
label(titled)

# ╔═╡ b3412ddc-fbbc-4ec7-b4be-d15826a22cd5
cex(titled)

# ╔═╡ 0d23165a-83c9-43cb-a847-230444eb5cd0
md"""
### Citable documents and citable corpora

We already saw that the `document_urns` function can identify all the documents in a corpus.  The `documents` function resolves a citable corpus into a Vector of citable documents.


"""

# ╔═╡ 0b713cf3-9fc1-42ff-b6dd-cf0d1820e95f
docs = documents(corpus)

# ╔═╡ cb19ce4c-38a8-46ca-8301-21bd2876c0b9
md"""
Like the `CitableCorpus` type, the `CitableDocument` type has a `passages` member containing a Vector of `CitablePassage`s, but all of the document's passages will be contained by the URN identifying the document.  Compare the values of the following cells.
"""

# ╔═╡ 41c0906e-e59f-43fd-8ffb-aa122e8c8a1f
bancroft = docs[1]

# ╔═╡ d95353c7-54d9-4850-b0a8-036ee51e147e
urn(bancroft)

# ╔═╡ fecd74ab-bb1f-479c-85d5-b42f49117b04
bancroft.passages

# ╔═╡ a426f4e4-718f-4010-9d8e-9758fcc50433
md"""
#### Example: roundtripping document -> CEX -> document

It's easy to show that when we create the CEX representation of a document, and then create a new document by reading that CEX string, the results are equivalent.
"""

# ╔═╡ 97b7779f-cc87-4a5d-9ac5-51246a2f8864
bancroft_viacex = cex(bancroft) |> document_fromcex

# ╔═╡ f76411e3-3bf4-4f69-95b8-17f3383d56ea
bancroft_viacex == bancroft

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CitableCorpus = "cf5ac11a-93ef-4a1a-97a3-f6af101603b5"
CitableText = "41e66566-473b-49d4-85b7-da83b66615d8"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"

[compat]
CitableCorpus = "~0.6.0"
CitableText = "~0.11.0"
HTTP = "~0.9.16"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ANSIColoredPrinters]]
git-tree-sha1 = "574baf8110975760d391c710b6341da1afa48d8c"
uuid = "a4c015fc-c6ff-483c-b24f-f7ea428134e9"
version = "0.0.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "567d865fc5702dc094e4519daeab9e9d44d66c63"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.9.6"

[[CitableBase]]
deps = ["DocStringExtensions", "Documenter", "Test"]
git-tree-sha1 = "314ac6073ad1bfd914a74cc04fc6f8fee0bea84f"
uuid = "d6f014bd-995c-41bd-9893-703339864534"
version = "3.0.1"

[[CitableCorpus]]
deps = ["CitableBase", "CitableText", "CiteEXchange", "DataFrames", "DocStringExtensions", "Documenter", "HTTP", "Test"]
git-tree-sha1 = "0d582e36ccbc0e4b6c784aceec1ac484cc89f171"
uuid = "cf5ac11a-93ef-4a1a-97a3-f6af101603b5"
version = "0.6.0"

[[CitableObject]]
deps = ["CitableBase", "DocStringExtensions", "Documenter", "Test"]
git-tree-sha1 = "46da3c9aee0894cf482e89ef43bfd4ce0b8c769f"
uuid = "e2b2f5ea-1cd8-4ce8-9b2b-05dad64c2a57"
version = "0.8.1"

[[CitableText]]
deps = ["CitableBase", "DocStringExtensions", "Documenter", "Test"]
git-tree-sha1 = "62bf8345028cb0fc88109fe52860b1aeaa0c140e"
uuid = "41e66566-473b-49d4-85b7-da83b66615d8"
version = "0.11.0"

[[CiteEXchange]]
deps = ["CSV", "CitableObject", "DocStringExtensions", "Documenter", "HTTP", "Test"]
git-tree-sha1 = "cfb56a12c77f2324d65082707e31945fa7293fc9"
uuid = "e2e9ead3-1b6c-4e96-b95f-43e6ab899178"
version = "0.4.4"

[[CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "31d0151f5716b655421d9d75b7fa74cc4e744df2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.39.0"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d785f42445b63fc86caa08bb9a9351008be9b765"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[Documenter]]
deps = ["ANSIColoredPrinters", "Base64", "Dates", "DocStringExtensions", "IOCapture", "InteractiveUtils", "JSON", "LibGit2", "Logging", "Markdown", "REPL", "Test", "Unicode"]
git-tree-sha1 = "8b43e37cfb4f4edc2b6180409acc0cebce7fede8"
uuid = "e30172f5-a6a5-5a46-863b-614d45cd2de4"
version = "0.27.7"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[FilePathsBase]]
deps = ["Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "7fb0eaac190a7a68a56d2407a6beff1142daf844"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.12"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "14eece7a3308b4d8be910e265c724a6ba51a9798"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.16"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "19cb49649f8c41de7fea32d089d37de917b553da"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.0.1"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "a8709b968a1ea6abc2dc1967cb1db6ac9a00dfb6"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.5"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a193d6ad9c45ada72c14b731a318bedd3c2f00cf"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.3.0"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "69fd065725ee69950f3f58eceb6d144ce32d627d"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.2.2"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "54f37736d8934a12a200edea2f9206b03bdf3159"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.7"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "fed34d0e71b91734bf0a7e10eb1bb05296ddbcd0"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "c69f9da3ff2f4f02e811c3323c22e5dfcb584cfa"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.1"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─f81b2eb8-25fb-11ec-0910-4911df54f93f
# ╠═da50a6c9-699a-48cf-976c-50cd55aed91d
# ╟─23a92e23-de00-4da3-a2f7-9e8075f55c81
# ╠═445b507d-5644-4c4b-b908-7c7c0a361795
# ╟─6b00dceb-2efd-49e2-9443-8158c39db541
# ╟─c48d3947-c201-4449-8e3a-4b39bfa06f0e
# ╠═cab41c17-d0aa-4727-85cd-2ae6a5a04f30
# ╟─8dc0fc0e-b9df-4186-96ae-2c6a3673d770
# ╠═cad62b5d-d7fb-4ba5-b39f-6c8fdbe918ff
# ╟─21f9c59e-f611-4beb-811a-81a4f1282d0a
# ╟─4cc27d15-f568-4707-b4cb-03e606ab2629
# ╠═d8e0bd00-b705-4a4b-a333-7fe5f5e33fc5
# ╠═98a9d7a7-563a-4269-bd1a-1a5a9b241bd0
# ╟─303d23de-bcf8-47fc-b7f6-45f7216baf15
# ╠═d300906a-07f9-430d-b26c-0fc8583282ac
# ╠═2ee1c952-4f0f-4f2e-bb4b-2ae728cdf631
# ╠═06de49f4-0b91-42fa-8057-bab9aaa21697
# ╟─0011163c-b486-4507-915e-b62950fe2650
# ╠═a789c96c-bb16-40ed-8c76-c4ae8e7af262
# ╠═c479dce8-4183-4097-a73f-8d8e2cf5be47
# ╟─64407ce2-5565-409f-a38c-b49037ac16f7
# ╠═3e74280f-e758-4bd9-bd45-5b0238a9f02d
# ╟─40538b72-f90e-46ba-bff5-aa456888320c
# ╠═f1e2f1d9-9e02-4f9f-8b79-4f8b88568a97
# ╟─499bea0d-6ab7-4696-81f1-cb8256be5e0e
# ╟─5483c449-2de4-4611-a3ef-f4ece41da07d
# ╠═9671ed51-979a-4066-9b4b-b9421060c9b5
# ╟─2cc62aa7-2db1-437e-aaa9-c82f7fd49c8d
# ╠═eeebd224-5784-4f4f-95d2-4670a358eed0
# ╟─2e43bb3e-869f-4513-9671-222925bc0988
# ╠═bcf4b7c5-c6bf-4dc7-85be-5a4451cb42e8
# ╠═c926dd0e-cf3a-4141-a18e-0ed6e82f0627
# ╠═b3412ddc-fbbc-4ec7-b4be-d15826a22cd5
# ╟─0d23165a-83c9-43cb-a847-230444eb5cd0
# ╠═0b713cf3-9fc1-42ff-b6dd-cf0d1820e95f
# ╟─cb19ce4c-38a8-46ca-8301-21bd2876c0b9
# ╠═41c0906e-e59f-43fd-8ffb-aa122e8c8a1f
# ╠═d95353c7-54d9-4850-b0a8-036ee51e147e
# ╠═fecd74ab-bb1f-479c-85d5-b42f49117b04
# ╟─a426f4e4-718f-4010-9d8e-9758fcc50433
# ╠═97b7779f-cc87-4a5d-9ac5-51246a2f8864
# ╠═f76411e3-3bf4-4f69-95b8-17f3383d56ea
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
