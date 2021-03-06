require "qlite/version"

require 'net/http'
require 'json'

module Qlite
  class Client

    attr_reader :provider

    def initialize(settings = {})
      pp "Qlite::Client- initialize"
      pp settings
      setSettings(settings)
    end

    # change_node	cn	changes the node used to connect to and interact with the tangle
    # TODO

    # fetch_epoch	fe	determines the quorum based result (which can be considered the consensus) of any qubic at any epoch
    def fetch_epoch(qubic_id)
        pp "RUN Qlite::fetch_epochs"
        body = {command: 'fetch_epoch', 'qubic id': qubic_id, 'epoch index': 0, 'epoch index max': 100}
        return send_request(body)
    rescue => e
        puts "failed #{e}"
    end

    # qubic_read	qr	reads the metadata of any qubic, thus allows the user to analyze that qubic
    def qubic_read(qubic_id)
      pp "RUN Qlite::qubic_read"
      body = {command: 'qubic_read', 'qubic id': qubic_id}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # qubic_list	ql	prints the full list of all qubics stored in the persistence
    def qubic_list(qubic_id)
      pp "RUN Qlite::qubic_list"
      body = {command: 'qubic_list', 'qubic id': qubic_id}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # qubic_create	qc	creates a new qubic and stores it in the persistence. life cycle will not be automized: do the assembly transaction manually
    def qubic_create(data)
      pp "RUN Qlite::qubic_create"
      body = {command: 'qubic_create', "execution start": data[:execution_start], "runtime limit": data[:runtime_limit], "hash period duration": data[:hash_period_duration], "result period duration": data[:result_period_duration], code: data[:code]}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # qubic_delete	qd	removes a qubic from the persistence (qubic's private key will be deleted: cannot be undone)
    def qubic_delete(qubic_id)
      pp "RUN Qlite::qubic_delete"
      body = {command: 'qubic_delete', "qubic handle": qubic_id}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # qubic_list_applications	qla	lists all incoming oracle applications for a specific qubic, basis for 'qubic_assembly_add'
    def qubic_list_applications(qubic_id)
      pp "RUN Qlite::qubic_list_applications"
      body = {command: 'qubic_list_applications', 'qubic handle': qubic_id}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # qubic_assembly_add	qaa	adds an oracle to the assembly as preparation for 'qubic_assemble'
    def qubic_assembly_add(qubic_id, oracle_id)
      pp "RUN Qlite::qubic_assembly_add"
      body = {command: 'qubic_assembly_add', 'qubic handle': qubic_id, "oracle id": oracle_id }
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # qubic_assemble	qa	publishes the assembly transaction for a specific qubic
    # TODO

    # qubic_test	qt	runs ql code locally (instead of over the tangle) to allow the author to quickly test whether it works as intended
    # TODO

    # qubic_quick_run	qqr	runs a minimalistic qubic (will not be added to the persistence), automates the full qubic life cycle to allow the author to quickly test whether the code works as intended. only one oracle will be added to the assembly.
    # TODO

    # oracle_create	oc	creates a new oracle and stores it in the persistence. life cycle will be automized, no need to do anything from here on
    def oracle_create(qubic_id)
      pp "RUN Qlite::oracle_create"
      body = {command: 'oracle_create', 'qubic id': qubic_id}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # oracle_delete	od	removes an oracle from the persistence (oracle's private key will be deleted: cannot be undone)
    # TODO

    # oracle_list	ol	prints the full list of all oracles stored in the persistence
    def oracle_list(oracle_id)
      pp "RUN Qlite::oracle_list"
      body = {command: 'oracle_list', 'oracle id': oracle_id}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # oracle_pause	op	temporarily stops an oracle from processing its qubic, can be undone with 'oracle_restart'
    # TODO

    # oracle_restart	or	restarts an oracle that was paused with 'oracle_pause', makes it process its qubic again
    # TODO

    # iam_create	ic	creates a new IAM stream and stores it in the persistence
    def iam_create
      pp "RUN Qlite::iam_create"
      body = {command: 'iam_create'}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # iam_delete	id	removes an IAM stream from the persistence (stream's private key will be deleted: cannot be undone)
    def iam_delete(iam_id)
      pp "RUN Qlite::iam_delete"
      body = {command: 'iam_delete', 'iam stream handle': iam_id}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # iam_list	il	prints the full list of all IAM streams stored in the persistence
    def iam_list
      pp "RUN Qlite::iam_list"
      body = {command: 'iam_list'}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # iam_write	iw	writes a message into the iam stream to a certain index
    def iam_write(iam_id, index, message)
      pp "RUN Qlite::iam_write"
      body = {command: 'iam_write', 'index': index, 'iam stream handle': iam_id, 'message': message}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # iam_read	ir	reads the message of an IAM stream at a certain index
    def iam_read(iam_id, index)
      pp "RUN Qlite::iam_read"
      body = {command: 'iam_read', 'iam id': iam_id, 'index': index}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # apps_list	al	prints the full list of all app installed
    def apps_list
      pp "RUN Qlite::apps_list"
      body = {command: 'apps_list'}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # app_install	ai	installs an app from an external source
    def app_install(app_url)
      pp "RUN Qlite::app_install"
      body = {command: 'app_install', url: app_url}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end

    # app_uninstall	au	uninstalls an app
    def app_uninstall(app_id)
      pp "RUN Qlite::app_uninstall"
      body = {command: 'app_uninstall', app: app_id}
      return send_request(body)
    rescue => e
      puts "failed #{e}"
    end


    private

    def send_request(body)
      qlite_node_uri = URI(@url)
      http = Net::HTTP.new(qlite_node_uri.host, qlite_node_uri.port)
      request = Net::HTTP::Post.new('/', 'Content-Type' => 'application/json', 'X-QLITE-API-Version' => '1')
      request.body = body.to_json
      res = http.request(request)
      return JSON.parse(res.body)
    end

    def setSettings(settings)
      settings = symbolize_keys(settings)
      @url = settings[:provider] ? settings[:provider] : "http://192.168.99.1:17733"
    end

    def symbolize_keys(hash)
      hash.inject({}){ |h,(k,v)| h[k.to_sym] = v; h }
    end
  end
end
