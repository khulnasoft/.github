module.exports = async function downloadArtifact({ github, context, fs, workflowRunId, workspace, artifactName }) {
  console.log("download_artifact.....");
  const artifacts = await github.rest.actions.listWorkflowRunArtifacts({
    owner: context.repo.owner,
    repo: context.repo.repo,
    run_id: workflowRunId,
  });
  const matchArtifact = artifacts.data.artifacts.find((artifact) => artifact.name === artifactName);
  if (!matchArtifact) {
    throw new Error(`Artifact with name "${artifactName}" not found.`);
  }
  const download = await github.rest.actions.downloadArtifact({
    owner: context.repo.owner,
    repo: context.repo.repo,
    artifact_id: matchArtifact.id,
    archive_format: "zip",
  });
  fs.writeFileSync(`${workspace}/pull-request-artifact.zip`, Buffer.from(download.data));
};
