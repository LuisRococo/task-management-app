module PlanHelper
  def index_header
    { title: 'Prices and Plans',
      text: 'Edit plan data like price and users allowed.',
      config: true }
  end

  def plan_new_header
    { title: 'Create plan',
      text: 'Create a new plan for your users.',
      config: true }
  end

  def user_plans_header
    { title: 'Prices and plans',
      text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Temporibus quos quisquam molestiae quo commodi beatae cum debitis natus nihil repudiandae.' }
  end

  def plan_info_to_show(plan)
    { title: plan.title,
      price: plan.price.to_s,
      time_months: plan.time_months,
      member_quantity: plan.member_quantity }
  end
end
