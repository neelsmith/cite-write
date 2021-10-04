### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 90934ad0-f303-4ede-be6d-d08d9ad9a5ec
using Orthography

# ╔═╡ ae2b0b72-3d4d-49a5-b26e-a85dd1e00f9a
using CitableCorpus, HTTP

# ╔═╡ 66a143a5-80b9-49e7-8ae5-ba10fcce4123
md"""
# Working with a defined orthographic system

## Background

In the HCMID model, an *orthographic system* defines three things:

1. a set of token types that can be expressed in this orthography
1. a set of characters or Unicode code points that cab be composed to create valid tokens
1. a tokenizing function that can use the semantics of the character set to parse a string of text into sequences of tokens with an associated token type


This model is implemented in Julia by the `Orthography` module.

- See the `Orthography` module's [documentation](https://hcmid.github.io/Orthography.jl/stable/)

In this notebook, we'll illustrate the usage of the `Orthography` module with a corpus of texts of the Gettysburg Address.

To start with, we'll use or import the module.
"""

# ╔═╡ 1a99e9c5-60ca-46fe-83cc-92126f5e9a1d
md"""
The module includes a simple orthographic system that accepts ASCII characters, and a function `simpleAscii` that returns an instance of that system.  In the following cells, note that the object returned by `simpleAscii()` is a `SimpleAscii` type that is a subtype of the `OrthographicSystem` abstraction, and that the `SimpleAscii` type has three members that directly capture the HCMID model of an orthographic system.
"""

# ╔═╡ 6bfff9f7-c81d-4756-8ec7-b14b88432f2c
ortho = simpleAscii()

# ╔═╡ 954fb80a-a419-4786-9621-8cb8a6b2b37e
typeof(ortho) |> supertype

# ╔═╡ 2f3b817a-f41c-4e14-abe9-6d5ba2b5b103
md"""
### Validating usage

Use the `validstring` function to determine whether a given string is valid in a given orthographic system.

"""

# ╔═╡ d4f64a2a-bfc8-48f2-8eef-3d04ddf3450f
sentence = "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."

# ╔═╡ b5c6887a-1fc5-4bf6-9100-353340740cfe
validstring(ortho, sentence)

# ╔═╡ 96287551-e90b-4f17-bf76-f0082a3050eb
md"""
### Tokenizing

We'll first parse a simple string of characters.
"""

# ╔═╡ f97fc422-e28b-4540-9d8b-be8baee6d500
tokens = tokenize(ortho, sentence)


# ╔═╡ 9907c6fd-cc9b-4c36-85ea-076f856f3226
md"""
The result is a Vector of `OrthogaphicTokens`.  Each token has two members:  a `text`, and a `tokencategory`.

Notice that white space values are discarded, and in this instance all the tokens in our resulting Vector are either lexical or punctuation tokens.

This means of course that we can manipulate the Vector on either the text value or token category.  We can, for example, use a filter to extract all lexical tokens.
"""

# ╔═╡ 46de74c1-ad8f-4743-b7ae-722c8265c596
lexicaltokens = filter(t -> t.tokencategory == LexicalToken(), tokens)

# ╔═╡ 2e84aa9c-85c4-41fe-96db-c1e4ca4241aa
md"""
## Using an orthographic system to tokenize citable texts

The `Orthography` module can also tokenize the higher-order structures of the `CitableCorpus` module:  the `CitablePassage`, `CitableDocument` and `CitableCorpus`.


The following cells show how to retrieve a source in CEX format from a URL, and  load a citable corpus:
"""

# ╔═╡ 91f2a020-2514-11ec-0952-ad0932acd652
gburgurl = "https://raw.githubusercontent.com/cite-architecture/CitableCorpus.jl/main/docs/data/gettysburgcorpus.cex"

# ╔═╡ abc7db81-d566-4e75-b55d-b3e399e16fd3
corpus = String(HTTP.get(gburgurl).body) |> corpus_fromcex

# ╔═╡ 6175cbb4-b833-4965-b01d-8a2dbceb5d2e
md"""
Next we illustrate:

1. tokenizing the entire corpus
2. tokenizing a single citable passge in the corpus
3. tokenize a single complete citable document in the corpus
"""

# ╔═╡ a68ec67f-ad71-4399-8b31-72455611023e
corpustokens = tokenize(ortho, corpus)

# ╔═╡ 295b913c-cae0-450d-ae31-0466b0e1d556
length(corpustokens)

# ╔═╡ 06aee572-4035-4678-b677-c7f63addcefe
passagetokens = tokenize(ortho, corpus.passages[1])

# ╔═╡ 77991366-4377-4044-b307-1efb3f85c9c7
length(passagetokens)

# ╔═╡ 75cfa577-404b-4435-a437-8562646e7e07
doctokens = begin
	docs = documents(corpus)
	tokenize(ortho, docs[1])
end

# ╔═╡ 6af33eec-b481-4693-9ccb-887197d4403c
length(doctokens)

# ╔═╡ 4ca385f5-082b-4466-87a2-219870eb0880
md"""
### Other options

See [this page of the API docs](https://hcmid.github.io/Orthography.jl/stable/guide/corpora/) for more information about:


- building a token edition
- composing a vocabulary list (the set of all tokens' unique text values)
- computing frequencies of tokens
- filtering options that can be applied to all of the above listed operations



"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CitableCorpus = "cf5ac11a-93ef-4a1a-97a3-f6af101603b5"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
Orthography = "0b4c9448-09b0-4e78-95ea-3eb3328be36d"

[compat]
CitableCorpus = "~0.6.0"
HTTP = "~0.9.16"
Orthography = "~0.13.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ANSIColoredPrinters]]
git-tree-sha1 = "574baf8110975760d391c710b6341da1afa48d8c"
uuid = "a4c015fc-c6ff-483c-b24f-f7ea428134e9"
version = "0.0.1"

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

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

[[Dictionaries]]
deps = ["Indexing", "Random"]
git-tree-sha1 = "4b1cea8bbbc46367b0c551bb22bd2debb083b303"
uuid = "85a47980-9c8c-11e8-2b9f-f7ca1fa99fb4"
version = "0.3.12"

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

[[Indexing]]
git-tree-sha1 = "ce1566720fd6b19ff3411404d4b977acd4814f9f"
uuid = "313cdc1a-70c2-5d6a-ae34-0150d3930a38"
version = "1.1.1"

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

[[Orthography]]
deps = ["CitableCorpus", "CitableText", "DocStringExtensions", "Documenter", "OrderedCollections", "StatsBase", "Test", "TypedTables", "Unicode"]
git-tree-sha1 = "7e969e35d937bb7fbd49c6d1c141694aa3bd773e"
uuid = "0b4c9448-09b0-4e78-95ea-3eb3328be36d"
version = "0.13.0"

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

[[SplitApplyCombine]]
deps = ["Dictionaries", "Indexing"]
git-tree-sha1 = "3cdd86a92737fa0c8af19aecb1141e71057dc2db"
uuid = "03a91e81-4c3e-53e1-a0a4-9c0c8f19dd66"
version = "1.1.4"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8cbbc098554648c84f79a463c9ff0fd277144b6c"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.10"

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

[[TypedTables]]
deps = ["Adapt", "Dictionaries", "Indexing", "SplitApplyCombine", "Tables", "Unicode"]
git-tree-sha1 = "f91a10d0132310a31bc4f8d0d29ce052536bd7d7"
uuid = "9d95f2ec-7b3d-5a63-8d20-e2491e220bb9"
version = "1.4.0"

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
# ╟─66a143a5-80b9-49e7-8ae5-ba10fcce4123
# ╠═90934ad0-f303-4ede-be6d-d08d9ad9a5ec
# ╟─1a99e9c5-60ca-46fe-83cc-92126f5e9a1d
# ╠═6bfff9f7-c81d-4756-8ec7-b14b88432f2c
# ╠═954fb80a-a419-4786-9621-8cb8a6b2b37e
# ╟─2f3b817a-f41c-4e14-abe9-6d5ba2b5b103
# ╠═d4f64a2a-bfc8-48f2-8eef-3d04ddf3450f
# ╠═b5c6887a-1fc5-4bf6-9100-353340740cfe
# ╟─96287551-e90b-4f17-bf76-f0082a3050eb
# ╠═f97fc422-e28b-4540-9d8b-be8baee6d500
# ╟─9907c6fd-cc9b-4c36-85ea-076f856f3226
# ╠═46de74c1-ad8f-4743-b7ae-722c8265c596
# ╟─2e84aa9c-85c4-41fe-96db-c1e4ca4241aa
# ╠═ae2b0b72-3d4d-49a5-b26e-a85dd1e00f9a
# ╟─91f2a020-2514-11ec-0952-ad0932acd652
# ╟─abc7db81-d566-4e75-b55d-b3e399e16fd3
# ╟─6175cbb4-b833-4965-b01d-8a2dbceb5d2e
# ╠═a68ec67f-ad71-4399-8b31-72455611023e
# ╠═295b913c-cae0-450d-ae31-0466b0e1d556
# ╠═06aee572-4035-4678-b677-c7f63addcefe
# ╠═77991366-4377-4044-b307-1efb3f85c9c7
# ╠═75cfa577-404b-4435-a437-8562646e7e07
# ╠═6af33eec-b481-4693-9ccb-887197d4403c
# ╟─4ca385f5-082b-4466-87a2-219870eb0880
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002