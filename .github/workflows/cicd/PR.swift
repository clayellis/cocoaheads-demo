import SwiftPR

struct PullRequestStandards: PRCheck {
    func run() async throws {
        checkForEmptyPullRequestDescription()
        checkForComplexity()
    }

    func checkForEmptyPullRequestDescription() {
        guard let body = pr.pullRequest.body, !body.isEmpty else {
            pr.output.warning("Pull requests should have a description")
            return
        }
    }

    func checkForComplexity() {
        let createdAndModified = pr.diff.created + pr.diff.modified
        if createdAndModified.count > 10 {
            pr.output.warning("This is a big pull request, maybe consider breaking it up?")
        } else if createdAndModified.count > 20 {
            pr.output.error("This pull request is too big. Please break it up.")
        }
    }
}
