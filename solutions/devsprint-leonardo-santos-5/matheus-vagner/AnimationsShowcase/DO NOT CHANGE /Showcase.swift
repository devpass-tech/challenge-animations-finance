struct Showcase {
    let components: [ShowcaseSection] = [
        .header, .animations, .propertyAnimator, .lottie
    ]
}

private extension ShowcaseSection {
    static var header: Self {
        .init(
            rows: [HeaderShowcase()]
        )
    }
    
    static var animations: Self {
        .init(
            title: "Seção 1",
            subtitle: "UIView.animate",
            rows: [
                PositioningShowcase(),
                RotationAndScaleShowcase(),
                FadeInFadeOutShowcase(),
                FlipShowcase(),
                SpringShowcase(),
                BezierShowcase(),
                FirstSectionChallengeShowcase()
            ]
        )
    }
    
    static var propertyAnimator: Self {
        .init(
            title: "Seção 2",
            subtitle: "Rive",
            rows: [
                RiveIntroductionShowcase(),
                RiveChallengeShowcase()
            ]
        )
    }
    
    static var lottie: Self {
        .init(
            title: "Seção 3",
            subtitle: "Lottie",
            rows: [
                LottieBasicsShowcase(),
                LottieChangeTextShowcase(),
                LottieChangeColorShowcase(),
                LottieChangeProgressShowcase(),
                LottieChallengeShowcase()
            ]
        )
    }
}
