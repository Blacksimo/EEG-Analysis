# EEG-Analysis

The complete report can be found [HERE](/bioinf_proj_neuro_group09.pdf)

## Introduction

Electroencephalography (EEG) is an electrophysiological monitoring
method to record electrical activity of the brain. The EEG signals used
in this paper, recorded during subject’s resting state, have been deeply
analysed in order to allow us to study how information flows through
different brain regions and understand the network activity
organization, quantifying brain connectivity properties. The aim of this
analysis is a biological interpretation of the above-mentioned signals
and further predictions for a potential engineering application. In this
work will be shown a comparison between results obtained from EEG of the
subject with **open** and **closed eyes**. The analysis will compare and
reason on results obtained through the application of methods and study
algorithms on two different dataset.

## Development Environment and Tools

The programming language Matlab  has been chosen due to its easy
management of huge data as EEG signals and due to several specific
available tools. The following list shows all the tools and libraries
that have been used in this work:

  - Bioinformatics Tools Matlab 

  - Brain Connectivity Toolbox 

  - eMVAR - Extended Multivariate Autoregressive Modelling Toolbox 

  - edfRead - Read European Data Format file into MATLAB 

The dataset processed by our algorithms refer to Subject 070 of the
dataset available at EEG Motor Movement / Imagery Dataset . Only the
first two runs (S070R01 and S070R02) have bben used for this project:
R01 is recorded during eyes-open (EO) resting state; R02 is recorded
during eyes-closed (EC) resting state.

## Analysis of the results

In the following section will be presented and analyzed the results of
the tests are described in Table
[\[tab:task\_and\_classes\]](#tab:task_and_classes), according to the
project requests. The analysis of the results has been divided into
various study topics presented below.

### Connectivity Graphs

In order to gain a better understanding of the brain we choose the
analysis method that fall into the category of frequency domain. In
particular thanks to the use of the use of the framework edfRead , we
are able to access the data structure containing values that defines the
frequency curve of 64 electrodes placed on different regions of the
brain. In the frequency domain we can make use of the *spectral
estimators*, based on Multi-Variant Autoregressive Models, **Partial
Directed Coeherence** and **Direct Transfer Function**. The application
of these two algorithms is shown in
Fig.[\[fig:OpenEYE1.1e1.2\]](#fig:OpenEYE1.1e1.2) and
Fig.[\[fig:ClosedEYE1.1e1.2\]](#fig:ClosedEYE1.1e1.2), in which we see
the mean of **Adjacency Matrix** and **Coherence Matrix** of all the 64
channels, from both PDC and DTF. This give us an idea of the strength of
a connection between a couple of channels. The results have been
obtained with *while loop* to make the network density equal to 20%
through the search of a proper threshold. From a quick look of the two
images we can conclude that, for both closed and open eyes, the brain
activity comes from the same regions, under the same stimulus. In
Fig.[\[fig:OpenEYE1.3\]](#fig:OpenEYE1.3) and
Fig.[\[fig:ClosedEYE1.3\]](#fig:ClosedEYE1.3) are shown results obtained
by the application of PDC algorithm with several densities: starting
leftmost the percentages are: 1%, 5%, 10%, 20% 30%, 50%. It can be
noticed how the increasing density brings the network to a more dense
connection status between brain regions. Comparing instead the open and
closed eyes version, we can again notice that regions involved during
stimulus are mostly the same. PDC application is then compared to the
**Asymptotic PDC** algorithm Fig.[\[fig:OpenEYE1.4\]](#fig:OpenEYE1.4)
on a selection of 19 channels, shown in
Fig.[\[fig:List19Channels\]](#fig:List19Channels), with a density value
of 5%. Through the use of this particular algorithm, which makes the
sample growing to infinite, we can see where the connections between
channels totally disappear. Moreover,
Fig.[\[fig:OpenEYE1.5\]](#fig:OpenEYE1.5) and
Fig.[\[fig:ClosedEYE1.5\]](#fig:ClosedEYE1.5) are a topological
representation of the above-mentioned network in which we can
graphically visualize nodes, edges and directions of the filtered
signals. This is obtained through the extraction of the adjacency matrix
output from PDC filtering. All the tests and analysis above-mentioned
are made on a frequency range between 8Hz and 13Hz, which corresponds to
the **Alpha Waves** of signal. The same algorithms mentioned before has
been applied on a frequency range between 14Hz and 30Hz, which is
relative to the **Beta Waves**. This is shown in
Fig.[\[fig:OpenEYE1.6\]](#fig:OpenEYE1.6) and
Fig.[\[fig:ClosedEYE1.6\]](#fig:ClosedEYE1.6), were we can see that our
brain regions are frequency-specific.

### Graph Theory Indices

From now on, if not specifically mentioned, we are gonna make use of
signals from 64 channels in the range of alpha waves and a network
density of 3%. The use of graph theory allow us to transform a complex
network like our brain, into a mathematical model from which it is
possible to extract useful information. By modeling the structure of the
brain as nodes (i.e. brain areas) and edges (i.e. anatomical and
functional connections) it is possible to understand the organization of
the network and quantify the connectivity properties of the brain in
order to study how information flows between different regions of the
brain. Through the use of the adjacency matrix mentioned in the previous
section, we analyzed the **Clustering Coefficient** data shown in
Fig.[\[fig:OpenEYE2\_1\_cc\]](#fig:OpenEYE2_1_cc) and
Fig.[\[fig:ClosedEYE2\_1\_cc\]](#fig:ClosedEYE2_1_cc). Those values
represents the tendency of a graph to be divided into cluster and
moreover the modular nature of the brain in terms of activities and
organization. From the comparison between open and closed eyes we can
notice that this nature is amplified when we keep our eyes opened. The
following table shows, during the various tests performed, the average
path length obtained for both weighted and unweighted network. In all
the four case we can notice such a small number, that makes us sense the
easiness of nodes to communicate between each other.

|                |     **WEIGHTED**     |    **UNWEIGHTED**    |
| :------------: | :------------------: | :------------------: |
| **Closed Eye** | 0.000825043345541398 |  0.006660772178014   |
|  **Open Eye**  | 0.00720517771579775  | 0.000754489076568139 |

Average Best Path Length

The use of graphs allows us to analyze other important features of the
connections that are established in a network, such as the
**in-degrees**, **out-degree** that correspond respectively to the
quantity of output and input connections in a directed graph. In
Fig.[\[fig:OpenEYE2\_3PDC\]](#fig:OpenEYE2_3PDC),
Fig.[\[fig:ClosedEYE2\_3PDC\]](#fig:ClosedEYE2_3PDC),
Fig.[\[fig:OpenEYE2\_3DTF\]](#fig:OpenEYE2_3DTF) and
Fig.[\[fig:ClosedEYE2\_3DTF\]](#fig:ClosedEYE2_3DTF) the 10 highest
channels of the network in terms of in-degree, out-degree and total
degree for PDC and DTF application. It is possible to notice how in both
datasets and in both study methods the nodes that establish greater and
their neighbors in-going connections are always the same. This makes it
possible to notice that some brain regions are mostly used in receiving
stimuli for both conditions of open and closed eyes. The same method of
study and the same data gathering algorithm was then applied to the
weighted version of the graph coming from PDC method. In
Fig.[\[fig:OpenEYE2\_7\_cc\]](#fig:OpenEYE2_7_cc) and
Fig.[\[fig:ClosedEYE2\_7\_cc\]](#fig:ClosedEYE2_7_cc) are shown results
of clustering coefficients for both dataset.

### Motif Analysis

Another aspect of the representation of the neural network, that can be
deducted from the graph, concern the presence of **Motif**. It
represents sub-sequences of nodes and edges of the network that occur
with high frequency. In particular they can be divided into 13 main
isomorphism for patterns composed of 3 nodes, as shown in
Fig.[\[fig:MOTIF\]](#fig:MOTIF). In
Fig.[\[fig:OpenEYE3\_1\]](#fig:OpenEYE3_1) and
Fig.[\[fig:ClosedEYE3\_1\]](#fig:ClosedEYE3_1) are shown those classes
and their frequency in the analyzed network. Is, therefore, particularly
important the repetition of the first isomorphism shown in
Fig.[\[fig:MOTIF\]](#fig:MOTIF), which is composed of the sequence
A\(\xrightarrow{}\)B\(\xleftarrow{}\)C and appears in both datasets over
900 times and 600 times respectively which make us think that more than
one signal are combined by some nodes to reach its goal. For this
recurrent Pattern is shown a topological representation in
Fig.[\[fig:OpenEYE3\_2\]](#fig:OpenEYE3_2) and
Fig.[\[fig:ClosedEYE3\_2\]](#fig:ClosedEYE3_2). In
Fig.[\[fig:OpenEYE3\_3\]](#fig:OpenEYE3_3) and
Fig.[\[fig:ClosedEYE3\_3\]](#fig:ClosedEYE3_3) are shown the main motifs
concerning the node relative to the "PO3" channel, which is located in
the parieto-occipital scalp region. It has to be noticed that the type 1
isomorphis, in the situation of receiving stimuli with open eyes is
almost twice as often than the situation of closed eyes probably due to
a greater number of input to process. The same analysis made to find
motifs composed of 3 nodes, was then proposed again with the aim to look
for patterns that include 4 nodes. In this case the possible
isomorphisms are 199 and in Fig.[\[fig:OpenEYE3\_4\]](#fig:OpenEYE3_4)
and Fig.[\[fig:ClosedEYE3\_4\]](#fig:ClosedEYE3_4) are shown the results
obtained on the 64 channels network.

### Community Detection

Finally in Fig.[\[fig:OpenEYE4\_1\]](#fig:OpenEYE4_1) and
Fig.[\[fig:ClosedEYE4\_1\]](#fig:ClosedEYE4_1) are shown, respectively
for open and closed eyes, different regions of channel interactions,
called **Community Detection**. They are subsets of vertices with denser
connections within them and sparser connections between them. We can
notice that in the open eyes condition, bigger cluster of nodes are
grouped together in the same community. In
Tab.[\[tab:community\_detection\]](#tab:community_detection) are listed
the nodes quantity of the above mentioned images regarding brain
connections.

|             | **Open Eyes** | **Closed Eyes** |
| :---------: | :-----------: | :-------------: |
| **Group 1** |      39       |       11        |
| **Group 2** |      10       |       20        |
| **Group 3** |      25       |       13        |
| **Group 4** |      \-       |       20        |

Number of the communities and nodes

## Conclusion

To conclude, the brain studies through the use of graph theory allow us
to unearth useful information about data flow and its distribution
within various brain regions. It has been possible to analyze several
different interactions happening in different regions of the brain of a
subject exposed to a series of stimuli with open and closed eyes in rest
conditions. We understood and qualified similarities and differences
within active nodes connections. The used algorithms let us transform
merely electric signals recorded from EEG channels into mathematical
data to model and visually represent a cerebral map of our beautiful
brain.
