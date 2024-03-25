
$git_user = "git"
$gitlab_user = "gitlab"
$gitlab_group = "git"

$gitlab_dbpwd = "oi0Wikee"
$gitlab_home = "/home/gitlab"
$git_server_addr = "127.0.0.1"
$git_server_port = "7111"

class {"precise-gitlab::gitlab":
   git_user => $git_user,
	git_group => $git_user,
	gitlab_user => $gitlab_user,
	gitlab_group => $gitlab_group,
	gitlab_dbuser => $gitlab_user,
	gitlab_dbpwd => $gitlab_dbpwd,
	gitlab_dbname => "gitlab",
	gitlab_home => $gitlab_home,
	git_server_addr => $git_server_addr,
   git_server_port => $git_server_port

}
