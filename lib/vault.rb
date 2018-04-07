# frozen_string_literal: true
require 'ffi'

module Vault
  extend FFI::Library
  ffi_lib ENV['VAULT_PATH'].to_s || Rails.root.join('vendor', 'libvault.so')
  attach_function :parse_to_cstring, [:string], :pointer
  attach_function :free_cstring, [:pointer], :void
end
