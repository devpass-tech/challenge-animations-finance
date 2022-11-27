protocol ViewCodable {
    func setup()
    func setupSubviews()
    func setupConstraints()
    func setupExtraConfiguration()
}

extension ViewCodable {
    func setup() {
        setupSubviews()
        setupConstraints()
        setupExtraConfiguration()
    }
    
    func setupExtraConfiguration() {}
}
