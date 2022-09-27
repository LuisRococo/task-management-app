class PlanPresenter
  def initialize(plan)
    @plan = plan
  end

  def edit_page_header
    { title: 'Edit plan information',
      text: "Change information of '#{@plan.title}' plan",
      config: true }
  end
end
