require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'

class MirrorListServer < Sinatra::Base
  LOCAL_MIRROR = '10.12.6.22'

  CENTOS_MIRRORS = %W(
    http://#{LOCAL_MIRROR}:4567/CentOS
    http://ftp.jaist.ac.jp/pub/Linux/CentOS
  )

  EPEL_MIRRORS = %W(
    http://#{LOCAL_MIRROR}:4567/epel
    http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel
  )

  OPENVZ_UTILS_MIRRORS = %W(
    http://download.openvz.org/current/
  )

  OPENVZ_KERNEL_MIRRORS = %W(
    http://download.openvz.org/kernel/branches/rhel6-2.6.32/current/
  )

  set :public_folder, File.expand_path('..', __FILE__)

  get '/centos/:release/:repo/:arch' do
    params[:release] = '6.4' if params[:release] == '6'
    content = CENTOS_MIRRORS.collect do |m|
      File.join(m, params[:release], params[:repo], params[:arch])
    end
    content_type :text
    content.join("\n")
  end

  get '/epel/:version/:arch' do
    content = EPEL_MIRRORS.collect do |m|
      File.join(m, params[:version], params[:arch])
    end
    content_type :text
    content.join("\n")
  end

  get '/openvz-utils' do
    content_type :text
    OPENVZ_UTILS_MIRRORS.join("\n")
  end

  get '/openvz-kernel' do
    content_type :text
    OPENVZ_KERNEL_MIRRORS.join("\n")
  end
end

run MirrorListServer

