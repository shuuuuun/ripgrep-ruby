RSpec.describe Ripgrep do
  it 'has a version number' do
    expect(Ripgrep::VERSION).not_to be nil
  end

  it 'display version.' do
    expect(Ripgrep::Core.version).to eq(`rg --version`)
  end

  it 'display help' do
    expect(Ripgrep::Core.help).to eq(`rg --help`)
  end
end
