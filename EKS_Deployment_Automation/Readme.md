Create a buildspec.yml file to support CI/CD for the code repo.
Sample buildspec.yml file is attached. More details about creating buildspec.yml can be found here "https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html"

Create a CI/CD Pipeline with the CI_CD_cloudformation.yml script with the parameters as shown:

Stackname - Provide a name for the stack
CodeBuildDockerImage - aws/codebuild/docker:17.09.0
EksClusterName	- <Name of the Cluster>
GitBranch	master
GitHubToken	- <GitHub User name>
- Generate github token as shwon here https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line

GitHubUser - <GitHubToken>
GitSourceRepo - <Name of the repo>
KubectlRoleName	- <Role name copied from Tenant_Authorization_Scripts>