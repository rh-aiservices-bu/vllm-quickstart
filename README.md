vLLM quick start
===

This repository has three Helm charts. One chart, `vllm`, deploys [vLLM](https://docs.vllm.ai/en/latest/), defaulting to
using the [Red Hat AI Inference Server](https://docs.redhat.com/en/documentation/red_hat_ai_inference_server) image.
Another, `openwebui`, deploys [Open WebUI](https://openwebui.com/), which can be wired to any vLLM endpoint with the
proper configuration.

The third chart, `chat`, is an
[umbrella chart](https://helm.sh/docs/howto/charts_tips_and_tricks/#complex-charts-with-many-dependencies) that depends
on the other two, and explicitly wires the Open WebUI deployment to connect to the deployed vLLM instance.

Prerequisites
---

- Some command line tools available
  - `git`
  - `helm`
- An OpenShift cluster with NVIDIA GPUs available (by default, configurable) and configured properly (e.g. the NVIDIA
  GPU Operator)
  - This cluster should be your current context, e.g. you see the correct cluster when you run `oc whoami --show-server`
  - You need permission to create Namespaces and consume GPUs, but do not require higher privilege to deploy these
    charts

Getting started
---

The charts are not currently published to a [Helm repository](https://helm.sh/docs/topics/chart_repository/) as they are
changing quickly. To deploy them, you will have to download the repository:


```sh
git clone https://github.com/rh-aiservices-bu/vllm-quickstart
cd vllm-quickstart
```

To deploy the `chat` chart (the all-in-one), you need to update the dependencies (since the charts are not published):

```sh
helm dependency update charts/chat
```

Then, you can deploy the defaults quickly:

```sh
helm upgrade --install -n rhaiis --create-namespace rhaiis charts/chat
```

Recover the URL that the Open WebUI chart advises. After a few minutes, accessing that URL will enable access to the
Granite 3.3 8B model served by vLLM.

Customization
---

The defaults for these charts are enough for a normal, default installation of OpenShift with GPU nodes configured
in the most common ways. They support logging into the Open WebUI chat interface using OpenShift credentials with access
to read Secret objects in the Namespace. If you would like to change the model that is served, change the storage method
for the model, operate on a pre-downloaded model, or other customizations, you should use [Helm
values](https://helm.sh/docs/chart_template_guide/values_files/) to override the defaults. The two subcharts included in
`chat` have separate values that can be specified in the parent chart by including their names as top level keys in
`chat` values. Information on what the keys are and how to use them follows.
