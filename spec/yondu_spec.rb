# frozen_string_literal: true

RSpec.describe Yondu do
  it "has a version number" do
    expect(Yondu::VERSION).not_to be nil
  end

  describe Yondu::Settings do
    let(:settings) do
      {
        app: {
          host: "myapp.com",
          port: 443
        }
      }
    end

    subject { described_class.new(settings) }

    context "with no config keys" do
      it "returns the value" do
        expect(subject.get).to eql settings
      end
    end

    context "with top-level config keys" do
      it "returns the value" do
        expect(subject.get(:app)).to eql settings[:app]
      end
    end

    context "with nested config keys" do
      it "returns the value" do
        expect(subject.get(:app, :port)).to eql settings.dig(:app, :port)
      end
    end

    context "with missing top-level config keys" do
      it "raises error with config key in the message" do
        expect { subject.get(:other) }
          .to raise_error(Yondu::MissingSettingError, "Missing setting: other")
      end
    end

    context "with missing nested config keys" do
      it "raises error with the settings path" do
        expect { subject.get(:app, :use_ssl) }
          .to raise_error(Yondu::MissingSettingError, "Missing setting: app->use_ssl")
      end
    end

    context "with more config keys after a missing one" do
      it "raises error with the settings path until the one missing" do
        expect { subject.get(:app, :use_ssl, :other) }
          .to raise_error(Yondu::MissingSettingError, "Missing setting: app->use_ssl")
      end
    end

    context "with no-hash nested config keys" do
      it "raises error notifying no-hash config is present" do
        expect { subject.get(:app, :port, :other) }
          .to raise_error(Yondu::NoHashSettingError, "No hash setting: app->port")
      end
    end
  end
end
