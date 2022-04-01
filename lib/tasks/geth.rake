namespace :geth do
  desc '[Optional] Import etherium blockchain data'
  task :import do
    destination = "#{Dir.pwd}/data/geth/rinkeby/geth"

    puts '----- Stoping geth service -----'
    sh 'docker-compose rm -fs geth'
    puts '----- Importing geth blockchain data -----'
    sh 'wget https://storage.googleapis.com/microkube-ethereum-node-chaindata-backups/ethdata_fullsync.tar.gz'
    sh "mkdir -p #{destination}"
    sh "tar -C #{destination} -zxvf ethdata_fullsync.tar.gz"
    sh 'rm -rf ethdata_fullsync.tar.gz'
    puts '----- Restarting geth service -----'
    sh 'docker-compose up -Vd geth'
  end

  task :export do
    puts '----- Exporting geth blockchain data -----'
    sh 'tar czf data/geth ethdata_fullsync.tar.gz'
  end
end