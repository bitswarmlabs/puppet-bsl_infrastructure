class bsl_infrastructure::aws(
  $manage_cli = 'true',
  $manage_sdk = 'true',
) {
  if str2bool($manage_cli) {
    include 'bsl_infrastructure::aws::cli'
  }

  if str2bool($manage_sdk) {
    include 'bsl_infrastructure::aws::sdk'
  }
}
