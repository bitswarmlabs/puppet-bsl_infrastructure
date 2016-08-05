class bsl_infrastructure::auth {
  if $trusted['certname'] != $servername {
    fail("bsl_infrastructure can only be utilized by $::server_facts['servername']")
  }
}
