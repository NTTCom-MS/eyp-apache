# puppet2sitepp @apachedirectories
define apache::directory (
                              $directory,
                              $servername         = $name,
                              $vhost_order        = '00',
                              $port               = '80',
                              $allowedip          = undef,
                              $denyip             = undef,
                              $options            = $apache::params::options_default,
                              $allowoverride      = $apache::params::allowoverride_default,
                              $ssl_options        = [],
                            ) {

  if($allowedip!=undef)
  {
    validate_array($allowedip)
  }

  if($denyip!=undef)
  {
    validate_array($denyip)
  }

  validate_string($vhost_order)

  validate_string($port)

  validate_string($name)

  validate_array($options)

  validate_string($allowoverride)

  concat::fragment{ "${apache::params::baseconf}/conf.d/sites/${vhost_order}-${servername}-${port}.conf.run ${directory}":
    target  => "${apache::params::baseconf}/conf.d/sites/${vhost_order}-${servername}-${port}.conf.run",
    content => template("${module_name}/directory/directory.erb"),
    order   => '03',
  }
}
