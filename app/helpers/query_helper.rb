module QueryHelper

	def query_process_status(query)

		if query.is_processed
			
			content_tag :i, '', class: "glyphicon glyphicon-ok color-success"
		else
			content_tag :div, class: "progress" do
				content_tag :div, class: "progress-bar progress-bar-striped active", role: "progressbar", style: "width:45%" do
					content_tag :span, class: "sr-only" do
						"45% complete"
					end
				end
			end
		end
	end

	def query_leads(query)

		Apartment::Tenant.switch(request.subdomain)
		total_leads = query.leads.count

		if total_leads > 0
			link_to query_leads_path(query, class: "query-tool") do
				content_tag(:i, '', class: 'glyphicon glyphicon-user')
			end
		end

	end

end