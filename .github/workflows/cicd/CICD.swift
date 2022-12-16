import SwiftCI

@main
struct CICD: Workflow {
    func run() async throws {
        try await runSwiftPR(PullRequestStandards.self)
        try await build()
        try await test()
        let assets = try await importSigningAssets(
            appStoreConnectKeySecret: .init(
                keyID: "76T4SJRBUR",
                keyIssuerID: "69a6de96-6d58-47e3-e053-5b8c7c11a4d1"
            )
        )
        try await uploadToAppStore(
            profile: assets.profile,
            appStoreConnectKey: assets.appStoreConnectKey
        )
    }
}
