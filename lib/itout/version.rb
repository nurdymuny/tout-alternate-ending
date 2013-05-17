module ITout
  class Version
    MAJOR = 1 unless defined? ITout::Version::MAJOR
    MINOR = 2 unless defined? ITout::Version::MINOR
    PATCH = 0 unless defined? ITout::Version::PATCH

    class << self

      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end

    end

  end
end
