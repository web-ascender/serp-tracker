module SourceReportsHelper

  def pass
    raw('<span class="label label-success">Pass</span>')
  end

  def fail
    raw('<span class="label label-important">Fail</span>')
  end
end
