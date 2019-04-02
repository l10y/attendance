require 'json'
require 'date'

#
# 計算機
#
class Calculator
  #
  # 初期化
  #
  # @param [String] 出勤時間（ISO8601形式）
  # @param [String] 退勤時間（ISO8601形式）
  #
  def initialize(started_at, ended_at)
    @started_at = DateTime.parse(started_at)
    @ended_at = DateTime.parse(ended_at)
  end

  #
  # 勤務時間
  #
  # @param [Integer] bread_time 休憩時間
  #
  # @return [Integer] 勤務時間（分）
  #
  def worktime(break_time = default_break_time)
    minutes - break_time
  end

  #
  # 残業時間
  #
  # @return [Integer] 残業時間（分）
  #
  def overtime
    [0, worktime - 8 * 60].max
  end

  #
  # 深夜時間
  #
  # @return [Integer] 深夜時間（分）
  #
  def ratetime
    time = Time.new(
      started_time.year,
      started_time.month,
      started_time.day,
      22,
      0,
      0
    )

    return 0 if time >= ended_time

    result = (ended_time - time).to_i / 60

    if minutes > (9 * 60)
      return result - 60 if result > 4 * 60
      return result - 30 if result > 0
    end

    result
  end

  private

  def started_time
    @started_time ||=
      Time.new(
        @started_at.year,
        @started_at.month,
        @started_at.day,
        @started_at.hour,
        @started_at.minute
      )
  end

  def ended_time
    @ended_time ||=
      Time.new(
        @ended_at.year,
        @ended_at.month,
        @ended_at.day,
        @ended_at.hour,
        @ended_at.minute - @ended_at.minute % 30
      )
  end

  def minutes
    @minutes ||= (ended_time - started_time).to_i / 60
  end

  def default_break_time
    if minutes <= (6 * 60)
      0
    # elsif minutes < (8 * 60) # TODO: 30 分単位なので事実上ありえない
    #   45
    elsif minutes < (9 * 60 + 30)
      60
    elsif minutes <= (13 * 60)
      90
    elsif minutes <= (20 * 60 + 30)
      120
    else
      150
    end
  end
end
