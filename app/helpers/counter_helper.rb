module CounterHelper
  def current_quark_count
    # Rails.cache.fetch(:quark_count) do
    Quark.sum(:count)
    # end
  end
end
