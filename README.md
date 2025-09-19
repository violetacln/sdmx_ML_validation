# sdmx_ML_validation
We test here the idea that one can use a __unique method__, __independent of data__ to create the sets of validation rules needed for various datasets/stages of the GSBPM. See our [slides](https://github.com/violetacln/sdmx_ML_validation/blob/main/slides_Iceland.pdf) for the sdmx-2025 conference.

This involves, in addition to using _expert knowledge_ based rules, which still play a role, exploiting:

- the SDMX registry codelists and DSD (data structure definition) files, using R-_validate_, Python: _sdmxthon_

- data properties (type, range, distribution, correlation, ...) using R-_validate_suggest_ 

- machine learning algorithms (e.g. apriori, eclat algorithms using R-_arules_) trained on the whole datasets to discover association rules.  The new rule sets are subsequently evaluated against the traditional rule repositories

- machine/deep learning algorithms for anomaly detection (unsupervised, e.g. deep-/isolation forest as in the R- _solitude_ or _HRTnomaly_) which can single out rare/unique patterns in data which might be signaling errors
