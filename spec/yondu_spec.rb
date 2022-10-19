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

    context "when config exists" do
      context "with top-level configs" do
        it "returns the value" do
          expect(subject.get(:app)).to eql settings[:app]
        end
      end

      context "with nested configs" do
        it "returns the value" do
          expect(subject.get(:app, :port)).to eql settings[:app][:port]
        end
      end
    end

    context "when config does not exist" do
      context "with top-level configs" do
        it "raises Yondu::MissingSetting error" do
          expect { subject.get(:other) }
            .to raise_error(Yondu::MissingSetting, "Missing setting: other")
        end
      end

      context "with nested configs" do
        it "raises Yondu::MissingSetting error" do
          expect { subject.get(:app, :use_ssl) }
            .to raise_error(Yondu::MissingSetting, "Missing setting: app->use_ssl")
        end
      end
    end
  end
end
