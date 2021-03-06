#
# configures the storage backend for glance
# as a rbd instance
#
#  $rbd_store_user - Optional.
#
#  $rbd_store_pool - Optional. Default:'images'
#
#  $rbd_store_ceph_conf  - Optional. Default:'/etc/ceph/ceph.conf'
#
#  $rbd_store_chunk_size - Optional. Default:'8'
#
#  $show_image_direct_url - Optional. Enables direct COW from glance to rbd

class glance::backend::rbd(
  $rbd_store_user         = undef,
  $rbd_store_ceph_conf    = '/etc/ceph/ceph.conf',
  $rbd_store_pool         = 'images',
  $rbd_store_chunk_size   = '8',
  $show_image_direct_url  = undef,
) {
  include glance::params

  glance_api_config {
    'DEFAULT/default_store':          value => 'rbd';
    'DEFAULT/rbd_store_ceph_conf':    value => $rbd_store_ceph_conf;
    'DEFAULT/rbd_store_user':         value => $rbd_store_user;
    'DEFAULT/rbd_store_pool':         value => $rbd_store_pool;
    'DEFAULT/rbd_store_chunk_size':   value => $rbd_store_chunk_size;
    'DEFAULT/show_image_direct_url':  value => $show_image_direct_url;
  }

  package { 'python-ceph':
    ensure => 'present',
    name   => $::glance::params::pyceph_package_name,
  }

}
