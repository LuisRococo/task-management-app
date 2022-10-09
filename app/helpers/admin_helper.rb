module AdminHelper
  def admin_white_list_index_header
    { title: 'White lists',
      text: 'Add white listed users. White listed users will avoid block by no payment, but still affected by other types of block',
      config: true }
  end
end
