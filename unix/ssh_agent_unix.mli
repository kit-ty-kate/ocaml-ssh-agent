val request : in_channel * out_channel -> 'a Ssh_agent.ssh_agent_request ->
  ('a Ssh_agent.ssh_agent_response, string) result

val listen : in_channel * out_channel -> Ssh_agent.request_handler ->
  (Ssh_agent.any_ssh_agent_response, string) result
