require 'helper'

class TestLogAdapter < Test::Unit::TestCase
  class LoggerDouble
    attr_accessor :level
  end

  context "#log_level=" do
    should "set the writers logging level" do
      subject = Jekyll::LogAdapter.new(LoggerDouble.new)
      subject.log_level = :error
      assert_equal Jekyll::LogAdapter::LOG_LEVELS[:error], subject.writer.level
    end
  end

  context "#debug" do
    should "call #debug on writer return true" do
      writer = LoggerDouble.new
      logger = Jekyll::LogAdapter.new(writer)
      stub(writer).debug('topic '.rjust(20) + 'log message') { true }
      assert logger.debug('topic', 'log message')
    end
  end

  context "#info" do
    should "call #info on writer return true" do
      writer = LoggerDouble.new
      logger = Jekyll::LogAdapter.new(writer)
      stub(writer).info('topic '.rjust(20) + 'log message') { true }
      assert logger.info('topic', 'log message')
    end
  end

  context "#warn" do
    should "call #warn on writer return true" do
      writer = LoggerDouble.new
      logger = Jekyll::LogAdapter.new(writer)
      stub(writer).warn('topic '.rjust(20) + 'log message') { true }
      assert logger.warn('topic', 'log message')
    end
  end

  context "#error" do
    should "call #error on writer return true" do
      writer = LoggerDouble.new
      logger = Jekyll::LogAdapter.new(writer)
      stub(writer).error('topic '.rjust(20) + 'log message') { true }
      assert logger.error('topic', 'log message')
    end
  end

  context "#abort_with" do
    should "call #error and abort" do
      logger = Jekyll::LogAdapter.new(LoggerDouble.new)
      stub(logger).error('topic', 'log message') { true }
      assert_raise(SystemExit) { logger.abort_with('topic', 'log message') }
    end
  end
end
