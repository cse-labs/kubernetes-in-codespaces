# Kubernetes in Codespaces

> Setup a Kubernetes cluster using `k3d` running in [GitHub Codespaces](https://github.com/features/codespaces)

![License](https://img.shields.io/badge/license-MIT-green.svg)

## Overview

This is a template that will setup a Kubernetes developer cluster using `k3d` in a `GitHub Codespace` or local `Dev Container`

We use this for `inner-loop` Kubernetes development. Note that it is not appropriate for production use but is a great `Developer Experience`. Feedback calls the approach `game-changing` - we hope you agree!

For ideas, feature requests, and discussions, please use GitHub discussions so we can collaborate and follow up.

This Codespace is tested with `zsh` and `oh-my-zsh` - it "should" work with bash but hasn't been fully tested. For the HoL, please use zsh to avoid any issues.

You can run the `dev container` locally and you can also connect to the Codespace with a local version of VS Code.

Please experiment and add any issues to the GitHub Discussion. We LOVE PRs!

The motivation for creating and using Codespaces is highlighted by this [GitHub Blog Post](https://github.blog/2021-08-11-githubs-engineering-team-moved-codespaces/). "It eliminated the fragility and single-track model of local development environments, but it also gave us a powerful new point of leverage for improving GitHub’s developer experience."

Cory Wilkerson, Senior Director of Engineering at GitHub, recorded a podcast where he shared the GitHub journey to [Codespaces](https://changelog.com/podcast/459)

## Open with Codespaces

> You must be a member of the Microsoft OSS and CSE-Labs GitHub organizations

- Instructions for joining the GitHub orgs are [here](https://github.com/cse-labs/moss)
  - If you don't see an `Open in Codespaces` option, you are not part of the organization(s)

- Click the `Code` button on this repo
- Click the `Codespaces` tab
- Click `New Codespace`
- Choose the `4 core` option

![Create Codespace](./images/OpenWithCodespaces.jpg)

## Open Workspace

> Wait until the Codespace is ready before opening the workspace

- Once setup is complete, open the workspace
  - Click the `hamburger` menu
  - Click `File`
  - Click `Open Workspace from file`
  - Click `workspaces`
  - Click `cse-labs.code-workspace`
- Your screen will reload
  - You may have to click on the terminal tab once Codespaces reloads

## Stopping a Codespace

- Codespaces will shutdown automatically after 30 minutes of non-use
- To shutdown a codespace immediately
  - Click `Codespaces` in the lower left of the browser window
  - Choose `Stop Current Codespace` from the context menu

- You can also rebuild the container that is running your Codespace
  - Any changes in `/workspaces` will be retained
  - Other directories will be reset
  - Click `Codespaces` in the lower left of the browser window
  - Choose `Rebuild Container` from the context menu
  - Confirm your choice

- To delete a Codespace
  - <https://github.com/codespaces>
  - Use the context menu to delete the Codespace

## Build and Deploy a k3d Cluster

- This will create a local Kubernetes cluster using k3d
  - The cluster is running inside your Codespace

  ```bash

  # build the cluster
  make all

  ```

- Output from `make all` should resemble this

  ```text

  default      jumpbox                                   1/1   Running   0   25s
  default      ngsa-memory                               1/1   Running   0   33s
  default      webv                                      1/1   Running   0   31s
  logging      fluentbit                                 1/1   Running   0   31s
  monitoring   grafana-64f7dbcf96-cfmtd                  1/1   Running   0   32s
  monitoring   prometheus-deployment-67cbf97f84-tjxm7    1/1   Running   0   32s

  ```

![Running Codespace](./images/RunningCodespace.png)

## Validate Deployment

- If you get an error, just run the command again - it will clear once the services are ready

```bash

# check endpoints
make check

```

## Validate deployment with k9s

- From the Codespace terminal window, start `k9s`
  - Type `k9s` and press enter
  - Press `0` to select all namespaces
  - Wait for all pods to be in the `Running` state (look for the `STATUS` column)
  - Use the arrow key to select `nsga-memory` then press the `l` key to view logs from the pod
  - To go back, press the `esc` key
  - Use the arrow key to select `jumpbox` then press `s` key to open a shell in the container
    - Hit the `ngsa-memory` NodePort from within the cluster by executing `http ngsa-memory:8080/version`
    - Verify 200 status in the response
    - To exit - `exit`
  - To view other deployed resources - press `shift + :` followed by the deployment type (e.g. `secret`, `services`, `deployment`, etc).
  - To exit - `:q <enter>`

![k9s](./images/k9s.png)

### Other interesting endpoints

Open [curl.http](./curl.http)

> [curl.http](./curl.http) is used in conjuction with the Visual Studio Code [REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) extension.
>
> When you open [curl.http](./curl.http), you should see a clickable `Send Request` text above each of the URLs

![REST Client example](./images/RESTClient.png)

Clicking on `Send Request` should open a new panel in Visual Studio Code with the response from that request like so:

![REST Client example response](./images/RESTClientResponse.png)

## Jump Box

A `jump box` pod is created so that you can execute commands `in the cluster`

- use the `kj` alias
  - `kubectl exec -it jumpbox -- bash -l`
    - note: -l causes a login and processes `.profile`
    - note: `sh -l` will work, but the results will not be displayed in the terminal due to a bug
- example
  - run `kj`
    - Your terminal prompt will change
    - From the `jumpbox` terminal
    - Run `http ngsa-memory:8080/version`
    - `exit` back to the Codespaces terminal

- use the `kje` alias
  - `kubectl exec -it jumpbox --`
- example
  - run http against the ClusterIP
    - `kje http ngsa-memory:8080/version`

- Since the jumpbox is running `in` the cluster, we use the service name and port, not the NodePort
  - A jumpbox is great for debugging network issues

## NodePorts

- Codespaces exposes `ports` to the browser
- We take advantage of this by exposing `NodePort` on most of our K8s services
- Codespaces ports are setup in the `.devcontainer/devcontainer.json` file

- Exposing the ports

  ```json

  // forward ports for the app
  "forwardPorts": [
    30000,
    30080,
    30088,
    32000
  ],

  ```

- Adding labels to the ports

  ```json

  // add labels
  "portsAttributes": {
    "30000": { "label": "Prometheus" },
    "30080": { "label": "ngsa-app" },
    "30088": { "label": "WebV" },
    "32000": { "label": "Grafana" },
  },

  ```

## View NGSA App

- Click on the `ports` tab of the terminal window
- Click on the `open in browser icon` on the ngsa-app port (30080)
- This will open the ngsa-app home page (Swagger) in a new browser tab

## View Web Validate

- Click on the `ports` tab of the terminal window
- Click on the `open in browser icon` on the WebV port (30088)
- This will open the Web Validate in a new browser tab
  - Note that you will get a 404 as WebV does not have a home page
  - Add `version` or `metrics` to the end of the URL in the browser tab

## Build and deploy a local version of ngsa-memory

- We have a local Docker container registry running in the Codespace
  - Run `docker ps` to see the running images
- Build the WebAPI app from the local source code
- Push to the local Docker registry
- Deploy to local k3d cluster

- Switch back to your Codespaces tab

  ```bash

  # from Codespaces terminal

  # make and deploy a local version of ngsa-memory to k8s
  make app

  # check the app version
  # the semver will have the current date and time
  http localhost:30080/version

  ```
  
## View Prometheus Dashboard

- Click on the `ports` tab of the terminal window
- Click on the `open in browser icon` on the Prometheus port (30000)
- This will open Prometheus in a new browser tab

- From the Prometheus tab
  - Begin typing `NgsaAppDuration_bucket` in the `Expression` search
  - Click `Execute`
  - This will display the `histogram` that Grafana uses for the charts

## View Grafana Dashboard

- Grafana login info
  - admin
  - cse-labs

- Click on the `ports` tab of the terminal window
  - Click on the `open in browser icon` on the Grafana port (32000)
  - This will open Grafana in a new browser tab

![Codespace Ports](./images/CodespacePorts.jpg)

## Grafana Dashboard

![Grafana](./images/ngsa-requests-by-mode.png)

## Run integration and load tests

```bash

# from Codespaces terminal

# run an integration test (will generate warnings in Grafana)
make test

# run a 60 second load test
make load-test

```

- Switch to the Grafana brower tab
- The integration test generates 400 and 404 results by design
- The requests metric will go from green to yellow to red as load increases
  - It may skip yellow
- As the test completes
  - The metric will go back to green (10 req/sec)
  - The request graph will return to normal

![Load Test](./images/test-with-errors-and-load-test.png)

## View Fluent Bit Logs

> Fluent Bit is set to forward logs to stdout for debugging
>
> Fluent Bit can be configured to forward to different services including Azure Log Analytics

- Start `k9s` from the Codespace terminal
- Press `0` to show all `namespaces`
- Select `fluentbit` and press `enter`
- Press `enter` again to see the logs
- Press `s` to Toggle AutoScroll
- Press `w` to Toggle Wrap
- Review logs that will be sent to Log Analytics when configured
  - See `deploy/loganalytics` for directions

## Next Steps

> [Makefile](./Makefile) is a good place to start exploring

We use the `makefile` to encapsulate and document common tasks

## FAQ

- Why don't we use helm to deploy Kubernetes manifests?
  - The target audience for this repository is app developers so we chose simplicity for the Developer Experience.
  - In our daily work, we use Helm for deployments and it is installed in the `Codespace` should you want to use it.
- Why `k3d` instead of `Kind`?
  - We love kind! Most of our code will run unchanged in kind (except the cluster commands)
  - We had to choose one or the other as we don't have the resources to validate both
  - We chose k3d for these main reasons
    - Smaller memory footprint
    - Faster startup time
    - Secure by default
      - K3s supports the [CIS Kubernetes Benchmark](https://rancher.com/docs/k3s/latest/en/security/hardening_guide/)
    - Based on [K3s](https://rancher.com/docs/k3s/latest/en/) which is a certified Kubernetes distro
      - Many customers run K3s on the edge as well as in CI-CD pipelines
    - Rancher provides support - including 24x7 (for a fee)
    - K3s has a vibrant community
    - K3s is a CNCF sandbox project

### Engineering Docs

- Team Working [Agreement](.github/WorkingAgreement.md)
- Team [Engineering Practices](.github/EngineeringPractices.md)
- CSE Engineering Fundamentals [Playbook](https://github.com/Microsoft/code-with-engineering-playbook)

## How to file issues and get help

This project uses GitHub Issues to track bugs and feature requests. Please search the existing issues before filing new issues to avoid duplicates. For new issues, file your bug or feature request as a new issue.

For help and questions about using this project, please open a GitHub issue.

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit <https://cla.opensource.microsoft.com>

When you submit a pull request, a CLA bot will automatically determine whether you need to provide a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services.

Authorized use of Microsoft trademarks or logos is subject to and must follow [Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).

Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.

Any use of third-party trademarks or logos are subject to those third-party's policies.
