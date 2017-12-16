val request : in_channel * out_channel -> 'a Ssh_agent.ssh_agent_request ->
  ('a Ssh_agent.ssh_agent_response, string) result
(** [request (ic, oc) request] make a request corresponding to [request] using
 * [(ic, oc)] as the "socket". *)

val listen : in_channel * out_channel -> Ssh_agent.request_handler ->
  (Ssh_agent.any_ssh_agent_response, string) result
(** [listen (ic, oc) handler] listen for ssh-agent requests over (ic, oc)
 * calling [handler.handle] with the request as argument, and writing the
 * result back. *)
