# Nke.Tools.ContainerTemplate 

![GTHB Workflow Status](https://img.shields.io/github/workflow/status/bluekrow-dockerhub/Nke.Tools.ContainerTemplate/Auto-Versioning?label=Auto%20Version&logo=github&logoColor=gainsboro)
![DCKR Cloud Build Status](https://img.shields.io/docker/cloud/build/bluekrow/nke-tools-containerTemplate?label=Auto%20Build&logo=docker&logoColor=gainsboro)
![GTHB Last Commit](https://img.shields.io/github/last-commit/bluekrow-dockerhub/Nke.Tools.ContainerTemplate?label=Last%20Commit&logo=github&logoColor=gainsboro)
![GTHB Latest Tag (by date)](https://img.shields.io/github/v/tag/bluekrow-dockerhub/Nke.Tools.ContainerTemplate?label=Latest%20Tag&logo=github&logoColor=gainsboro)

Customized \<INSERT-APP-HERE> image to execute on an [Alpine](https://alpinelinux.org) container  

## NOTICE: THIS IS A WORK IN PROGRESS
Will change Alpha label accordingly when Dockerfile becomes stable 

## Automation
### Auto Versioning
Using GitHub Actions, and a [VERSION](VERSION) file, for auto tagging, only when pushing commits to master.  
The current alternatives for VERSION file content are:
- Alpha.\<number>
- Beta.\<number>
- \<number>.\<number>
 
**Next Step**: would be auto semantic versioning.
### Auto Build
Using DockerHub automatic builds, to build the following docker tags every time a tag is created on GitHub repository master branch:
- Latest
- \<major>
- \<major>.\<minor>
- \<major>.\<minor>.\<builtAtDay>.\<builtAtSecond>

To implement this, 4 rules must be set on DockerHub autobuild configuration, that will use the following settings 
| Source Type | Source                                       | Docker Tag            |
|-------------|----------------------------------------------|-----------------------|
| Tag         | `/^v(Alpha\|Beta\|\d+)\.(\d+)\.(\d+)\.(\d+)$/` | `latest`              |
| Tag         | `/^v(Alpha\|Beta\|\d+)\.(\d+)\.(\d+)\.(\d+)$/` | `{\1}`                |
| Tag         | `/^v(Alpha\|Beta\|\d+)\.(\d+)\.(\d+)\.(\d+)$/` | `{\1}.{\2}`           |
| Tag         | `/^v(Alpha\|Beta\|\d+)\.(\d+)\.(\d+)\.(\d+)$/` | `{\1}.{\2}.{\3}.{\4}` |

Also the option _AUTOTEST_ must be change to:
- Internal Pull Requests

### Auto Test 
Using DockerHub automatic testing with a System Under Test (SUT) service after every build and before every push to the DockerHub registry.

## User Guide
\<TO_BE_INCLUDED>

## Troubleshooting
### 1. Permissions error when executing SUTs on Dockerhub
  ```
  ERROR: for buiwe9sh63hwrcjhglrerqm_sut_1 Cannot start service sut: OCI runtime create failed: container_linux.go:349: starting container process caused "exec: \"/entrypoint.sh\": permission denied": unknown  

  ERROR: for sut Cannot start service sut: OCI runtime create failed: container_linux.go:349: starting container process caused "exec: \"/entrypoint.sh\": permission denied": unknown

  Encountered errors while bringing up the project.

  starting "sut" service in dockerhub.test.yml (1)
  ```
  **Solution**  
The `entrypoint.sh` and other files executed inside the container, should be made executable
```
git update-index --chmod=+x entrypoint.sh
```
