require 'tree'
require_relative 'settings'

class MindmapTreeNode < Tree::TreeNode
	
	def initialize name, content
		weburl =  Settings.instance.hash['jira']['weburl']
		@jira_issue_link_regexp = Regexp.escape(weburl)
		super
	end

	def from_jira?
		content && content['title'] && !!(content['title'] =~ /#{@jira_issue_link_regexp}/)
	end

	def jira_issue_key
		if content && content['title']
			match = content['title'].match(/#{@jira_issue_link_regexp}\/(.*)/)
			match[1] if match
		end	
	end
end