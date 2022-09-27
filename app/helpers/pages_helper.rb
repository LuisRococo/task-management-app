module PagesHelper
  def app_features
    features = [{ title: 'Feature',
                description: 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti',
                img: 'idea-black.jpg' }]
    features *= 4
  end
end
