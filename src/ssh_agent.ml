include Types

module Parse = Parse
module Serialize = Serialize

let is_extension_request (type a) (req : a ssh_agent_request) =
  match req with
  | Ssh_agentc_extension _ -> true
  | _ -> false

let unpack_any_response (type a) (request : a ssh_agent_request) (response : any_ssh_agent_response)
  : (a ssh_agent_response, string) result =
  let success_or_fail (resp : any_ssh_agent_response)
    : ([`Ssh_agentc_successable] ssh_agent_response, string) result =
    match resp with
    | Any_response (Ssh_agent_success as r) -> Ok r
    | Any_response (Ssh_agent_failure as r) -> Ok r
    | Any_response _ -> Error "Illegal response type"
  in
  match request with
  | Ssh_agentc_request_identities ->
    begin match response with
      | Any_response (Ssh_agent_identities_answer _ as r) ->
        Ok r
      | Any_response (Ssh_agent_failure as r) ->
        Ok r
      | _ ->
        Error "Illegal response type"
    end
  | Ssh_agentc_sign_request (_,_,_) ->
    begin match response with
      | Any_response (Ssh_agent_sign_response _ as r) ->
        Ok r
      | Any_response (Ssh_agent_failure as r) ->
        Ok r
      | _ ->
        Error "Illegal response type"
    end
  | Ssh_agentc_extension _ ->
    begin match response with
      | Any_response (Ssh_agent_extension_failure as r) ->
        Ok r
      | Any_response (Ssh_agent_extension_success _ as r) ->
        Ok r
      | Any_response (Ssh_agent_failure as r) ->
        Ok r
      | _ ->
        Error "Illegal response type"
    end
  | Ssh_agentc_add_identity _ -> success_or_fail response
  | Ssh_agentc_remove_identity _ -> success_or_fail response
  | Ssh_agentc_remove_all_identities -> success_or_fail response
  | Ssh_agentc_add_smartcard_key _ -> success_or_fail response
  | Ssh_agentc_remove_smartcard_key _ -> success_or_fail response
  | Ssh_agentc_lock _ -> success_or_fail response
  | Ssh_agentc_unlock _ -> success_or_fail response
  | Ssh_agentc_add_id_constrained _ -> success_or_fail response
  | Ssh_agentc_add_smartcard_key_constrained _ -> success_or_fail response
