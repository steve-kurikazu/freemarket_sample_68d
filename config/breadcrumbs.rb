crumb :root do
  link "トップページ", root_path
end

crumb :item_show do
  if params[:item_id]
    link "商品詳細", item_path(params[:item_id])  
    parent :root
  else
    link "商品詳細", item_path(params[:id])  
    parent :root
  end
end

crumb :children do
  link "購入内容確認",  new_item_order_path(params[:item_id])
  parent :item_show
end

crumb :g_children do
  link "購入完了",  pay_item_orders_path(params[:item_id])
  parent :children
end



# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).