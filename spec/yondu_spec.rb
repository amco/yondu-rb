# frozen_string_literal: true

RSpec.describe Yondu do
  it "has a version number" do
    expect(Yondu::VERSION).not_to be_nil
  end

  describe Yondu::Settings do
    subject(:settings) { described_class.new(config) }

    let(:config) do
      {
        app: {
          host: "myapp.com",
          port: 443
        }
      }
    end

    context "with no config keys" do
      it "returns the value" do
        expect(settings.get).to eql config
      end
    end

    context "with top-level config keys" do
      it "returns the value" do
        expect(settings.get(:app)).to eql config[:app]
      end
    end

    context "with nested config keys" do
      it "returns the value" do
        expect(settings.get(:app, :port)).to eql config.dig(:app, :port)
      end
    end

    context "with missing top-level config keys" do
      it "raises error with config key in the message" do
        expect { settings.get(:other) }
          .to raise_error(Yondu::MissingSettingError, "Missing setting: other")
      end
    end

    context "with missing nested config keys" do
      it "raises error with the settings path" do
        expect { settings.get(:app, :use_ssl) }
          .to raise_error(Yondu::MissingSettingError, "Missing setting: app->use_ssl")
      end
    end

    context "with more config keys after a missing one" do
      it "raises error with the settings path until the one missing" do
        expect { settings.get(:app, :use_ssl, :other) }
          .to raise_error(Yondu::MissingSettingError, "Missing setting: app->use_ssl")
      end
    end

    context "with no-hash nested config keys" do
      it "raises error notifying no-hash config is present" do
        expect { settings.get(:app, :port, :other) }
          .to raise_error(Yondu::NoHashSettingError, "No hash setting: app->port")
      end
    end
  end
end
