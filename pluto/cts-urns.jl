### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ df488da6-f312-4b00-8b91-4123fc7814e4
using CitableText, CitableBase

# ╔═╡ 3e0a86e4-22b6-11ec-1d3c-b9947d155385
md""" # CTS URNs in Julia

The Julia `CitableText` module extends `CitableBase` to implement the CTS URN concept.

-  see [documentation for the `CitableText` module](https://cite-architecture.github.io/CitableText.jl/stable/)

We'll use both modules in this notebook.
"""

# ╔═╡ 2a241fb4-e598-4c8e-a017-6023b6e83453
md"""## Constructing CTS URNs

All CTS URNs have 5 colon-delimited sections, defining:

1. the required `urn` prefix
2. the URN type
3. the CTS URN namespace
4. a work component with at least one dot-delimited element
5. a possibly empty passage component
"""

# ╔═╡ b3ff27f7-c3f0-4da5-b112-f87eaeda7bf7
md"""This is as short as a CTS URN can get: it refers to a `gburg` text group in the `citedemo`  namespace.
"""

# ╔═╡ 2894f99f-b24d-425f-b484-be1ddef796c1
group_urn = CtsUrn("urn:cts:citedemo:gburg:")

# ╔═╡ 02e548f2-8784-4390-b285-d0537052c268
md"""CTS URNs have a `urn` property, that is just the string representation of the URN. Note that, in contrast to the `CtsUrn` object, this is a quoted string valiue. in Julia."""

# ╔═╡ d9ba6364-a3dd-43f2-bc82-fda9ad5e523e
group_urn.urn

# ╔═╡ 15c0e9d5-9707-44fb-8a63-6647e193bc55
md"""
It is an error if you have fewer or more than 5 colon-delimited parts.  It's an easy typo to omit the final colon like this:
"""

# ╔═╡ 11b1bd59-6be2-40c4-992b-765335c610d5
nopassage = "urn:cts:citedemo:gburg"

# ╔═╡ b564ac48-011f-496e-8983-a8d52cbe1d62
try
	 CtsUrn(nopassage)
	
catch badurn
	using Markdown
	Markdown.parse("""
		!!! note "Here's the error message you'll see"	        

			 $(badurn)
		""")
end

# ╔═╡ 61381e05-c597-40ba-9d38-ca5a53c729b4
md"""But here's what happens if you to make CTS URN from that string.
"""

# ╔═╡ 429354a1-e377-43b9-8ff4-2edb33af711c
md"""### Examples of valid CTS URNs and URN comparison"""

# ╔═╡ 22710765-5c71-4068-a9b8-ed5472640f8a
md"""We can cite a group of documents."""

# ╔═╡ b1f00c0c-ae2e-404b-9851-be533c898482
group_urn

# ╔═╡ 989bff40-cb8f-4b0d-9097-516d135ffb1a
md"""We can cite individual documents without reference to a version."""

# ╔═╡ 3ccf3a6a-0b34-4dd9-9a76-818939fcd8bf
abstract_docurn = CtsUrn("urn:cts:citedemo:gburg.hay:")

# ╔═╡ b3fefced-9c71-4047-8505-7b934acab7e6
md"""We can cite specific versions of a document."""

# ╔═╡ 4389c621-ff5d-4210-99c2-bd5b94e73384
concrete_docurn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")

# ╔═╡ bb03f5f6-7f49-4d2a-9a9a-168e6dd1887d
md"""We can cite passages in abstract documents, or specific versions of documents."""

# ╔═╡ d354e4b3-dd58-4045-8e5b-53a919ee506b
abstract_phrase_urn =  CtsUrn("urn:cts:citedemo:gburg.hay:2")

# ╔═╡ 3cc96bcc-6f8e-46f6-99d3-d5a32cbbeab8
concrete_phrase_urn =  CtsUrn("urn:cts:citedemo:gburg.hay.v2:2")

# ╔═╡ 0113b074-a676-4ab9-8016-855ca7a3f8ad
md""" ### URN comparison"""

# ╔═╡ d86c4838-2b8e-40b7-a83b-aa40d57687a8
md"Abstract versions of texts contain all concrete versions of that text."

# ╔═╡ 52ed7075-53a1-4952-8cb5-104597ada5ea
urncontains(abstract_docurn, concrete_docurn)

# ╔═╡ e8814c32-412f-49d9-b327-6d2c0cd65d5e
urncontains(abstract_phrase_urn, concrete_phrase_urn)

# ╔═╡ 9ae2fb1c-3cd6-4240-b457-ba1a639e83ec
md"But the relationship is not symmetric."

# ╔═╡ b4e58428-220c-410f-9064-03c0c92c540e
urncontains(concrete_docurn, abstract_docurn)

# ╔═╡ 4660de05-51aa-43f5-a899-af75f301d10f
md"""
Specific passages are contained by higher elements of the passage hierarchy, or (as here) by references to complete documents.
"""

# ╔═╡ ceeafcd6-2f03-41e8-a55b-57aa48f66da0
urncontains(abstract_docurn, abstract_phrase_urn)

# ╔═╡ 47f234bc-e0c2-4345-862e-d10074686fba
urncontains(abstract_docurn, concrete_phrase_urn)

# ╔═╡ a135cd36-38be-43b1-903d-28bc2d909dfa
md"""
### URN manipulation

The `CitableText` module includes a  number of functions that extract String data from a CTS URN,  or create new CTS URNs by modifying other CTS URNs.
"""

# ╔═╡ f997c439-29f7-4d2b-b95c-9775c2367fe1
newly_minted = addversion(abstract_docurn, "v2")

# ╔═╡ 6f18299a-6d7f-4636-b4ce-cebce116be8a
newly_minted == concrete_docurn

# ╔═╡ be90fc82-5003-4dc2-b565-6fe36ea8e170
md"""
See the [list of functions here](https://cite-architecture.github.io/CitableText.jl/stable/apis/).  Try some of them out in the following cell to see how they work.
"""

# ╔═╡ b7045000-e075-4bf7-8b00-fa005403e8a0
# Experiment here!


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CitableBase = "d6f014bd-995c-41bd-9893-703339864534"
CitableText = "41e66566-473b-49d4-85b7-da83b66615d8"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"

[compat]
CitableBase = "~3.0.1"
CitableText = "~0.11.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ANSIColoredPrinters]]
git-tree-sha1 = "574baf8110975760d391c710b6341da1afa48d8c"
uuid = "a4c015fc-c6ff-483c-b24f-f7ea428134e9"
version = "0.0.1"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[CitableBase]]
deps = ["DocStringExtensions", "Documenter", "Test"]
git-tree-sha1 = "314ac6073ad1bfd914a74cc04fc6f8fee0bea84f"
uuid = "d6f014bd-995c-41bd-9893-703339864534"
version = "3.0.1"

[[CitableText]]
deps = ["CitableBase", "DocStringExtensions", "Documenter", "Test"]
git-tree-sha1 = "62bf8345028cb0fc88109fe52860b1aeaa0c140e"
uuid = "41e66566-473b-49d4-85b7-da83b66615d8"
version = "0.11.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

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

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "a8709b968a1ea6abc2dc1967cb1db6ac9a00dfb6"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.5"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╟─3e0a86e4-22b6-11ec-1d3c-b9947d155385
# ╠═df488da6-f312-4b00-8b91-4123fc7814e4
# ╟─2a241fb4-e598-4c8e-a017-6023b6e83453
# ╟─b3ff27f7-c3f0-4da5-b112-f87eaeda7bf7
# ╠═2894f99f-b24d-425f-b484-be1ddef796c1
# ╟─02e548f2-8784-4390-b285-d0537052c268
# ╠═d9ba6364-a3dd-43f2-bc82-fda9ad5e523e
# ╟─15c0e9d5-9707-44fb-8a63-6647e193bc55
# ╠═11b1bd59-6be2-40c4-992b-765335c610d5
# ╟─61381e05-c597-40ba-9d38-ca5a53c729b4
# ╠═b564ac48-011f-496e-8983-a8d52cbe1d62
# ╟─429354a1-e377-43b9-8ff4-2edb33af711c
# ╟─22710765-5c71-4068-a9b8-ed5472640f8a
# ╠═b1f00c0c-ae2e-404b-9851-be533c898482
# ╟─989bff40-cb8f-4b0d-9097-516d135ffb1a
# ╠═3ccf3a6a-0b34-4dd9-9a76-818939fcd8bf
# ╟─b3fefced-9c71-4047-8505-7b934acab7e6
# ╠═4389c621-ff5d-4210-99c2-bd5b94e73384
# ╟─bb03f5f6-7f49-4d2a-9a9a-168e6dd1887d
# ╠═d354e4b3-dd58-4045-8e5b-53a919ee506b
# ╠═3cc96bcc-6f8e-46f6-99d3-d5a32cbbeab8
# ╟─0113b074-a676-4ab9-8016-855ca7a3f8ad
# ╟─d86c4838-2b8e-40b7-a83b-aa40d57687a8
# ╠═52ed7075-53a1-4952-8cb5-104597ada5ea
# ╠═e8814c32-412f-49d9-b327-6d2c0cd65d5e
# ╟─9ae2fb1c-3cd6-4240-b457-ba1a639e83ec
# ╠═b4e58428-220c-410f-9064-03c0c92c540e
# ╟─4660de05-51aa-43f5-a899-af75f301d10f
# ╠═ceeafcd6-2f03-41e8-a55b-57aa48f66da0
# ╠═47f234bc-e0c2-4345-862e-d10074686fba
# ╟─a135cd36-38be-43b1-903d-28bc2d909dfa
# ╠═f997c439-29f7-4d2b-b95c-9775c2367fe1
# ╠═6f18299a-6d7f-4636-b4ce-cebce116be8a
# ╟─be90fc82-5003-4dc2-b565-6fe36ea8e170
# ╠═b7045000-e075-4bf7-8b00-fa005403e8a0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
